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
        private readonly ILikeRepository _likeRepository;
        private readonly IMapper _mapper;

        public CommentController(ICommentRepository commentRepository, IPostRepository postRepository, IUserRepository userRepository, IMapper mapper, ILikeRepository likeRepository)
        {
            _commentRepository = commentRepository;
            _postRepository = postRepository;
            _userRepository = userRepository;
            _likeRepository = likeRepository;
            _mapper = mapper;
        }

        [HttpPost("create")]
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
                ModelState.AddModelError("", "Something went wrong while saving");
                return StatusCode(500, ModelState);
            }

            return Ok("Successfully created");
        }

        [HttpDelete("{commentId}")]
        public IActionResult DeleteComment(int commentId)
        {
            if(!_commentRepository.CommentExists(commentId))
            {
                return NotFound();
            }

            var commentLikes = _likeRepository.GetLikesByCommentId(commentId);
            var commentToDelete = _commentRepository.GetCommentById(commentId);

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (!_likeRepository.DeleteCommentLikes(commentLikes))
            {
                ModelState.AddModelError("", "Something went wrong deleting Comment Likes");
            }

            if (!_commentRepository.DeleteComment(commentToDelete))
            {
                ModelState.AddModelError("", "Something went wrong deleting Comment");
            }

            return NoContent();
        }

        [HttpPost("like")]
        public IActionResult LikeComment([FromBody] LikeCreateDto likeDto)
        {
            if (likeDto == null)
                return BadRequest(ModelState);

            var like = _likeRepository.GetLikes()
                .Where(l => l.UserId == likeDto.UserId && (l.CommentId != null && l.CommentId == likeDto.CommentId))
                .FirstOrDefault();

            if (like != null)
            {
                ModelState.AddModelError("", "Like already exists");
                return StatusCode(422, ModelState);
            }

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var likeMap = _mapper.Map<Like>(likeDto);
            likeMap.User = _userRepository.GetUserById(likeDto.UserId);
            likeMap.Comment = _commentRepository.GetCommentById(likeDto.CommentId);

            if (!_likeRepository.Like(likeMap))
            {
                ModelState.AddModelError("", "Something went wrong while saving");
                return StatusCode(500, ModelState);
            }

            return Ok("Successfully created");

        }

        [HttpDelete("unlike")]
        public IActionResult DeleteLikeComment([FromBody] LikeDto likeDto)
        {
            if (!_likeRepository.CommentLikeExists(likeDto.UserId, likeDto.CommentId))
            {
                return NotFound();
            }

            var likeToDelete = _likeRepository.GetCommentLikeByIds(likeDto.UserId, likeDto.CommentId);

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (!_likeRepository.Unlike(likeToDelete))
            {
                ModelState.AddModelError("", "Something went wrong deleting like");
            }

            return NoContent();
        }
        [HttpPut("update_like")]
        public IActionResult UpdateLikeComment([FromBody] LikeDto likeDto)
        {
            if (!_likeRepository.CommentLikeExists(likeDto.UserId, likeDto.CommentId))
            {
                return NotFound();
            }

            var likeToUpdate = _likeRepository.GetCommentLikeByIds(likeDto.UserId, likeDto.CommentId);

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
