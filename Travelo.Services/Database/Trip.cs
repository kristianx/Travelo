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
        public Trip()
        {
 
            this.Users = new HashSet<User>();
            this.TripItems = new HashSet<TripItem>();
            this.Ratings = new HashSet<Rating>();
        }
        [Key]
        public int Id { get; set; }

        public int AgencyId { get; set; }
        public Agency Agency { get; set; }  

        

        public int AccomodationId { get; set; }
        public Accomodation Accomodation { get; set; }

        public virtual ICollection<User> Users { get; set; }
        public virtual ICollection<Rating> Ratings { get; set; }
        public virtual ICollection<TripItem> TripItems { get; set; }


        public double Rating => Ratings.Count > 0 ? (double)Ratings.Sum(x => x.RatingScore) / (double)Ratings.Count : 0.0;
        public int RatingCount => Ratings.Count;



    }
}
