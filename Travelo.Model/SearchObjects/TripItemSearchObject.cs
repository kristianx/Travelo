using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model.SearchObjects
{
    public class TripItemSearchObject : BaseSearchObject
    {
        public int? TripId { get; set; }
        public bool? Expired { get; set; } = false;
        public int? TotalPrice { get; set; }
    }
}
