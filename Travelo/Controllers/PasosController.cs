using System;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class PasosController : BaseCRUDController<Model.Pasos, PasosSearchObject, PasosCreateUpdateRequest, PasosCreateUpdateRequest>
    {

        public PasosController(IPasosService service) : base(service)
        {
 
        }
       
    }
}

