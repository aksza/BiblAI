using AutoMapper;
using BiblAI.Dto;
using BiblAI.Interfaces;
using BiblAI.Models;
using BiblAI.Repository;
using BiblAI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace BiblAI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class PostController : Controller
    {
        private readonly IPostRepository _postRepository;
        private readonly IUserRepository _userRepository;
        private readonly ILikeRepository _likeRepository;
        private readonly ICommentRepository _commentRepository;
        private readonly FastApiService _fastApiService;
        private readonly IMapper _mapper;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public PostController(IPostRepository postRepository, IUserRepository userRepository, ILikeRepository likeRepository, IMapper mapper, FastApiService fastApiService, ICommentRepository commentRepository, IHttpContextAccessor httpContextAccessor)
        {
            _postRepository = postRepository;
            _userRepository = userRepository;
            _likeRepository = likeRepository;
            _mapper = mapper;
            _fastApiService = fastApiService;
            _commentRepository = commentRepository;
            _httpContextAccessor = httpContextAccessor;
        }

        [HttpGet("public")]
        [AllowAnonymous]
        public IActionResult GetPosts() {
            var posts = _postRepository.GetPosts();
            var postDtos = _mapper.Map<List<PostDto>>(posts);

            return Ok(postDtos);
        }

        [HttpGet("private")]
        public IActionResult GetPostsWithUser()
        {
            var posts = _postRepository.GetPosts();
            var postDtos = _mapper.Map<List<PostDto>>(posts);
            var userString = _httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier);
            int.TryParse(userString, out int userId);
            var userName = _httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.Name);
            var userPicture = _httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.Uri);

            var response = new
            {
                UserId = userId,
                UserName = userName,
                ProfilePictureUrl = userPicture,
                Posts = postDtos
            };

            return Ok(response);
        }

        [HttpGet("{search}")]
        [AllowAnonymous]
        public IActionResult GetPosts(string search)
        {
            var posts = _postRepository.SearchPosts(search);
            var postDtos = _mapper.Map<List<PostDto>>(posts);

            return Ok(postDtos);
        }


        [HttpPost("get_answer")]
        [AllowAnonymous]
        public async Task<IActionResult> CreateAnswer([FromBody] AiQuestion question)
        {
            AiAnswer answer = await _fastApiService.GetAnswer(question);

            // Handle the result as needed
            return Ok(answer);
        } 

        [HttpPost("create")]
        public IActionResult CreatePost([FromBody] PostCreateDto postDto)
        {
            if (postDto == null)
                return BadRequest(ModelState);

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var postMap = _mapper.Map<Post>(postDto);

            if (!_postRepository.CreatePost(postMap))
            {
                ModelState.AddModelError("", "Something went wrong while saving post");
                return StatusCode(500, ModelState);
            }

            var commentMap = _mapper.Map<Comment>(postDto);
            commentMap.PostId = postMap.Id;

            if (!_commentRepository.CreateComment(commentMap))
            {
                ModelState.AddModelError("", "Something went wrong while saving comment");
                return StatusCode(500, ModelState);
            }


            return Ok("Successfully created");
        }

        [HttpPost("like")]
        public IActionResult LikePost([FromBody] LikeCreateDto likeDto)
        {
            if (likeDto == null)
                return BadRequest(ModelState);

            var like = _likeRepository.GetPostLikeByIds(likeDto.UserId, likeDto.CommentId);

            if (like != null)
            {
                ModelState.AddModelError("", "User already exists");
                return StatusCode(422, ModelState);
            }

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var likeMap = _mapper.Map<Like>(likeDto);
            likeMap.PostId = likeDto.CommentId;

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
