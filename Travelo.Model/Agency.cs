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
        public string Address { get; set; }
        public int CityId { get; set; }
        public string CityName { get; set; }
        public string PostalCode { get; set; }
        public string Location { get; set; }
        public int numberOfTrips { get; set; }
        public int rating { get; set; } = 5;
    }
}
