using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]

    [AllowAnonymous]
    public class UserController : BaseCRUDController<Model.User, UserSearchObject, UserCreateRequest, UserUpdateRequest>
    {
        public UserController(IUserService service) : base(service)
        {
        }
    }
}
