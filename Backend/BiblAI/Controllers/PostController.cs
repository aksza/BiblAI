using BiblAI.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BiblAI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostController : Controller
    {
        private readonly IPostRepository _postRepository;

        public PostController(IPostRepository postRepository)
        {
            _postRepository = postRepository;
        }

        [HttpGet]
        public IActionResult GetPosts() {
            var response = new
            {
                posts = _postRepository.getPosts(),
                userName = "szoverfi.dani"
            };
            return Ok(response);    
        }
    }
}
