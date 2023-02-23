using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AccommodationController : BaseCRUDController<Model.Accomodation, AccomodationSearchObject, AccomodationCreateUpdateRequest, AccomodationCreateUpdateRequest>
    {
        public AccommodationController(IAccomodationService service) : base(service)
        {
        }
    }
}

