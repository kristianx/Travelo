using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model.SearchObjects
{
    public class PasosSearchObject : BaseSearchObject
    {
        public string DateIssued { get; set; } = null;
        public int? UserId { get; set; } = null;
    }

}