using System;
using AutoMapper;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;


namespace Travelo.Services
{
	public class AccomodationService : BaseCRUDService<Model.Accomodation, Database.Accommodation, AccomodationSearchObject, AccomodationCreateUpdateRequest, AccomodationCreateUpdateRequest>, IAccomodationService
	{
		public AccomodationService(TraveloContext context, IMapper mapper) : base(context,mapper)
		{ 

        }
	}
}

