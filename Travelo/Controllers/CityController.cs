using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CityController : BaseCRUDController<Model.City, CitySearchObject, CityCreateUpdateRequest, CityCreateUpdateRequest>
    {
        public CityController(ICityService service) : base(service)
        {
        }
        [HttpGet]
        [AllowAnonymous]
        public override IEnumerable<City> Get([FromQuery] CitySearchObject search = null)
        {
            return base.Get(search);
        }

    }
}
