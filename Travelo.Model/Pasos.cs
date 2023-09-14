using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class Pasos
    {
        public int Id { get; set; }
        public DateTime DateIssued { get; set; }
        public string UserName { get; set; }
        public bool Valid { get; set; }
    }
}
