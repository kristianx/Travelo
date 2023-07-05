﻿using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

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

            T mappedEntity = Mapper.Map<T>(entity);

            return mappedEntity;
        }

        public virtual void BeforeCreate(TCreate create, TDb entity)
        {

        }
        public override IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch search = null)
        {
            return base.AddInclude(query, search);
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
        public virtual bool Delete(int id)
        {
            var set = Context.Set<TDb>();

            var entity = set.Find(id);

            if (entity != null)
            {
                Context.Set<TDb>().Remove(entity);
                Context.SaveChanges();
                return true;
            }
           return false;
        }
    }
}
