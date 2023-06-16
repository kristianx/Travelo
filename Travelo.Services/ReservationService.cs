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

namespace Travelo.Services
{
    public class ReservationService : BaseCRUDService<Model.Reservation, Database.Reservation, ReservationSearchObject, ReservationCreateRequest, object>, IReservationService
    {
        public ReservationService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override void BeforeCreate(ReservationCreateRequest create, Database.Reservation entity)
        {
            entity.Trip = Context.Trip.First(x => x.Id == create.TripId);
            entity.TripItem = Context.TripItem.First(x => x.Id == create.TripItemId);
            entity.User = Context.User.First(x => x.Id == create.UserId);
            entity.Price = entity.Price * (entity.NumberOfAdults + entity.NumberOfChildren);
            
        }
        public override IQueryable<Database.Reservation> AddFilter(IQueryable<Database.Reservation> query, ReservationSearchObject search = null)
        {

            var filteredQuery = base.AddFilter(query, search);

            if (search.UserId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.User.Id == search.UserId);
            }
            
            if (search.AgencyId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Trip.AgencyId == search.AgencyId);
            }


            return filteredQuery;
        }
        public override IQueryable<Database.Reservation> AddInclude(IQueryable<Database.Reservation> query, ReservationSearchObject search = null)
        {
            query = query.Include(a => a.Trip.Accommodation.City.Country);
            query = query.Include(a => a.Trip.Agency);
            query = query.Include(a => a.TripItem);
            return base.AddInclude(query, search);
        }


        public List<DailyReservationInfo> GetDailyReservations(GetReservationDaily search)
        {
            var startDate = new DateTime(search.Year, search.Month, 1);
            var endDate = startDate.AddMonths(1).AddDays(-1);

            var reservationInfo = Context.Reservation.Include(r => r.Trip).Where(r => r.TimeOfReservation >= startDate && r.TimeOfReservation <= endDate && r.Trip.AgencyId == search.AgencyId)
                .GroupBy(r => r.TimeOfReservation.Date)
                .Select(g => new DailyReservationInfo
                {
                    Date = g.Key,
                    Count = g.Count(),
                    TotalPrice = g.Sum(r => r.Price)

                })
                .ToList();

            // Fill in missing dates with 0 reservation count and total price
            var allDates = Enumerable.Range(0, endDate.Subtract(startDate).Days + 1)
                .Select(offset => startDate.AddDays(offset))
                .ToList();

            var result = new List<DailyReservationInfo>();

            foreach (var date in allDates)
            {
                var info = reservationInfo.FirstOrDefault(r => r.Date == date) ??
                    new DailyReservationInfo
                    {
                        Date = date,
                        Count = 0,
                        TotalPrice = 0
                    };
               
                result.Add(info);
            }

            return result;

        }


        //public override IEnumerable<Model.Reservation> Get(ReservationSearchObject search = null)
        //{
        //    var entity = Context.Set<Database.Reservation>().AsQueryable();

        //    entity = AddFilter(entity, search);

        //    entity = AddInclude(entity, search);

        //    if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
        //    {
        //        entity = entity.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
        //    }

        //    var list = entity.ToList();

        //    return Mapper.Map<IEnumerable<T>>(list);
        //}
    }
}
