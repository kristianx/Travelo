using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class TripItemCreateUpdateRequest
    {
        [Required]
        public DateTime CheckIn { get; set; }
        [Required]
        public DateTime CheckOut { get; set; }
        [Required]
        public int PricePerPerson { get; set; }
        [Required]
        public int NightsStay { get; set; }
        public bool Expired { get; set; } = false;
        [Required]
        public int TripId { get; set; }

    }
}
