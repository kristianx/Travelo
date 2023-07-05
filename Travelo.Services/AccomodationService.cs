using System;
using System.Collections.Generic;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;


namespace Travelo.Services
{
	public class AccomodationService : BaseCRUDService<Model.Accomodation, Database.Accomodation, AccomodationSearchObject, AccomodationCreateRequest, AccomodationUpdateRequest>, IAccomodationService
	{
		public AccomodationService(TraveloContext context, IMapper mapper) : base(context,mapper)
		{ 

        }
        public bool UpdateImage(AccomodationUpdateImageRequest update)
        {
            Database.Accomodation accomodation  = Context.Accomodations.FirstOrDefault(a => a.Id == update.AccomodationId);
            if (accomodation != null)
            {
                Context.Accomodations.FirstOrDefault(a => a.Id == update.AccomodationId).Images = update.Image;
                Context.SaveChanges();
                return true;
            }
            return false;
        }

        public bool UpdateFacilities(FacilitiesUpdateRequest update)
        {
            Database.Accomodation accomodation = Context.Accomodations
              .Include(x => x.Facilities)
              .FirstOrDefault(x => x.Id == update.AccomodationId);

            var updatedFacilities = new List<Facility>();

            if (accomodation != null)
            {
                IEnumerable<Database.Facility> existingFacilities = Context.Facility.ToList();

                foreach (var fac in update.facilities)
                {

                    var existingFacility = existingFacilities.FirstOrDefault(f => f.Name == fac);

                    if (existingFacility != null)
                    {
                        updatedFacilities.Add(existingFacility);
                    }
                    else {

                        var newFacility = new Facility { Name = fac };
                        updatedFacilities.Add(newFacility);
                    }

                   
                }
                accomodation.Facilities = updatedFacilities;
                Context.SaveChanges();
                return true;
            }
           
            return false;
        }

        
    }
}

