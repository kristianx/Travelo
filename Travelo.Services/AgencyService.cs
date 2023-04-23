using AutoMapper;
using Azure.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class AgencyService : BaseCRUDService<Model.Agency, Database.Agency, AgencySearchObject, AgencyCreateUpdateRequest, AgencyCreateUpdateRequest>, IAgencyService
    {
        private readonly IAccountService _accountService;
        public AgencyService(TraveloContext context, IMapper mapper, IAccountService accountService) : base(context, mapper)
        {
            _accountService = accountService;
        }
     

        public override Model.Agency Create(AgencyCreateUpdateRequest create)
        {

            //Validation
            if(create.ConfirmPassword != create.Password)
            {
                throw new Exception("Password does not match!");
            }

            var agency = Mapper.Map<Database.Agency>(create);

            create.Role = Role.Agency;
            var accountId = _accountService.Create(create).Id;


            agency.AccountId = accountId;
            agency.Status = true;

            Context.Agency.Add(agency);
            Context.SaveChanges();

            
            return Mapper.Map<Model.Agency>(agency);

        }
        public override IEnumerable<Model.Agency> Get(AgencySearchObject search = null)
        {
            return base.Get(search);
        }
        public override IQueryable<Database.Agency> AddInclude(IQueryable<Database.Agency> query, AgencySearchObject search = null)
        {
            query = query.Include("Account");

            return base.AddInclude(query, search);
        }

        //public Model.Agency Update(int id, AgencyCreateUpdateRequest update)
        //{
        //    throw new NotImplementedException();
        //}

        public override IQueryable<Database.Agency> AddFilter(IQueryable<Database.Agency> query, AgencySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Name))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.Contains(search.Name));
            }

            return filteredQuery;
        }
        public bool UpdateImage(AgencyUpdateImageRequest update)
        {
            Database.Agency agency = Context.Agency.FirstOrDefault(a => a.Id == update.AgencyId);
            if(agency != null)
            {
                Context.Agency.FirstOrDefault(a => a.Id == update.AgencyId).Image = update.Image;
                Context.SaveChanges();
                return true;
            }
            return false;
        }
    }
}
