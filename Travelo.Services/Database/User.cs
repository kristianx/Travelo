 using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;

namespace Travelo.Services.Database
{
    public class User
    {
        public User()
        {
            this.Trips = new HashSet<Trip>();
            this.PaymentMethods = new HashSet<PaymentMethod>();
        }

        [Key]
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Username { get; set; }
        public bool Status { get; set; } = true;
        public byte[]? Image { get; set; }

        public int AccountId { get; set; }
        public virtual Account Account { get; set; }


        public int CityId { get; set; }
        public string? Address { get; set; }
        public string? PostalCode { get; set; }
        public virtual City City { get; set; }

        public virtual ICollection<Trip> Trips { get; set; }
        public virtual ICollection<PaymentMethod> PaymentMethods { get; set; }

    }
}
