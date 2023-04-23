using AutoMapper;
using Azure.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class AccountService : BaseCRUDService<Model.Account, Database.Account, AccountSearchObject, AccountCreateUpdateRequest, AccountCreateUpdateRequest>, IAccountService
    {
       
        public AccountService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }
        //public override void BeforeCreate(AccountCreateUpdateRequest create, Database.Account entity)
        //{
        //    var salt = GenerateSalt();
        //    entity.PasswordSalt = salt;
        //    entity.PasswordHash = GenerateHash(salt, create.Password);

        //    base.BeforeCreate(create, entity);
        //}
        public override Model.Account Create(AccountCreateUpdateRequest create)
        {
            if (Context.Account.Where(a => a.Email == create.Email).Any())
            {
                throw new UserException("Email is taken.");
            }
            if (create.Password != create.ConfirmPassword)
            {
                throw new UserException("Passwords do not match.");
            }

            Database.Account account = Mapper.Map<Database.Account>(create);

            var salt = GenerateSalt();
            account.PasswordSalt = salt;
            account.PasswordHash = GenerateHash(salt, create.Password);

            Context.Account.Add(account);
            Context.SaveChanges();

            return Mapper.Map<Model.Account>(account);

        }

        public override IQueryable<Database.Account> AddFilter(IQueryable<Database.Account> query, AccountSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (!string.IsNullOrWhiteSpace(search.Email))
            {
                filteredQuery = filteredQuery.Where(x => x.Email.Contains(search.Email));
            }
            return filteredQuery;
        }

        public static string GenerateSalt()
        {
            //var buf = new byte[16];
            //(new RSACryptoServiceProvider()).GetBytes(buf);
            //return Convert.ToBase64String(buf);
            return Convert.ToBase64String(new byte[16]);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public Model.Account Login(string email, string password, Role role)
        {
            var entity = Context.Account.FirstOrDefault(x => x.Email == email);
            if (entity == null)
            {
                return null;
            }
            //if(entity.Role != role)
            //{
            //    return null;
            //}
            var hash = GenerateHash(entity.PasswordSalt, password);
            if (hash != entity.PasswordHash)
            {
                throw new UserException("Not a valid email or password.");
            }
            return Mapper.Map<Model.Account>(entity);
        }
    }
}
