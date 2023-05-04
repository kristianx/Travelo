using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class UserUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        //[RegularExpression(@"^[^\s\,]+$", ErrorMessage = "Username Cannot Have Spaces")]
        [Required(AllowEmptyStrings = false)]
        public string OldPassword { get; set; }

        [Required]
        public int CityId { get; set; }

        [StringLength(50, MinimumLength = 4)]
        public string FirstName { get; set; }

        [StringLength(50, MinimumLength = 4)]
        public string LastName { get; set; }

        [MinLength(5)]
        public string Address { get; set; }

        //[DataType(DataType.PostalCode)]
        public string PostalCode { get; set; }

        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        //[RegularExpression(@"^[^\s\,]+$", ErrorMessage = "Username Cannot Have Spaces")]
        public string NewPassword { get; set; }
   
    }
}
