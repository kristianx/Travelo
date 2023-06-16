using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class Reservation
    {
       
        public int Id { get; set; }

        public DateTime TimeOfReservation { get; set; }

        public int NumberOfAdults { get; set; }
        public int NumberOfChildren { get; set; }

        public int UserId { get; set; }
        public User User { get; set; }

        public int Price { get; set; }

        public int TripItemId { get; set; }
        public TripItem TripItem { get; set; }

        public int TripId { get; set; }
        public Trip Trip { get; set; }
    }
}
