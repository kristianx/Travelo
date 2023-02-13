using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class User
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public byte[] Image { get; set; } = null;
        public int CityId { get; set; }
        public string Address { get; set; } = null;
        public string PostalCode { get; set; } = null;
    }
}
