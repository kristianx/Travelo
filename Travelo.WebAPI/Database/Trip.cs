using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Travelo.WebAPI.Database
{
    public class Trip
    {
        [Key]
        public int TripID { get; set; }
        public string Place { get; set; }
    }
}
