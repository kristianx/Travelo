using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class CountryService : BaseCRUDService<Model.Country, Database.Country, CountrySearchObject, CountryCreateUpdateRequest, CountryCreateUpdateRequest>, ICountryService
    {
        public CountryService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
