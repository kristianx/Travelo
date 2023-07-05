using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class Agency
    {
        public Agency()
        {
            this.Trips = new HashSet<Trip>();
            this.Reservations = new HashSet<Reservation>();
            
        }

        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; }
        public bool Status { get; set; } = true;
        public string? About { get; set; } = null;
        public byte[]? Image { get; set; } = null;
        public string? WebsiteUrl { get; set; } = null;
        

        public int AccountId { get; set; }
        public virtual Account Account { get; set; }

        public int CityId { get; set; }
        public string Address { get; set; }
        public string PostalCode { get; set; }
        public virtual City City { get; set; }



        public virtual ICollection<Trip> Trips { get; set; } 
        public virtual ICollection<Reservation> Reservations { get; set; }


        public double Rating => Trips.Count > 0 ? (double)Trips.Sum(x => x.Rating) / Trips.Count : 0.0;
        public int RatingCount => Trips.Count > 0 ?  Trips.Sum(x => x.RatingCount) : 0;


    }
}
