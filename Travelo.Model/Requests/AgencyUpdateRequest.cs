using System;
using System.ComponentModel.DataAnnotations;
using Travelo.Model;

namespace Travelo.Model.Requests
{
	public class AgencyUpdateRequest
	{
        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }

        public string About { get; set; }

        public string Email { get; set; }
        [Required]
        //[RegularExpression(@"\(?\d{3}\)?-? ?/*\d{3}-? *-?\d{3}", ErrorMessage = "Invalid phnoe format")]
        public string Phone { get; set; }

        public byte[] Image { get; set; }
        public string WebsiteUrl { get; set; }

        [MinLength(5)]
        public string Address { get; set; }

        [DataType(DataType.PostalCode)]
        public string PostalCode { get; set; }

        [Required]
        public int CityId { get; set; }
        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        //[RegularExpression(@"^[^\s\,]+$", ErrorMessage = "Username Cannot Have Spaces")]
        [Required(AllowEmptyStrings = false)]
        public string OldPassword { get; set; }

        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        //[RegularExpression(@"^[^\s\,]+$", ErrorMessage = "Username Cannot Have Spaces")]
        public string NewPassword { get; set; }
    }
}
