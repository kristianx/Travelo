using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class Agency
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string WebsiteUrl { get; set; } 
        public string About { get; set; }
        public byte[] Image { get; set; } = null;
        public bool Status { get; set; }


        //public Address Address { get; set; }


        //public ICollection<Trip> Trips { get; set; } 
        //public ICollection<Reservation> Reservations { get; set; }
    }
}
