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
            if (!string.IsNullOrWhiteSpace(search.TagName))
            {
                filteredQuery = filteredQuery.Where(x => x.Tags.Any(t => t.Name == search.TagName));
            }

            return filteredQuery;
        }
        public override IQueryable<Trip> AddInclude(IQueryable<Trip> query, TripSearchObject search = null)
        {
            query = query.Include("Accommodation");
            query = query.Include(x => x.Accommodation.City.Country);
            query = query.Include("Agency");
            return base.AddInclude(query, search);
        }
     
        public override IEnumerable<Model.Trip> Get(TripSearchObject search = null)
        {
            var trips = Context.Trip.Where(t => t.TripItems.Count > 0).AsQueryable();

            trips = AddFilter(trips, search);

            trips = AddInclude(trips, search);

            trips.Include(x => x.TripItems);

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                trips = trips.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }
           
            var list = trips.ToList();


            foreach (var trip in list)
            {
                trip.TripItems = Context.TripItem.Where(t => t.TripId == trip.Id).ToList();
            }

            return Mapper.Map<IEnumerable<Model.Trip>>(list);
        }

        public override Model.Trip GetById(int id)
        {
            Database.Trip trip = Context.Trip
               .Include(x => x.TripItems)
               .Include(x => x.Accommodation)
               .Include(x => x.Agency)
               .Include(x => x.Accommodation.Facilities)
               .Include(x => x.Accommodation.City.Country)
               .FirstOrDefault(t => t.Id == id);



            return Mapper.Map<Model.Trip>(trip);
        }

    }
}
