using Microsoft.AspNetCore.Mvc;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;
using Travelo.Services.Database;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TripController : BaseCRUDController<Model.Trip, TripSearchObject, TripCreateRequest, TripUpdateRequest>
    {
        public TripController(ITripService service) : base(service)
        {
        }
    }
}
