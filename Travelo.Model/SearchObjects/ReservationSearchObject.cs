using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model.SearchObjects
{
    public class ReservationSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }
        public int? AgencyId { get; set; }
    }
}
