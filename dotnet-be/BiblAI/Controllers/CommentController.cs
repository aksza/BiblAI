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
    public class CommentController : Controller
    {
        private readonly ICommentRepository _commentRepository;
        private readonly IPostRepository _postRepository;
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;

        public CommentController(ICommentRepository commentRepository, IPostRepository postRepository, IUserRepository userRepository, IMapper mapper)
        {
            _commentRepository = commentRepository;
            _postRepository = postRepository;
            _userRepository = userRepository;
            _mapper = mapper;
        }

        [HttpPost]
        public IActionResult CreateComment([FromBody] CommentCreateDto commentDto)
        {
            if (commentDto == null)
                return BadRequest(ModelState);

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var comment = _mapper.Map<Comment>(commentDto);
            comment.Post = _postRepository.GetPostById(commentDto.PostId);
            comment.User = _userRepository.GetUserById(commentDto.UserId);

            if (!_commentRepository.CreateComment(comment))
            {
                ModelState.AddModelError("", "Something went wrong while savin");
                return StatusCode(500, ModelState);
            }

            return Ok("Successfully created");
        }
    }
}
