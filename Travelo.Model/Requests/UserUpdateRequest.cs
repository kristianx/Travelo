using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class UserUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string FirstName { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string LastName { get; set; }
        [Required(AllowEmptyStrings = false)]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        public byte[] Image { get; set; }
        [MinLength(5)]
        public string Address { get; set; }
        [DataType(DataType.PostalCode)]
        public string PostalCode { get; set; }
        [Required]
        public int CityId { get; set; }
        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        //[RegularExpression(@"^[^\s\,]+$", ErrorMessage = "Username Cannot Have Spaces")]
        [Required]
        public string NewPassword { get; set; }
        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        //[RegularExpression(@"^[^\s\,]+$", ErrorMessage = "Username Cannot Have Spaces")]
        [Required]
        public string OldPassword { get; set; }
    }
}
