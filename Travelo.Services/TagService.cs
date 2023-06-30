using System;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class TagService : BaseCRUDService<Model.Tag, Database.Tag, TagSearchObject, TagCreateUpdateRequest, TagCreateUpdateRequest>, ITagService
    {
        public TagService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Tag> AddInclude(IQueryable<Tag> query, TagSearchObject search = null)
        {
            query = query.Include(x => x.cities);
            return base.AddInclude(query, search);
        }

        public override IQueryable<Tag> AddFilter(IQueryable<Tag> query, TagSearchObject search = null)
        {

            var filteredQuery = base.AddFilter(query, search);

       
            if (search.HasCities)
            {
                filteredQuery = filteredQuery.Where(x => x.cities.Any());
            }

            return filteredQuery;
        }
    }
   
}

