using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Travelo.Model
{
    public partial class Account
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string PasswordHash { get; set; }
        public string PasswordSalt { get; set; }
        public Role Role { get; set; }

    }

    public enum Role
    {
        Traveler,
        Agency,
        Administrator
    }

}
