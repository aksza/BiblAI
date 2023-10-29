using BiblAI.Dto;
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
                posts = _postRepository.getPosts().Select(p => new PostDto
                {
                    Id = p.Id,
                    Question = p.Question,
                    Answer = p.Answer,
                    Anonym = p.Anonym,
                    UserName = p.User.UserName,
                    UserId = p.User.Id,
                    ProfilePictureUrl = "idk",
                    Date = p.Date,
                    CommentsNum = 5,
                    //null ha akarod futattni
                    Comments = p.Comments.Select(c => new CommentDto
                    {
                        Id = c.Id,
                        Content = c.Content,
                        UserId = c.User.Id,
                        UserName = c.User.UserName,
                        ProfilePictureUrl = "idk",
                        Date = c.Date,
                        NumDislikes = 5,
                        NumLikes = 7
                    }).ToList(),
                    NumLikes = 7,
                    NumDislike = 4,
                    PostHashtag = p.PostHashtag
                }),
                userName = "szoverfi.dani"
            };
            return Ok(response);    
        }
    }
}
