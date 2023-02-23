using System;
using System.Collections.Generic;
using Travelo.Model;

namespace Travelo.Model
{
    public class Accomodation
    {
        public int Id { get; set; }
        public string Name { get; set; }


        public int CityId { get; set; }
        public string CityName { get; set; }
        public string Address { get; set; }
        public string PostalCode { get; set; }


        public string Description { get; set; }

        //public ICollection<Facility> Facilities { get; set; }

        //Check this
        public string LocationMap { get; set; }

        //Check this
        public byte[] Images { get; set; }
    }
}
