using System;
using System.ComponentModel.DataAnnotations;

namespace Travelo.Services.Database
{
	public class Rating
	{

        [Key]
        public int Id { get; set; }
        public double RatingScore { get; set; }
        public DateTime TimeOfRating { get; set; }

        public int UserId { get; set; }
        public User User { get; set; }

        public int TripId { get; set; }
        public Trip Trip{ get; set; }
    }
}

