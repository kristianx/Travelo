using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AccomodationController : BaseCRUDController<Model.Accomodation, AccomodationSearchObject, AccomodationCreateRequest, AccomodationUpdateRequest>
    {
        IAccomodationService _service;
        public AccomodationController(IAccomodationService service) : base(service)
        {
            _service = service;
        }
        [HttpPost("~/Accomodation/UpdateImage")]
        public ActionResult UpdateImage([FromBody] AccomodationUpdateImageRequest update)
        {
            if (_service.UpdateImage(update))
            {
                return Ok();
            }
            return BadRequest();


        }
    }
}

