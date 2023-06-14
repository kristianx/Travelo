using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ReservationController : BaseCRUDController<Model.Reservation, ReservationSearchObject, ReservationCreateRequest, object>
    {
        IReservationService _service;
        public ReservationController(IReservationService service) : base(service)
        {
            _service = service;
        }

        [HttpGet("~/Reservation/GetDailyReservations")]
        public IEnumerable<DailyReservationInfo> GetDailyReservations([FromQuery] GetReservationDaily search)
        {
            return _service.GetDailyReservations(search);
         
        }
    }
}
