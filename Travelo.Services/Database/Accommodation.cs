using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class Accommodation
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public int CityId { get; set; }
        public string Address { get; set; }
        public string PostalCode { get; set; }
        public virtual City City { get; set; }

        public string Description { get; set; }


        public ICollection<Facility> Facilities { get; set; }

        //Check this
        public string LocationMap { get; set; }

        //Check this
        public byte[]? Images { get; set; }
    }
}
