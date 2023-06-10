using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class AgencyCreateRequest : AccountCreateUpdateRequest
    {


        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }
     
        public string About { get; set; }

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

    }
}
