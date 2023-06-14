using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class Trip
    {
        public Trip() {

            this.Tags = new HashSet<Tag>();
            this.Users = new HashSet<User>();
            this.TripItems = new HashSet<TripItem>();
        }
        [Key]
        public int Id { get; set; }

        public int AgencyId { get; set; }
        public Agency Agency { get; set; }  

        public virtual ICollection<TripItem> TripItems {get;set; }

        public int AccommodationId { get; set; }
        public Accommodation Accommodation { get; set; }

        public virtual ICollection<Tag> Tags { get; set; }
        public virtual ICollection<User> Users { get; set; }


        //Add a static
        public string? TravelTypes { get; set; }

    }
}
