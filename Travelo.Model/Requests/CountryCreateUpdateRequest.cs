using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Travelo.Model.Requests
{
    public class CountryCreateUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }
    }
}
