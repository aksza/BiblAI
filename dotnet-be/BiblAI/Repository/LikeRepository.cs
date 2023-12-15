using BiblAI.Data;
using BiblAI.Interfaces;
using BiblAI.Models;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.Design;

namespace BiblAI.Repository
{
    public class LikeRepository : ILikeRepository
    {
        private DataContext _context;
        public LikeRepository(DataContext context) 
        {
            _context = context;
        }

        public bool CommentDislikedByUser(int userId, int commentId)
        {
            return _context.Likes.Any(l => l.UserId == userId && (l.CommentId != null && l.CommentId == commentId) && l.Type == false);
        }

        public bool CommentLikedByUser(int userId, int commentId)
        {
            return _context.Likes.Any(l => l.UserId == userId && (l.CommentId != null && l.CommentId == commentId) && l.Type == true);
        }

        public bool CommentLikeExists(int userId, int commentId)
        {
            return _context.Likes.Any(l => l.UserId == userId && (l.CommentId != null && l.CommentId == commentId));
        }

        public bool DeleteCommentLikes(ICollection<Like> likes)
        {
            _context.RemoveRange(likes);
            return Save();
        }

        public int GetCommentDislikes(int commentId)
        {
            return _context.Likes.Count(l => l.Type == false && l.CommentId == commentId);
        }

        public Like GetCommentLikeByIds(int userId, int commentId)
        {
            return _context.Likes.Where(l => l.UserId == userId && (l.CommentId != null && l.CommentId == commentId)).FirstOrDefault();
        }

        public int GetCommentLikes(int commentId)
        {
            return _context.Likes.Count(l => l.Type == true && l.CommentId == commentId);
        }

        public ICollection<Like> GetLikes()
        {
            return _context.Likes.ToList();
        }

        public ICollection<Like> GetLikesByCommentId(int commentId)
        {
            return _context.Likes.Where(l => l.CommentId != null && l.CommentId == commentId).ToList();
        }

        public int GetPostDislikes(int postId)
        {
            return _context.Likes.Count(l => l.Type == false && l.PostId == postId);
        }

        public Like GetPostLikeByIds(int userId, int commentId)
        {
            return _context.Likes.Where(l => l.UserId == userId && (l.PostId != null && l.PostId == commentId)).FirstOrDefault();
        }

        public int GetPostLikes(int postId)
        {
            return _context.Likes.Count(l => l.Type == true && l.PostId == postId);
        }

        public bool Like(Like like)
        {
            _context.Add(like);
            return Save();
        }

        public bool PostDislikedByUser(int userId, int postId)
        {
            return _context.Likes.Any(l => l.UserId == userId && (l.PostId != null && l.PostId == postId) && l.Type == false);
        }

        public bool PostLikedByUser(int userId, int postId)
        {
            return _context.Likes.Any(l => l.UserId == userId && (l.PostId != null && l.PostId == postId) && l.Type == true);
        }

        public bool PostLikeExists(int userId, int commentId)
        {
            return _context.Likes.Any(l => l.UserId == userId && (l.PostId != null && l.PostId == commentId));
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved > 0;
        }

        public bool Unlike(Like like)
        {
            _context.Remove(like);
            return Save();
        }

        public bool UpdateLike(Like like)
        {
            _context.Update(like);
            return Save();
        }
    }
}
