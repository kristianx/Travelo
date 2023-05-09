using Azure.Core;
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
    public class UserController : BaseCRUDController<Model.User, UserSearchObject, UserCreateRequest, UserUpdateRequest>
    {
        public IUserService _userService;
        public UserController(IUserService service) : base(service)
        {
            _userService = service;
        }

        [AllowAnonymous]
        [HttpPost("Login")]
        public ActionResult<string> Login([FromBody] UserLogin userLogin)
        {
            int? id = _userService.Login(userLogin);
            if(id != null)
            {
                return Ok(id);
            }
            return BadRequest("User not found");

        }
        [HttpPost("~/uploadImage")]
        public Model.User UploadImage([FromBody] UserUploadImageRequest request)
        {
            return _userService.UploadImage(request);
        }

        [AllowAnonymous]
        [HttpPost]
        public override User Create([FromBody] UserCreateRequest request)
        {
            return base.Create(request);
        }

        [AllowAnonymous]
        [HttpPost("Register")]
        public int? Register([FromBody] UserCreateRequest request)
        {
            var result = _userService.Create(request);

            UserLogin usr = new UserLogin();
            usr.Email = request.Email;
            usr.Password = request.Password;
            var id = _userService.Login(usr);

            return id;
        }

      
    }


}
