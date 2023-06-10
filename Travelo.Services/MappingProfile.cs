using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model.Requests;

namespace Travelo.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile() 
        {
            CreateMap<Database.Account, Model.Account>().ReverseMap();
            CreateMap<Database.Account, Model.Requests.AccountCreateUpdateRequest>().ReverseMap();


            CreateMap<Database.User, Model.User>().ForMember(d => d.Email, s => s.MapFrom(_ => _.Account.Email)).ReverseMap().ForAllMembers(m => m.Condition((source, target, sourceValue, targetValue) => sourceValue != null));
            CreateMap<UserCreateRequest, Database.User>().ForAllMembers(m => m.Condition((source, target, sourceValue, targetValue) => sourceValue != null));
            CreateMap<UserUpdateRequest, Database.User>()
                //.ForMember(d => d.CityId, s => s.MapFrom(_ => _.CityId))
                .ForAllMembers(m => m.Condition((source, target, sourceValue, targetValue) => sourceValue != null));

            CreateMap<Database.Agency, Model.Agency>()
                .ForMember(d => d.Email, s => s.MapFrom(_ => _.Account.Email))
                .ForMember(d => d.Location, s => s.MapFrom(_ => _.City.Name + ", " + _.City.Country.Name))
                .ForMember(d => d.CityName, s => s.MapFrom(_ => _.City.Name))
                .ReverseMap();
            CreateMap<AgencyCreateRequest, Database.Agency>().ReverseMap();
            CreateMap<AgencyUpdateRequest, Database.Agency>().ReverseMap();


            CreateMap<Database.Trip, Model.Trip>()
                .ForMember(d => d.AccomodationName, s => s.MapFrom(_ => _.Accommodation.Name))
                .ForMember(d => d.AccomodationImage, s => s.MapFrom(_ => _.Accommodation.Images))
                .ForMember(d => d.AccomodationDescription, s => s.MapFrom(_ => _.Accommodation.Description))
                .ForMember(d => d.Facilities, s => s.MapFrom(_ => _.Accommodation.Facilities.Select(f => f.Name).ToList()))
                .ForMember(d => d.Location, s => s.MapFrom(_ => _.Accommodation.LocationMap))
                .ForMember(d => d.AgencyId, s => s.MapFrom(_ => _.Agency.Id))
                .ForMember(d => d.AgencyName, s => s.MapFrom(_ => _.Agency.Name))
                .ForMember(d => d.AgencyImage, s => s.MapFrom(_ => _.Agency.Image))
                .ForMember(d => d.LowestPrice, s => s.MapFrom(_ => _.TripItems.OrderBy(t => t.PricePerPerson).FirstOrDefault()!.PricePerPerson))
                .ForMember(d => d.HighestPrice, s => s.MapFrom(_ => _.TripItems.OrderBy(t => t.PricePerPerson).LastOrDefault()!.PricePerPerson))
                .ForMember(d => d.Dates, s => s.MapFrom(_ => _.TripItems.OrderBy(t => t.PricePerPerson).FirstOrDefault()!.Dates))
                .ForMember(d => d.CityName, s => s.MapFrom(_ => _.Accommodation.City.Name))
                .ForMember(d => d.AllDates, s => s.MapFrom(_ => _.TripItems.Select(x=> x.Dates).ToList()))
                .ForMember(d => d.CountryName, s => s.MapFrom(_ => _.Accommodation.City.Country.Name))
                .ReverseMap();
            CreateMap<TripCreateRequest, Database.Trip>();
            CreateMap<TripUpdateRequest, Database.Trip> ();


            CreateMap<Database.TripItem, Model.TripItem>().ReverseMap();
            CreateMap<TripItemCreateUpdateRequest, Database.TripItem>();


            CreateMap<Database.City, Model.City>()
                .ForMember(d => d.CountryName, s => s.MapFrom(_ => _.Country.Name))
                .ForMember(d => d.Tags, s => s.MapFrom(_ => _.Tags.Select(x => x.Name).ToList()))
                .ReverseMap();
            //CreateMap<CityCreateUpdateRequest, Database.City>()
            //    .ForMember(d => d.CountryId, s => s.MapFrom(_ => _.CountryId))
            //    .ForMember(d => d.Name, s => s.MapFrom(_ => _.Name))
            //    .ForMember(d => d.Image, s => s.MapFrom(_ => _.Image))
            //    .ReverseMap();


            CreateMap<Database.Country, Model.Country>().ReverseMap();
            CreateMap<CountryCreateUpdateRequest, Database.Country>();


            //Get facilities and populate
            CreateMap<Database.Accommodation, Model.Accomodation>().ReverseMap();
            CreateMap<AccomodationCreateRequest, Database.Accommodation>();
            CreateMap<AccomodationUpdateRequest, Database.Accommodation>();

            CreateMap<Database.Reservation, Model.Reservation>()
                .ForMember(d => d.AgencyName, s => s.MapFrom(_ => _.Trip.Agency.Name))
                .ForMember(d => d.DestinationName, s => s.MapFrom(_ => _.Trip.Accommodation.City.Name))
                .ForMember(d => d.DestinationImage, s => s.MapFrom(_ => _.Trip.Accommodation.Images))
                .ForMember(d => d.CountryName, s => s.MapFrom(_ => _.Trip.Accommodation.City.Country.Name))
                .ForMember(d => d.Date, s => s.MapFrom(_ => _.TripItem.Dates))
                .ForMember(d => d.AccomodationName, s => s.MapFrom(_ => _.Trip.Accommodation.Name))
                .ForMember(d => d.CheckIn, s => s.MapFrom(_ => _.TripItem.CheckIn))
                .ForMember(d => d.CheckOut, s => s.MapFrom(_ => _.TripItem.CheckOut))
                .ReverseMap();
            CreateMap<ReservationCreateRequest, Database.Reservation>();
        }    
    }
}
