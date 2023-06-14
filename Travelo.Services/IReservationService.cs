using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;

namespace Travelo.Services
{
    public interface IReservationService : ICRUDService<Model.Reservation, ReservationSearchObject, ReservationCreateRequest, object>
    {
        public List<DailyReservationInfo> GetDailyReservations(GetReservationDaily search);
    }
}
