using BiblAI.Data;
using BiblAI.Interfaces;
using BiblAI.Models;
using Microsoft.EntityFrameworkCore;

namespace BiblAI.Repository
{
    public class LikeRepository : ILikeRepository
    {
        private DataContext _context;
        public LikeRepository(DataContext context) 
        {
            _context = context;
        }

        public int GetCommentDislikes(int commentId)
        {
            return _context.Likes.Count(l => l.Type == false && l.Comment.Id == commentId);
        }

        public int GetCommentLikes(int commentId)
        {
            return _context.Likes.Count(l => l.Type == true && l.Comment.Id == commentId);
        }

        public ICollection<Like> GetLikes()
        {
            return _context.Likes.ToList();
        }

        public int GetPostDislikes(int postId)
        {
            return _context.Likes.Count(l => l.Type == false && l.Post.Id == postId);
        }

        public int GetPostLikes(int postId)
        {
            return _context.Likes.Count(l => l.Type == true && l.Post.Id == postId);
        }

        public bool Like(Like like)
        {
            _context.Add(like);
            return Save();
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
    }
}
