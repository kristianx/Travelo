using System;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class PasosService : BaseCRUDService<Model.Pasos, Database.FITPasos, PasosSearchObject, PasosCreateUpdateRequest, PasosCreateUpdateRequest>, IPasosService
    {
        public PasosService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<FITPasos> AddInclude(IQueryable<FITPasos> query, PasosSearchObject search = null)
        {
            query = query.Include(x => x.User);
      

            return base.AddInclude(query, search);
        }
        public override IQueryable<FITPasos> AddFilter(IQueryable<FITPasos> query, PasosSearchObject search = null)
        {

            var filteredQuery = base.AddFilter(query, search);


            if (search.UserId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.UserId == search.UserId);
            }

            if (search.DateIssued != null && search.DateIssued != "null")
            {
                filteredQuery = filteredQuery.Where(x => x.DateIssued < DateTime.Parse(search.DateIssued));
            }

            return filteredQuery;
        }
        public override Pasos Create(PasosCreateUpdateRequest create)
        {
            Database.User user = Context.User.FirstOrDefault(x => x.Id == create.UserId);
            if(user != null)
            {
                Database.FITPasos pasos = new Database.FITPasos
                {
                    DateIssued = DateTime.Parse(create.DateIssued),
                    UserId = create.UserId,
                    Valid = create.Valid,
                    
                    User = user
                };
                Context.FITPasos.Add(pasos);

                Context.SaveChanges();
                return Mapper.Map<Model.Pasos>(pasos);

            }


            return null;


        }
    }
}

