﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Travelo.Model.SearchObjects
{
    public class CitySearchObject : BaseSearchObject
    {
        public string Name { get; set; }
        public string Tag { get; set; }
        public bool HasTrips { get; set; } = true;
    }

}