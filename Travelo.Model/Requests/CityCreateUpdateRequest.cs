using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class CityCreateUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Name{ get; set; }

        [Required]
        public string CountryId { get; set; }

        public List<string> Tags { get; set; }
    }
}
