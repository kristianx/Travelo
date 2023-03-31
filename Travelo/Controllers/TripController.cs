using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;
using Travelo.Services.Database;

namespace Travelo.Controllers
{
    [AllowAnonymous]
    [ApiController]
    [Route("[controller]")]
    public class TripController : BaseCRUDController<Model.Trip, TripSearchObject, TripCreateRequest, TripUpdateRequest>
    {
        public TripController(ITripService service) : base(service)
        {
        }

        //[HttpGet]
        //public IEnumerable<Model.Trip> GetByTagName([FromBody] string tagName)
        //{
        //    return _service.GetByTagName(tagName);
        //}

        //public override IEnumerable<Model.Trip> Get([FromQuery] TripSearchObject search = null)
        //{
        //    //IEnumerable <Model.Trip> trips =  base.Get(search);
        //    //foreach (var trip in trips)
        //    //{
        //    //    trip.Tags = _service.GetTags(trip.Id);
        //    //}
        //    //return trips;
        //}
    }
}
