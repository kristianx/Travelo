using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class BaseCRUDService<T, TDb, TSearch, TCreate, TUpdate> : BaseService<T, TDb, TSearch>, ICRUDService<T, TSearch, TCreate, TUpdate> where T : class where TDb : class where TSearch : BaseSearchObject where TCreate : class where TUpdate : class
    {
        public BaseCRUDService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public virtual T Create(TCreate create)
        {
            var set = Context.Set<TDb>();
            
            TDb entity = Mapper.Map<TDb>(create);
            
            set.Add(entity);

            BeforeCreate(create, entity);

            Context.SaveChanges();

            return Mapper.Map<T>(entity);
        }

        public virtual void BeforeCreate(TCreate create, TDb entity)
        {

        }

        public virtual T Update(int id, TUpdate update)
        {
            var set = Context.Set<TDb>();

            var entity = set.Find(id);

            if (entity != null)
            {
                Mapper.Map(update, entity);
            }
            else
            {
                return null;

            }

            Context.SaveChanges();

            return Mapper.Map<T>(entity);

        }
    }
}
