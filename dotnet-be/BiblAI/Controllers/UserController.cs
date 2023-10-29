using BiblAI.Dto;
using BiblAI.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BiblAI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : Controller
    {
        private readonly IUserRepository _userRepository;

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        [HttpGet("{userId}")]
        public IActionResult GetUserById(int userId) {
            var user = _userRepository.GetUserById(userId);
            var userDto = new UserDto
            {
                UserName = user.UserName,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Bios = user.Bios,
                Gender = user.Gender,
                Married = user.Married,
                Religion = user.Religion,
                BirthDate = user.BirthDate,
            };
            
            return Ok(userDto);
        }
    }
}
