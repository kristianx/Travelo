using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class Trip
    {
        public int Id { get; set; }
        public string AccomodationName { get; set; }
        public string Address{ get; set; }
        public IList<DateTime> TripDates { get; set; } = null;
        public string AccomodationDescription { get; set; }
        public int LowestPrice { get; set; }
        public int AgencyId { get; set; }
        //image
    }

}
