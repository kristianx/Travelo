using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class City
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string CountryName { get; set; }
        public List<string> Tags { get; set; }
    }
}
