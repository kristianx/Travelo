﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class Tag
    {
        public Tag() {
            this.cities = new HashSet<City>();
            this.trips = new HashSet<Trip>();
        }
        public int Id { get; set; }
        public string Name { get; set; }
        public virtual ICollection<City> cities { get; set; }
        public virtual ICollection<Trip> trips { get; set; }

    }
}
