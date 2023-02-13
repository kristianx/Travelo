using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class TripItem
    {
        [Key]
        public int Id { get; set; }
        public DateTime CheckIn { get; set; }
        public DateTime CheckOut { get; set; }
        public int PricePerPerson { get; set; }
        public int NightsStay { get; set; }
        public bool Expired { get; set; } = false;

        public int TripId { get; set; }
    }
}
