using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Travelo.Model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Travelo.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TripController : ControllerBase
    {
        [HttpGet]
        public ActionResult<IEnumerable<Trip>> Get()
        {
            var list = new List<Trip>()
            {
                new Trip()
                {
                    TripID = 1,
                    Place = "Amsterdam"
                },
                new Trip()
                {
                    TripID = 2,
                    Place = "Tulum"
                }
            };

            return list;

        }
        [HttpGet("{id}")]
        public ActionResult<Trip> GetById(int id)
        {
            var item = new Trip()
            {
                TripID = id, 
                Place = "Amsterdam"
            };
            return item;
            

        }
    }
}
