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
        private readonly ILikeRepository _likeRepository;
        private readonly IMapper _mapper;

        public PostController(IPostRepository postRepository, IUserRepository userRepository, ILikeRepository likeRepository, IMapper mapper)
        {
            _postRepository = postRepository;
            _userRepository = userRepository;
            _likeRepository = likeRepository;
            _mapper = mapper;
        }

        [HttpGet]
        public IActionResult GetPosts() {
            var posts = _postRepository.GetPosts();
            var postDtos = _mapper.Map<List<PostDto>>(posts);

            return Ok(postDtos);
        }

        [HttpPost("create")]
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

        [HttpPost("like")]
        public IActionResult LikePost([FromBody] LikeCreateDto likeDto)
        {
            if (likeDto == null)
                return BadRequest(ModelState);

            var like = _likeRepository.GetLikes()
                .Where(l => l.UserId == likeDto.UserId && (l.PostId != null && l.PostId == likeDto.CommentId))
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

        [HttpDelete("unlike")]
        public IActionResult DeleteLikePost([FromBody] LikeDto likeDto)
        {
            if (!_likeRepository.PostLikeExists(likeDto.UserId, likeDto.CommentId))
            {
                return NotFound();
            }

            var likeToDelete = _likeRepository.GetPostLikeByIds(likeDto.UserId, likeDto.CommentId);

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (!_likeRepository.Unlike(likeToDelete))
            {
                ModelState.AddModelError("", "Something went wrong deleting like");
            }

            return NoContent();
        }
        [HttpPut("update_like")]
        public IActionResult UpdateLikePost([FromBody] LikeDto likeDto)
        {
            if (!_likeRepository.PostLikeExists(likeDto.UserId, likeDto.CommentId))
            {
                return NotFound();
            }

            var likeToUpdate = _likeRepository.GetPostLikeByIds(likeDto.UserId, likeDto.CommentId);

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            likeToUpdate.Type = !likeToUpdate.Type;

            if (!_likeRepository.UpdateLike(likeToUpdate))
            {
                ModelState.AddModelError("", "Something went wrong updating like");
            }

            return NoContent();
        }
    }
}
