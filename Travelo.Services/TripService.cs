﻿using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
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

        public override IQueryable<Database.Trip> AddFilter(IQueryable<Database.Trip> query, TripSearchObject search = null)
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
            if (search.hasItems)
            {
                filteredQuery = filteredQuery.Where(x => x.TripItems.Count > 0);
            }

            return filteredQuery;
        }
        public override IQueryable<Database.Trip> AddInclude(IQueryable<Database.Trip> query, TripSearchObject search = null)
        {
            query = query.Include("Accommodation");
            query = query.Include(x => x.Accommodation.City.Country);
            query = query.Include(x => x.Accommodation.Facilities);
            query = query.Include("Agency");
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
                    .ThenInclude(c => c.Accommodation.City.Country)
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
            Database.Trip trip = Context.Trip
               .Include(x => x.TripItems)
               .Include(x => x.Accommodation)
               .Include(x => x.Agency)
               .Include(x => x.Accommodation.Facilities)
               .Include(x => x.Accommodation.City.Country)
               .FirstOrDefault(t => t.Id == id);



            return Mapper.Map<Model.Trip>(trip);
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

        public async Task<List<Model.Trip>> Recommend(int id)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();
                    var tmpData = Context.Reservation.Include(r => r.Trip).Include(r => r.User).ToList();
                    var data = new List<TripEntry>();

                    foreach(var x in tmpData)
                    {
                        data.Add(new TripEntry()
                        {
                            UserId = (uint)x.User.Id,
                            AgencyId = (uint)x.Trip.AgencyId
                        });
                    }

                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(TripEntry.UserId);
                    options.MatrixRowIndexColumnName = nameof(TripEntry.AgencyId);
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

            var trips = Context.Trip
                .Include(t => t.Accommodation.City.Country)
                .Include(t => t.Agency)
                .Include(t => t.Accommodation.Facilities)
                .Where(t => t.Id != id);

            var predictionResult = new List<Tuple<Database.Trip, float>>();

            foreach(var t in trips)
            {
                var predictionengine = mlContext.Model.CreatePredictionEngine<TripEntry, Purchase_prediction>(model);
                var prediction = predictionengine.Predict(
                                         new TripEntry()
                                         {
                                             UserId = (uint)id,
                                             AgencyId = (uint)t.AgencyId
                                         });
                predictionResult.Add(new Tuple<Database.Trip, float>(t, prediction.Score));

            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return Mapper.Map<List<Model.Trip>>(finalResult);
           
        } 

    }

    public class Purchase_prediction
    {
        public float Score { get; set; }
    }
    public class TripEntry
    {
        [KeyType(count:10)]
        public uint UserId { get; set; }

        [KeyType(count: 10)]
        public uint AgencyId { get; set; }

        public float Label { get; set; }


    }

}
