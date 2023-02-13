using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;

namespace Travelo.Services
{
    public interface IAccountService : ICRUDService<Model.Account, AccountSearchObject, AccountCreateUpdateRequest, AccountCreateUpdateRequest>
    {
        Model.Account Login(string username, string password, Role role);
    }
}
