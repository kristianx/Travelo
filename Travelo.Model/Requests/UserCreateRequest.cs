using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class UserCreateRequest : AccountCreateUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string FirstName { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string LastName { get; set; }
        [Required]
        [MinLength(4)]
        public string Username { get; set; }

        [MinLength(5)]
        public string Address { get; set; }
   
        [DataType(DataType.PostalCode)]
        public string PostalCode { get; set; }

        [Required]
        public int CityId { get; set; }
    }
}
