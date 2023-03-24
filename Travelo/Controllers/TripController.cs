using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
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

        //[HttpGet]
        //public IEnumerable<Model.Trip> GetByTagName([FromBody] string tagName)
        //{
        //    return _service.GetByTagName(tagName);
        //}
    }
}
