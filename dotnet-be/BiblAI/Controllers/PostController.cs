using AutoMapper;
using BiblAI.Dto;
using BiblAI.Interfaces;
using BiblAI.Models;
using BiblAI.Repository;
using Microsoft.AspNetCore.Mvc;

namespace BiblAI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostController : Controller
    {
        private readonly IPostRepository _postRepository;
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;

        public PostController(IPostRepository postRepository, IMapper mapper, IUserRepository userRepository)
        {
            _postRepository = postRepository;
            _userRepository = userRepository;
            _mapper = mapper;
        }

        [HttpGet]
        public IActionResult GetPosts() {
            return Ok(_postRepository.GetPosts());
            /*var response = new
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
                        Content = c.Content,
                        UserId = c.User.Id,
                        UserName = c.User.UserName,
                        ProfilePictureUrl = "idk",
                        NumDislikes = 5,
                        NumLikes = 7
                    }).ToList(),
                    NumLikes = 7,
                    NumDislike = 4,
                    PostHashtag = p.PostHashtag
                }),
                userName = "szoverfi.dani"
            };
            return Ok(response);   */
        }

        [HttpPost]
        public IActionResult CreateUser([FromBody] PostCreateDto postDto)
        {
            if (postDto == null)
                return BadRequest(ModelState);

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var postMap = _mapper.Map<Post>(postDto);
            postMap.User = _userRepository.GetUserById(postDto.UserId);

            if (!_postRepository.CreatePost(postMap))
            {
                ModelState.AddModelError("", "Something went wrong while savin");
                return StatusCode(500, ModelState);
            }

            return Ok("Successfully created");
        }
    }
}
