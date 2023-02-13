using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model.SearchObjects
{
    public class UserSearchObject : BaseSearchObject
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Username { get; set; }
    }
}
