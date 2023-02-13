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
        public AgencyController(IAgencyService service) : base(service)
        {
        }


        [HttpPost]
        [AllowAnonymous]
        public override Model.Agency Create([FromBody] AgencyCreateUpdateRequest request)
        {
            return base.Create(request);
        }
    }
}
