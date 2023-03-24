using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model.SearchObjects
{
    public class TripSearchObject : BaseSearchObject
    {
        public int? AgencyId { get; set; }
        public string City{ get; set; }
        public string Country{ get; set; }
        public string TagName { get; set; }
    }
}
