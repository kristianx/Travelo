using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;
using Travelo.Services.Database;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]

    public class AgencyController : BaseCRUDController<Model.Agency, AgencySearchObject, AgencyCreateUpdateRequest, AgencyCreateUpdateRequest>
    {
        IAgencyService _service;
        public AgencyController(IAgencyService service) : base(service)
        {
            _service = service;
        }


        [HttpPost]
        [AllowAnonymous]
        public override Model.Agency Create([FromBody] AgencyCreateUpdateRequest request)
        {
            return base.Create(request);
        }


        [HttpPost("~/UpdateImage")]
        public ActionResult UpdateImage([FromBody] AgencyUpdateImageRequest update)
        {
            if(_service.UpdateImage(update))
            {
            return Ok();
            }
            return BadRequest();

            
        }
    }
}
