using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Travelo.Model;

namespace Travelo.Model.Requests
{
    public class PasosCreateUpdateRequest
    {

        public string DateIssued { get; set; }
        public int UserId { get; set; }
        public bool Valid { get; set; }

    }
}
