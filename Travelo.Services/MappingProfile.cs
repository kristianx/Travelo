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


            CreateMap<Database.User, Model.User>().ForMember(d => d.Email, s => s.MapFrom(_ => _.Account.Email)).ReverseMap();
            CreateMap<UserCreateRequest, Database.User>();
            CreateMap<UserUpdateRequest, Database.User>();


            CreateMap<Database.Agency, Model.Agency>().ForMember(d => d.Email, s => s.MapFrom(_ => _.Account.Email)).ReverseMap();
            CreateMap<AgencyCreateUpdateRequest, Database.Agency>();


            CreateMap<Database.Trip, Model.Trip>()
                .ForMember(d => d.AccomodationName, s => s.MapFrom(_ => _.Accommodation.Name))
                .ForMember(d => d.AccomodationImage, s => s.MapFrom(_ => _.Accommodation.Images))
                .ForMember(d => d.AccomodationDescription, s => s.MapFrom(_ => _.Accommodation.Description))
                .ForMember(d => d.Facilities, s => s.MapFrom(_ => _.Accommodation.Facilities.Select(f => f.Name).ToList()))
                .ForMember(d => d.Location, s => s.MapFrom(_ => _.Accommodation.LocationMap))
                .ForMember(d => d.AgencyId, s => s.MapFrom(_ => _.Agency.Id))
                .ForMember(d => d.AgencyName, s => s.MapFrom(_ => _.Agency.Name))
                .ForMember(d => d.AgencyImage, s => s.MapFrom(_ => _.Agency.Image))
                .ForMember(d => d.LowestPrice, s => s.MapFrom(_ => _.TripItems.OrderBy(t => t.PricePerPerson).FirstOrDefault()!.PricePerPerson * _.TripItems.OrderBy(t => t.PricePerPerson).FirstOrDefault().NightsStay))
                .ForMember(d => d.Dates, s => s.MapFrom(_ => _.TripItems.OrderBy(t => t.PricePerPerson).FirstOrDefault()!.Dates))
                .ReverseMap();
            CreateMap<TripCreateRequest, Database.Trip>();
            CreateMap<TripUpdateRequest, Database.Trip> ();


            CreateMap<Database.TripItem, Model.TripItem>().ReverseMap();
            CreateMap<TripItemCreateUpdateRequest, Database.TripItem>();


            CreateMap<Database.City, Model.City>()
                .ForMember(d => d.CountryName, s => s.MapFrom(_ => _.Country.Name))
                .ForMember(d => d.Tags, s => s.MapFrom(_ => _.Tags.Select(x => x.Name).ToList()))
                .ReverseMap();
            CreateMap<CityCreateUpdateRequest, Database.Trip>();


            CreateMap<Database.Country, Model.Country>().ReverseMap();
            CreateMap<CountryCreateUpdateRequest, Database.Country>();


            //Get facilities and populate
            CreateMap<Database.Accommodation, Model.Accomodation>().ReverseMap();
            CreateMap<AccomodationCreateUpdateRequest, Database.Accommodation>();
        }    
    }
}
