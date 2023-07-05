using System;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace Travelo.Model.Requests
{
	public class AccomodationCreateRequest
	{
        [Required(AllowEmptyStrings = false)]
        [MinLength(5)]
        public string Name { get; set; }
        [Required]
        public int CityId { get; set; }
        [MinLength(5)]
        public string Address { get; set; }
        [DataType(DataType.PostalCode)]
        public string PostalCode { get; set; }

        public string Description { get; set; }

        public byte[] Images { get; set; }
        
    }
}

