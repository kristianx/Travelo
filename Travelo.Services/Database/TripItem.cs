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
        
     

        public int TripId { get; set; }
        public Trip Trip { get; set; }


        public bool Expired { get; set; } = false;
        public int TotalPrice => NightsStay * PricePerPerson;
        public string Dates => $"{CheckIn:dd. MMM} - {CheckOut:dd. MMM yyyy}";
        public int NightsStay => (CheckOut.Date - CheckIn.Date).Days;

    }
}
