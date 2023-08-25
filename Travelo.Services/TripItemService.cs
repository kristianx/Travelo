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
        public override IQueryable<TripItem> AddFilter(IQueryable<TripItem> query, TripItemSearchObject search = null)
        {

            var filteredQuery = base.AddFilter(query, search);
            if (search.TripId != null)
            {
                if (search.Expired == true)
                {
                    filteredQuery = filteredQuery.Where(x => x.TripId == search.TripId);
                }
                else
                {
                    filteredQuery = filteredQuery.Where(x => x.TripId == search.TripId && x.CheckIn > DateTime.Now);
                }
                
            }

          
            return filteredQuery;
        }
    }


}
