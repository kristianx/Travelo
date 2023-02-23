using System;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;

namespace Travelo.Services
{
	public interface IAccomodationService : ICRUDService<Model.Accomodation, AccomodationSearchObject, AccomodationCreateUpdateRequest, AccomodationCreateUpdateRequest>
    {

	}
}

