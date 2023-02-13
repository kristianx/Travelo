using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model.Requests
{
    public class TripCreateRequest
    {
        public int AgencyId { get; set; }
        public int AccommodationId { get; set; }
    }
}
