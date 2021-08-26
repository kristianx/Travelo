using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Travelo.WebAPI.Database
{
    public class TraveloContext : DbContext
    {
        public TraveloContext(DbContextOptions<TraveloContext> options) : base(options) { }

        public DbSet<Trip> Trip { get; set; }
    }
}
