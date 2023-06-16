using System;
using System.Reflection.Metadata;
using Microsoft.EntityFrameworkCore;

namespace Travelo.Services.Database
{
	public static class DataSeeder
	{
        
            public static void SeedData(TraveloContext context)
            {
            context.Country.Add(new Country { Id = 1, Name = "Bosnia and Herzegovina" });
            context.Country.Add(new Country { Id = 2, Name = "Croatia" });
            context.Country.Add(new Country { Id = 3, Name = "Serbia" });
            context.Country.Add(new Country { Id = 4, Name = "Austria" });
            context.Country.Add(new Country { Id = 5, Name = "France" });


            context.SaveChanges();

     
                context.City.Add(new City { Id = 1, Name = "Zivinice", CountryId = 1 });
                context.City.Add(new City { Id = 2, Name = "Mostar", CountryId = 1, });
                context.City.Add(new City { Id = 3, Name = "Tuzla", CountryId = 1, });
                context.City.Add(new City { Id = 4, Name = "Sarajevo", CountryId = 1, });
                context.City.Add(new City { Id = 5, Name = "Zagreb", CountryId = 2, });
                context.City.Add(new City { Id = 6, Name = "Split", CountryId = 2, });
                context.City.Add(new City { Id = 7, Name = "Makarska", CountryId = 2, });
                context.City.Add(new City { Id = 8, Name = "Zadar", CountryId = 2, });
                context.City.Add(new City { Id = 9, Name = "Belgrade", CountryId = 3, });
            context.City.Add(new City { Id = 10, Name = "Novi Sad", CountryId = 3, });

            context.SaveChanges();
        }
        
    }
}

