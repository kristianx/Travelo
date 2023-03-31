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
            query = query.Include("Tags");

            return base.AddInclude(query, search);
        }
        public override IQueryable<City> AddFilter(IQueryable<City> query, CitySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search.Tag))
            {
                filteredQuery = filteredQuery.Where(x => x.Tags.Any(t => t.Name == search.Tag));
            }
            return filteredQuery;
        }



    }
}
