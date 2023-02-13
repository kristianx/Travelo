using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class Reservation
    {
        public int Id { get; set; }
        public DateTime TimeOfReservation { get; set; }
        public int NumberOfAdults { get; set; }
        public int NumberOfChildren { get; set; }
        public int UserId { get; set; }
        public int Price { get; set; }
        public int TripItemId { get; set; }
        public int TripId { get; set; }
    }
}
