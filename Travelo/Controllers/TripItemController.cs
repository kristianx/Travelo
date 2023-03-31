using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [AllowAnonymous]
    [ApiController]
    [Route("[controller]")]
    public class TripItemController : BaseCRUDController<Model.TripItem, TripItemSearchObject, TripItemCreateUpdateRequest, TripItemCreateUpdateRequest>
    {
        public TripItemController(ITripItemService service) : base(service)
        {
        }

    }
}
