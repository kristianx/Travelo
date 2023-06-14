using Microsoft.AspNetCore.Mvc;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    public class BaseCRUDController<T, TSearch, TCreate, TUpdate> : BaseController<T, TSearch>  where T : class where TSearch : BaseSearchObject where TCreate : class where TUpdate : class
    {
        public BaseCRUDController(ICRUDService<T, TSearch, TCreate, TUpdate> service) : base(service)
        {
        }

        [HttpPost]
        public virtual T Create([FromBody]TCreate request)
        {
            var result = ((ICRUDService<T, TSearch, TCreate, TUpdate>)this.Service).Create(request);
            return result;
        }

        [HttpPut("{id}")]
        public virtual T Update(int id, [FromBody]TUpdate request) 
        {
            var result = ((ICRUDService<T, TSearch, TCreate, TUpdate>)this.Service).Update(id, request);
            return result;
        }

        [HttpDelete("{id}")]
        public virtual ActionResult Delete(int id)
        {
            var result = ((ICRUDService<T, TSearch, TCreate, TUpdate>)this.Service).Delete(id);
            if (result)
            {
                return Ok("Item deleted");
            }
            else
            {
                return BadRequest();
            }


        }
    }
}
