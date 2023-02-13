using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services
{
    public interface ICRUDService<T, TSearch, TCreate, TUpdate> : IService<T,TSearch> where T : class where TSearch : class where TCreate : class where TUpdate : class
    {
        T Create(TCreate create);
        T Update(int id, TUpdate update);

    }
}
