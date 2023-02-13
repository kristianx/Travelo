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


            CreateMap<Database.Trip, Model.Trip>().ReverseMap();
            CreateMap<TripCreateRequest, Database.Trip>();
            CreateMap<TripUpdateRequest, Database.Trip> ();


            CreateMap<Database.City, Model.City>().ForMember(d => d.CountryName, s => s.MapFrom(_ => _.Country.Name)).ReverseMap();
            CreateMap<CityCreateUpdateRequest, Database.Trip>();

            CreateMap<Database.Country, Model.Country>().ReverseMap();
            CreateMap<CountryCreateUpdateRequest, Database.Country>();
        }    
    }
}
