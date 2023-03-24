using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using Newtonsoft.Json;

namespace Travelo.Model.Requests
{
	public class UserLogin
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