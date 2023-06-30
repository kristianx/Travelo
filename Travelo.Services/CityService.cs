using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Travelo.Services
{
    public class CityService : BaseCRUDService<Model.City, Database.City, CitySearchObject, CityCreateUpdateRequest, CityCreateUpdateRequest>, ICityService
    {
        public CityService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.City> AddInclude(IQueryable<Database.City> query, CitySearchObject search = null)
        {
            query = query.Include("Country");
            query = query.Include("Tags");

            return base.AddInclude(query, search);
        }
        public override IQueryable<Database.City> AddFilter(IQueryable<Database.City> query, CitySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search.Tag))
            {
                filteredQuery = filteredQuery.Where(x => x.Tags.Any(t => t.Name == search.Tag));
            }
            if (!string.IsNullOrWhiteSpace(search.Name))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.Contains(search.Name));
            }
            if (search.HasTrips)
            {
                filteredQuery = filteredQuery.Where(c => Context.TripItem.Any(x => x.Trip.Accommodation.CityId == c.Id));
            }

            return filteredQuery;
        }

        public override Model.City Create(CityCreateUpdateRequest create)
        {
            //Mapirati manuelno city
            //Database.City city = Mapper.Map<Database.City>(create);

            Database.City city = new Database.City
            {
                CountryId = create.CountryId,
                Name = create.Name,
                Image = create.Image,
                Country = Context.Country.First(x => x.Id == create.CountryId),

            };

            foreach (var tag in create.Tags)
            {
                var tg = Context.Tag.FirstOrDefault(x => x.Name == tag);
                if (tg == null)
                {
                    tg = new Database.Tag { Name = tag };
                    Context.Tag.Add(tg);
                    Context.SaveChanges();

                }
                city.Tags.Add(tg);

            };

            Context.City.Add(city);
            Context.SaveChanges();
            return Mapper.Map<Model.City>(city);
    
        }
        public IEnumerable<Model.City> GetDestinations(CitySearchObject search = null)
        {

            //IQueryable<Database.City> entity =
            //    Context.City.Where(c => Context.TripItem.Any(x => x.Trip.Accommodation.CityId == c.Id)).AsQueryable();
            var entity = Context.Set<Database.City>().AsQueryable();
            entity = AddFilter(entity, search);
            entity = entity.Include("Country");
            entity = entity.Include("Tags");

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                entity = entity.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = entity.ToList();

            IEnumerable<Model.City> cities = Mapper.Map<IEnumerable<Model.City>>(list);

            foreach(var city in cities)
            {
                IList<Database.TripItem> trips = Context.TripItem.Include(x => x.Trip).Include(x => x.Trip.Accommodation).Where(x => x.Trip.Accommodation.CityId == city.Id).ToList();
                if(trips.Count != 0)
                {
                    city.LowestTripPrice = trips.Min(x => x.PricePerPerson);
                    city.NumberOfTrips = trips.Count;
                }
            }

            return cities;
  
        }


    }
}
