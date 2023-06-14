using System;
using AutoMapper;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;


namespace Travelo.Services
{
	public class AccomodationService : BaseCRUDService<Model.Accomodation, Database.Accommodation, AccomodationSearchObject, AccomodationCreateRequest, AccomodationUpdateRequest>, IAccomodationService
	{
		public AccomodationService(TraveloContext context, IMapper mapper) : base(context,mapper)
		{ 

        }
        public bool UpdateImage(AccommodationUpdateImageRequest update)
        {
            Database.Accommodation accomodation  = Context.Accommodations.FirstOrDefault(a => a.Id == update.AccomodationId);
            if (accomodation != null)
            {
                Context.Accommodations.FirstOrDefault(a => a.Id == update.AccomodationId).Images = update.Image;
                Context.SaveChanges();
                return true;
            }
            return false;
        }
    }
}

