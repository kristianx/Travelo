using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class CountryController : BaseCRUDController<Model.Country, CountrySearchObject, CountryCreateUpdateRequest, CountryCreateUpdateRequest>
    {
        public CountryController(ICountryService service) : base(service)
        {
        }

    }
}
