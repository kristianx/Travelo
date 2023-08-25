using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
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
        private readonly IMessageProducer _messageProducer;
        public ReservationService(TraveloContext context, IMapper mapper, IMessageProducer messageProducer) : base(context, mapper)
        {
            _messageProducer = messageProducer;
        }
        public override void BeforeCreate(ReservationCreateRequest create, Database.Reservation entity)
        {
            entity.Trip = Context.Trip.First(x => x.Id == create.TripId);
            entity.TripItem = Context.TripItem.First(x => x.Id == create.TripItemId);
            entity.User = Context.User.First(x => x.Id == create.UserId);
            entity.Price = entity.Price * (entity.NumberOfAdults + entity.NumberOfChildren);
            
        }
        public override Model.Reservation Create(ReservationCreateRequest create)
        {
            Model.Reservation res =  base.Create(create);
            if(res != null)
            {
                _messageProducer.SendingObject(res);
            }
            return res;
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
        public override IEnumerable<Model.Reservation> Get(ReservationSearchObject search = null)
        {
            if(search.UserId != null) {
                IEnumerable<Model.Reservation> reservations = base.Get(search);
                foreach(var res in reservations) {
                    var review = Context.Rating.Where(r => r.UserId == search.UserId && r.TripId == res.TripId).FirstOrDefault();
                    res.reviewLeaved = review != null ? review.RatingScore : -1.0;
                }
                return reservations;
            }
            return base.Get(search);
        }
        public override IQueryable<Database.Reservation> AddInclude(IQueryable<Database.Reservation> query, ReservationSearchObject search = null)
        {
            query = query.Include(a => a.Trip.Accomodation.City.Country);
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

     

        public List<BestCustomers> GetBestCustomers(int AgencyId)
        {
            var usersByReservations = Context.Reservation
                .Include(r => r.Trip)
                .Include(r => r.User)
                .Where(r => r.Trip.AgencyId == AgencyId)
                .GroupBy(r => r.User.Id)
                .Select(g => new
                {
                    UserId = g.Key,
                    NumberOfReservations = g.Count()
                })
                .OrderByDescending(g => g.NumberOfReservations);


            var result = from u in Context.User
                         join r in usersByReservations on u.Id equals r.UserId
                         orderby r.NumberOfReservations descending
                         select new
                         {
                             u.Id,
                             u.FirstName,
                             u.LastName,
                             u.Image,
                             r.NumberOfReservations
                         };
            List<BestCustomers> bestCustomers = new List<BestCustomers>();
            foreach (var user in result)
            {
                bestCustomers.Add(new BestCustomers
                {
                    UserId = user.Id,
                    Image = user.Image,
                    CustomerName = user.FirstName + " " + user.LastName,
                    NumberOfTrips = user.NumberOfReservations

                });

            }
            return bestCustomers;
        }

        public List<BestAccomodations> GetBestAccomodations(int AgencyId)
        {
            return Context.Reservation
                 .Include(a => a.Trip.Accomodation)
                 .Where(r => r.Trip.AgencyId == AgencyId)
                 .GroupBy(r => r.Trip.AccomodationId)
                 .Select(g => new BestAccomodations
                 {
                     AccommodationName = g.FirstOrDefault().Trip.Accomodation.Name,
                     TripId = g.Key,
                     TotalPrice = g.Sum(r => r.Price)
                 })
                 .OrderByDescending(a => a.TotalPrice)
                 .ToList();
        }
    }
}
