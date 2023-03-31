﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model
{
    public partial class Trip
    {
        public int Id { get; set; }
        public byte[] AccomodationImage { get; set; }
        public string AccomodationName { get; set; }
        public string AccomodationDescription { get; set; }
        public int Rating { get; set; } = 5;
        public int RatingCount { get; set; } = 115;
        public List<string> Facilities { get; set; }
        public string Location { get; set; }
        public string Dates { get; set; }
        public int LowestPrice { get; set; }
        public int AgencyId { get; set; }
        public string AgencyName { get; set; }
        public byte[] AgencyImage { get; set; }

    }

}
