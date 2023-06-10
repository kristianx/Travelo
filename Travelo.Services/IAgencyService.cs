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
    public interface IAgencyService : ICRUDService<Model.Agency,AgencySearchObject, AgencyCreateRequest, AgencyUpdateRequest>
    {
        public bool UpdateImage(AgencyUpdateImageRequest update);
        public int? Login(AgencyLogin agencylogin);
    }
}
