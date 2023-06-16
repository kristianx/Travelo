using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;

namespace Travelo.Services.Database
{
    partial class TraveloContext
    {
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
        {
            ////u:admin p:admin
            //modelBuilder.Entity<Korisnici>().HasData(new Korisnici
            //{
            //    KorisnikId = 1,
            //    Ime = "Administator",
            //    Prezime = "Administrator",
            //    Email = "admin@fit.ba",
            //    Telefon = "062/222-111",
            //    KorisnickoIme = "admin",
            //    LozinkaHash = "JfJzsL3ngGWki+Dn67C+8WLy73I=",
            //    LozinkaSalt = "7TUJfmgkkDvcY3PB/M4fhg==",
            //});

            modelBuilder.Entity<Country>().HasData(new Country { Id = 1, Name = "Bosnia and Herzegovina" });
            modelBuilder.Entity<Country>().HasData(new Country { Id = 2, Name = "Croatia" });
            modelBuilder.Entity<Country>().HasData(new Country { Id = 3, Name = "Serbia" });
            modelBuilder.Entity<Country>().HasData(new Country { Id = 4, Name = "Austria" });
            modelBuilder.Entity<Country>().HasData(new Country { Id = 5, Name = "France" });


            modelBuilder.Entity<City>().HasData(new City { Id = 1, Name = "Zivinice", CountryId = 1 });
            modelBuilder.Entity<City>().HasData(new City { Id = 2, Name = "Mostar", CountryId = 1, });
            modelBuilder.Entity<City>().HasData(new City { Id = 3, Name = "Tuzla", CountryId = 1, });
            modelBuilder.Entity<City>().HasData(new City { Id = 4, Name = "Sarajevo", CountryId = 1, });
            modelBuilder.Entity<City>().HasData(new City { Id = 5, Name = "Zagreb", CountryId = 2, });
            modelBuilder.Entity<City>().HasData(new City { Id = 6, Name = "Split", CountryId = 2, });
            modelBuilder.Entity<City>().HasData(new City { Id = 7, Name = "Makarska", CountryId = 2, });
            modelBuilder.Entity<City>().HasData(new City { Id = 8, Name = "Zadar", CountryId = 2, });
            modelBuilder.Entity<City>().HasData(new City { Id = 9, Name = "Belgrade", CountryId = 3, });
            modelBuilder.Entity<City>().HasData(new City { Id = 10, Name = "Novi Sad", CountryId = 3, });

      

        }
    }
}

