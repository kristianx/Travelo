using AutoMapper;
using Azure.Core;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
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
        public UserService(TraveloContext context, IMapper mapper, IAccountService accountService) : base(context, mapper)
        {
            _accountService = accountService;
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





    }
}
