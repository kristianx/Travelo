using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Travelo.Model.Requests
{
	public class AccomodationUpdateRequest
    { 
        public string Name { get; set; }
        public int CityId { get; set; }
        public string Address { get; set; }
        public string PostalCode { get; set; }
        public string Description { get; set; }
        public string LocationMap { get; set; }


    }
}

