using System;
using AutoMapper;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;


namespace Travelo.Services
{
	public class AccomodationService : BaseCRUDService<Model.Accomodation, Database.Accomodation, AccomodationSearchObject, AccomodationCreateRequest, AccomodationUpdateRequest>, IAccomodationService
	{
		public AccomodationService(TraveloContext context, IMapper mapper) : base(context,mapper)
		{ 

        }
        public bool UpdateImage(AccomodationUpdateImageRequest update)
        {
            Database.Accomodation accomodation  = Context.Accomodations.FirstOrDefault(a => a.Id == update.AccomodationId);
            if (accomodation != null)
            {
                Context.Accomodations.FirstOrDefault(a => a.Id == update.AccomodationId).Images = update.Image;
                Context.SaveChanges();
                return true;
            }
            return false;
        }
    }
}

