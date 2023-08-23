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

        [HttpPost("~/Trip/ToggleBookmark")]
        public ActionResult<bool> ToggleBookmark(int tripId, int userId)
        {
            return Ok(_service.ToggleBookmark(tripId, userId));
        }

        [HttpPost("~/Trip/AddRating")]
        public ActionResult AddRating(int userId, int tripId, double rating)
        {
            if (_service.AddRating(userId, tripId, rating))
            {
                return Ok();
            }
            return BadRequest();


        }

        [HttpGet("~/Trip/{id}/recommend")]
        public async Task<IEnumerable<Model.Trip>> RecommendAsync(int id, int userId)
        {
            return await _service.Recommend( userId,  id);
        }


    }
}
