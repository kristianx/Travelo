using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;

namespace Travelo.Services
{
    public interface ICityService : ICRUDService<Model.City, CitySearchObject, CityCreateUpdateRequest, CityCreateUpdateRequest>
    {
    }
}
