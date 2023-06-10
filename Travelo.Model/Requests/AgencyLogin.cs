using System;
using System.ComponentModel.DataAnnotations;

namespace Travelo.Model.Requests
{
    public class AgencyLogin
    {


        [Required(AllowEmptyStrings = false)]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        //[RegularExpression(@"^[^\s\,]+$", ErrorMessage = "Username Cannot Have Spaces")]
        [Required]
        public string Password { get; set; }
    }
        
}

