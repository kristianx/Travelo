using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Travelo.Services
{
    public class TripService : BaseCRUDService<Model.Trip, Database.Trip, TripSearchObject, TripCreateRequest, TripUpdateRequest>, ITripService
    {
        public TripService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override Model.Trip Create(TripCreateRequest create)
        {

            var trip = base.Create(create);

            if(trip != null) {

                try {
                    var factory = new ConnectionFactory { HostName = "localhost" };
                    using var connection = factory.CreateConnection();
                    using var channel = connection.CreateModel();


                    string message = "New trip:";


                    var body = Encoding.UTF8.GetBytes(message);

                    channel.BasicPublish(exchange: string.Empty,
                                         routingKey: "trip_added",
                                         basicProperties: null,
                                         body: body);
                }
                catch (Exception ex) {
                    Console.WriteLine($"An error occurred while sending message to RabbitMQ: {ex.Message}");
                   
                }

               

            }
         

            return trip;
        }

        public override IQueryable<Database.Trip> AddFilter(IQueryable<Database.Trip> query, TripSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if(search.AgencyId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AgencyId == search.AgencyId);
            }
            if (!string.IsNullOrWhiteSpace(search.City))
            {
                filteredQuery = filteredQuery.Where(x => x.Accomodation.City.Name == search.City);
            }

            if (!string.IsNullOrWhiteSpace(search.Country))
            {
                filteredQuery = filteredQuery.Where(x => x.Accomodation.City.Country.Name == search.Country);
            }

            if (!string.IsNullOrWhiteSpace(search.AccomodationName))
            {
                filteredQuery = filteredQuery.Where(x => x.Accomodation.Name.Contains(search.AccomodationName));
            }
            //if (!string.IsNullOrWhiteSpace(search.TagName))
            //{
            //    filteredQuery = filteredQuery.Where(x => x.Tags.Any(t => t.Name == search.TagName));
            //}
            if (search.hasItems)
            {
                filteredQuery = filteredQuery.Where(x => x.TripItems.Count > 0);
            }

            return filteredQuery;
        }


        public override IQueryable<Database.Trip> AddInclude(IQueryable<Database.Trip> query, TripSearchObject search = null)
        {
            query = query.Include("Accomodation");
            query = query.Include(x => x.Accomodation.City.Country);
            query = query.Include(x => x.Accomodation.Facilities);
            query = query.Include("Agency");
            query = query.Include(x => x.Ratings);

            return base.AddInclude(query, search);
        }
     
        public override IEnumerable<Model.Trip> Get(TripSearchObject search = null)
        {
            var trips = Context.Trip.AsQueryable();

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

        public IEnumerable<Model.Trip> GetBookmarks(int userId)
        {

            var user  =
                Context.User
                .Include(u => u.Trips)
                    .ThenInclude(c => c.Agency)
                .Include(u => u.Trips)
                    .ThenInclude(c => c.Accomodation.City.Country)
                .Include(u => u.Trips)
                    .ThenInclude(c => c.TripItems)
                .FirstOrDefault(u => u.Id == userId);

            IEnumerable<Database.Trip> list = user.Trips.AsQueryable();

            if (list != null)
            {
            return Mapper.Map<IEnumerable<Model.Trip>>(list);

            }
            throw new Exception("There was an error catching bookmarks.");
        }

        public override Model.Trip GetById(int id)
        {
            Database.Trip? trip = Context.Trip
               .Include(x => x.TripItems)
               .Include(x => x.Accomodation)
               .Include(x => x.Agency)
               .Include(x => x.Accomodation.Facilities)
               .Include(x => x.Accomodation.City.Country)
                   .Include(x => x.Ratings)
               .FirstOrDefault(t => t.Id == id);



            return Mapper.Map<Model.Trip>(trip);
        }

        public bool AddRating(int userId, int tripId, double rating)
        {

            var user = Context.User.FirstOrDefault(x => x.Id == userId);
            var trip = Context.Trip.FirstOrDefault(x => x.Id == tripId);

            if (user != null && trip != null)
            {
                var rat = Context.Rating.Where(r => r.UserId == userId && r.TripId == tripId).FirstOrDefault();
                if (rat == null) {
                    Context.Rating.Add(
                 new Rating
                 {

                     TripId = tripId,
                     RatingScore = rating,
                     TimeOfRating = DateTime.Now,
                     UserId = userId
                 }
                );
                    Context.SaveChanges();
                    return true;
                }
                else {
                    return false;
                }
              
            }
            else
            {
                return false;
            }





        }

        public bool ToggleBookmark(int tripId, int userId)
        {
            var trip = Context.Trip.Find(tripId);
            var user = Context.User.Include(x => x.Trips).First(x=> x.Id == userId);
            if (user != null && trip != null)
            {
                if(user.Trips.Any(x => x.Id == trip.Id))
                {
                    user.Trips.Remove(trip);
                    Context.SaveChanges();
                    return false;
                }
                else
                {
                    user.Trips.Add(trip);
                    Context.SaveChanges();
                    return true;
                }
               

            }
            throw new Exception("Not able to process.");
        }


        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public async Task<List<Model.Trip>> Recommend(int userId, int tripId)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var data = Context.Rating.Select(r => new TripEntry {
                        TripId = (uint)r.TripId,
                        UserId = (uint)r.UserId,
                        Label = (float)r.RatingScore,
                    }).ToList();


                    var traindata = mlContext.Data.LoadFromEnumerable(data);


                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(TripEntry.TripId);
                    options.MatrixRowIndexColumnName = nameof(TripEntry.UserId);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(traindata);

                }

                
            }
            //prediction



            List<Database.Trip> trips = Context.Trip
               .Include(x => x.TripItems)
               .Include(x => x.Agency)
               .Include(x => x.Accomodation.Facilities)
               .Include(x => x.Accomodation.City.Country)
               .Where(t => t.Id != tripId)
               .ToList();

            var predictionResult = new List<Tuple<Database.Trip, float>>();

            foreach(Database.Trip t in trips)
            {
                var predictionengine = mlContext.Model.CreatePredictionEngine<TripEntry, TripRatingPrediction>(model);
                var prediction = predictionengine.Predict(
                                         new TripEntry()
                                         {
                                             UserId = (uint)userId,
                                             TripId = (uint)t.Id,
                                           
                                         });
                predictionResult.Add(new Tuple<Database.Trip, float>(t, prediction.Score));

            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return Mapper.Map<List<Model.Trip>>(finalResult);


        }

    }

    public class TripRatingPrediction
    {
        public float Score { get; set; }
        public float Label { get; set; }
    }

    public class TripEntry
    {
        [KeyType(count:10)]
        public uint UserId { get; set; }

        [KeyType(count: 10)]
        public uint TripId { get; set; }

        public float Label { get; set; }


    }



}
