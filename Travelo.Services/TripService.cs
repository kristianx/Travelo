using AutoMapper;
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
    public class TripService : BaseCRUDService<Model.Trip, Database.Trip, TripSearchObject, TripCreateRequest, TripUpdateRequest>, ITripService
    {
        public TripService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Trip> AddFilter(IQueryable<Trip> query, TripSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if(search.AgencyId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AgencyId == search.AgencyId);
            }
            if (!string.IsNullOrWhiteSpace(search.City))
            {
                filteredQuery = filteredQuery.Where(x => x.Accommodation.City.Name == search.City);
            }

            if (!string.IsNullOrWhiteSpace(search.Country))
            {
                filteredQuery = filteredQuery.Where(x => x.Accommodation.City.Country.Name == search.Country);
            }

            return filteredQuery;
        }

    }
}
