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
    public class LikeController : Controller
    {
        private readonly ILikeRepository _likeRepository;
        private readonly ICommentRepository _commentRepository;
        private readonly IPostRepository _postRepository;
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;

        public LikeController(ILikeRepository likeRepository, ICommentRepository commentRepository, IPostRepository postRepository, IUserRepository userRepository, IMapper mapper)
        {
            _likeRepository = likeRepository;
            _commentRepository = commentRepository;
            _postRepository = postRepository;
            _userRepository = userRepository;
            _mapper = mapper;
        }

        [HttpPost("like_comment")]
        public IActionResult LikeComment([FromBody] LikeCreateDto likeDto)
        {
            if (likeDto == null)
                return BadRequest(ModelState);

            var like = _likeRepository.GetLikes()
                .Where(l => l.User.Id == likeDto.UserId && l.Comment.Id == likeDto.CommentId)
                .FirstOrDefault();

            if (like != null)
            {
                ModelState.AddModelError("", "User already exists");
                return StatusCode(422, ModelState);
            }

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var likeMap = _mapper.Map<Like>(likeDto);
            likeMap.User = _userRepository.GetUserById(likeDto.UserId);
            likeMap.Comment = _commentRepository.GetCommentById(likeDto.CommentId);

            if (!_likeRepository.Like(likeMap))
            {
                ModelState.AddModelError("", "Something went wrong while savin");
                return StatusCode(500, ModelState);
            }

            return Ok("Successfully created");

        }

        [HttpPost("like_post")]
        public IActionResult LikePost([FromBody] LikeCreateDto likeDto) 
        {
            if (likeDto == null)
                return BadRequest(ModelState);

            var like = _likeRepository.GetLikes()
                .Where(l => l.User.Id == likeDto.UserId && l.Post.Id == likeDto.CommentId)
                .FirstOrDefault();

            if (like != null)
            {
                ModelState.AddModelError("", "User already exists");
                return StatusCode(422, ModelState);
            }

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var likeMap = _mapper.Map<Like>(likeDto);
            likeMap.User = _userRepository.GetUserById(likeDto.UserId);
            likeMap.Post = _postRepository.GetPostById(likeDto.CommentId);

            if (!_likeRepository.Like(likeMap))
            {
                ModelState.AddModelError("", "Something went wrong while savin");
                return StatusCode(500, ModelState);
            }

            return Ok("Successfully created");
        }
    }
}
