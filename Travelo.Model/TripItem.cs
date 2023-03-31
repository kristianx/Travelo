using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class TripItem
    {
        public int Id { get; set; }
        public DateTime CheckIn { get; set; }
        public DateTime CheckOut { get; set; }
        public int PricePerPerson { get; set; }
        public int NightsStay { get; set; }
       
        public int TripId { get; set; }
        public bool Expired { get; set; }
        public int TotalPrice { get; set; }
        public string Dates { get; set; }
    }
}
