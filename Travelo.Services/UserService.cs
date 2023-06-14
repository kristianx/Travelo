using AutoMapper;
using Azure.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class UserService : BaseCRUDService<Model.User, Database.User, UserSearchObject, UserCreateRequest, UserUpdateRequest>, IUserService
    {
        private readonly IAccountService _accountService;
        private readonly IConfiguration _configuration;

        public UserService(TraveloContext context, IMapper mapper, IAccountService accountService, IConfiguration configuration
            ) : base(context, mapper)
        {
            _accountService = accountService;
            _configuration = configuration;
        }
        public override Model.User Create(UserCreateRequest create)
        {
            var user = Mapper.Map<Database.User>(create);
            
            create.Role = Role.Traveler;
            var accountId = _accountService.Create(create).Id;

            user.AccountId = accountId;
            user.Status = true;

            Context.User.Add(user);
            Context.SaveChanges();

            return Mapper.Map<Model.User>(user);
        }
        public override IQueryable<Database.User> AddFilter(IQueryable<Database.User> query, UserSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if(!string.IsNullOrWhiteSpace(search.Username))
            {
                filteredQuery = filteredQuery.Where(x => x.Username.Contains(search.Username));
            }
            if (!string.IsNullOrWhiteSpace(search.FirstName))
            {
                filteredQuery = filteredQuery.Where(x => x.FirstName.Contains(search.FirstName));
            }
            if (!string.IsNullOrWhiteSpace(search.LastName))
            {
                filteredQuery = filteredQuery.Where(x => x.LastName.Contains(search.LastName));
            }
            return filteredQuery;
        }
        public override IQueryable<Database.User> AddInclude(IQueryable<Database.User> query, UserSearchObject search = null)
        {
            query = query.Include("Account");

            return base.AddInclude(query, search);
        }

        public int? Login(UserLogin userLogin)
        {
            Model.Account acc = _accountService.Login(userLogin.Email, userLogin.Password, Role.Traveler);

            if(acc != null)
            {
                Database.User? user = Context.User.Single(us => us.AccountId == acc.Id);
                if (user != null)
                {
                    return user.Id;
                }
            }
            return null;

        }
        private string CreateToken(Model.Account user)
        {
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Role, user.Role.ToString()),
       
            };
            var key = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(_configuration.GetSection("AppSettings:Token").Value));

            var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.Now.AddDays(10),
                signingCredentials: credentials
                );
            var jwt = new JwtSecurityTokenHandler().WriteToken(token);
            return jwt;
        }

        public Model.User UploadImage(UserUploadImageRequest request)
        {
            var set = Context.Set<Database.User>();
            var user = set.Find(request.UserId);
            //var user = Context.User.FirstOrDefault(u => u.Id == request.UserId);
            if(user != null && request.Image != null)
            {
                user.Image = request.Image;
                Context.SaveChanges();
                return Mapper.Map<Model.User>(user); 
            }
            return null;
        }

        public override Model.User Update(int id, UserUpdateRequest update)
        {

            Model.Account acc = _accountService.Login(update.Email, update.OldPassword, Role.Traveler);

            if(acc != null && acc.Id == id)
            {

                var user = Context.User.Include(x => x.Account).FirstOrDefault(x=> x.Id == id);

                if (user != null)
                {
                    Mapper.Map(update, user);
                    Context.SaveChanges();
                    if (update.NewPassword != null)
                    {
                        _accountService.updatePassword(id, update.NewPassword);
                    }
                }
                else
                {
                    return null;

                }

                

                return Mapper.Map<Model.User>(user);
            }

            return null;
        }

     
    }
}
