using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;
using Travelo.Services.Database;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CityController : BaseCRUDController<Model.City, CitySearchObject, CityCreateUpdateRequest, CityCreateUpdateRequest>
    {
        ICityService _service;
        public CityController(ICityService service) : base(service)
        {
            _service = service; 
        }

        [HttpGet("~/GetDestinations")]
        public IEnumerable<Model.City> GetDestinations([FromQuery] CitySearchObject search = null)
        {
            return _service.GetDestinations(search);
        }
        [AllowAnonymous]
        public override IEnumerable<Model.City> Get([FromQuery] CitySearchObject search = null)
        {
            return base.Get(search);
        }
    }
}
