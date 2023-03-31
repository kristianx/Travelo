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
    public class TripItemService : BaseCRUDService<Model.TripItem, Database.TripItem, TripItemSearchObject, TripItemCreateUpdateRequest, TripItemCreateUpdateRequest> , ITripItemService
    {
        public TripItemService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IEnumerable<Model.TripItem> Get(TripItemSearchObject search = null)
        {
            return base.Get(search);
        }
    }


}
