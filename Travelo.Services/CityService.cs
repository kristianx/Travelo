using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class CityService : BaseCRUDService<Model.City, Database.City, CitySearchObject, CityCreateUpdateRequest, CityCreateUpdateRequest>, ICityService
    {
        public CityService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<City> AddInclude(IQueryable<City> query, CitySearchObject search = null)
        {
            query = query.Include("Country");
            return base.AddInclude(query, search);
        }
    }
}
