using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class TraveloContext : DbContext
    {
        public TraveloContext(DbContextOptions<TraveloContext> options) : base(options) { 
        }
        

        public virtual DbSet<Accommodation> Accommodations { get; set; } = null!;
        public virtual DbSet<Address> Address { get; set; } = null!;
        public virtual DbSet<Agency> Agency { get; set; } = null!;
        public virtual DbSet<City> City { get; set; } = null!;
        public virtual DbSet<Country> Country { get; set; } = null!;
        public virtual DbSet<Facility> Facility { get; set; } = null!;
        public virtual DbSet<Reservation> Reservation { get; set; } = null!;
        public virtual DbSet<Tag> Tag { get; set; } = null!;
        //Maybe delete
        public virtual DbSet<TravelType> TravelType { get; set; } = null!;
        public virtual DbSet<Trip> Trip { get; set; } = null!;
        public virtual DbSet<TripItem> TripItem { get; set; } = null!;
        public virtual DbSet<User> User { get; set; } = null!;
        public virtual DbSet<Account> Account { get; set; } = null!;
 


    }
}
