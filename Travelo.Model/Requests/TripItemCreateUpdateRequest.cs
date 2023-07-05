using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class TripItemCreateUpdateRequest
    {

        public string CheckIn { get; set; } = null;
   
        public string CheckOut { get; set; } = null;

        public int? PricePerPerson { get; set; } = null;

        public int? TripId { get; set; } = null;
    }
}