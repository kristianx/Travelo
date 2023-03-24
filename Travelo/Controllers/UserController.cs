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
    [AllowAnonymous]
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
            string token = _userService.Login(userLogin);
            if(token != "")
            {
                return Ok(token);
            }
            return BadRequest("User not found");

        }

        //public void UploadImage([FromBody] int userId, string image)
        //{
        //    //_userService.UploadImage(userId, image);
        //}

        [AllowAnonymous]
        [HttpPost]
        public override User Create([FromBody] UserCreateRequest request)
        {
            return base.Create(request);
        }

        [AllowAnonymous]
        [HttpPost("Register")]
        public String Register([FromBody] UserCreateRequest request)
        {
            var result = _userService.Create(request);

            UserLogin usr = new UserLogin();
            usr.Email = request.Email;
            usr.Password = request.Password;
            var token = _userService.Login(usr);

            return token;
        }
    }


}
