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
        ITripService _service; 
        public TripController(ITripService service) : base(service)
        {
            _service = service;
        }

        
        [HttpGet("/Trip/Bookmarks/{userId}")]
        public IEnumerable<Model.Trip> GetBookmarks(int userId)
        {
            return _service.GetBookmarks(userId);
        }

        [HttpPost("~/ToggleBookmark")]
        public ActionResult<bool> ToggleBookmark(int tripId, int userId)
        {
            return Ok(_service.ToggleBookmark(tripId, userId));
        }

        [HttpGet("/{id}/recommend")]
        public async Task<IEnumerable<Model.Trip>> RecommendAsync(int id)
        {
            return await _service.Recommend(id);
        }



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
