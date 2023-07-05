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

    public class AgencyController : BaseCRUDController<Model.Agency, AgencySearchObject, AgencyCreateRequest, AgencyUpdateRequest>
    {
        IAgencyService _service;
        public AgencyController(IAgencyService service) : base(service)
        {
            _service = service;
        }


        [HttpPost]
        [AllowAnonymous]
        public override Model.Agency Create([FromBody] AgencyCreateRequest request)
        {
            return base.Create(request);
        }


        [HttpPost("~/Agency/UpdateImage")]
        public ActionResult UpdateImage([FromBody] AgencyUpdateImageRequest update)
        {
            if(_service.UpdateImage(update))
            {
            return Ok();
            }
            return BadRequest();

            
        }

        [AllowAnonymous]
        [HttpPost("Login")]
        public ActionResult<string> Login([FromBody] AgencyLogin agencylogin)
        {
            int? id = _service.Login(agencylogin);
            if (id != null)
            {
                return Ok(id);
            }
            return BadRequest("User not found");

        }

     



    }
}
