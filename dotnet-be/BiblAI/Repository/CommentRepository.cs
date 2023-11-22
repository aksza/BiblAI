using BiblAI.Data;
using BiblAI.Interfaces;
using BiblAI.Models;

namespace BiblAI.Repository
{
    public class CommentRepository : ICommentRepository
    {
        private DataContext _context;
        public CommentRepository(DataContext context)
        {
            _context = context;
        }

        public bool CreateComment(Comment comment)
        {
            _context.Add(comment);
            return Save();
        }

        public bool DeleteComment(Comment comment)
        {
            _context.Remove(comment);
            return Save();
        }

        public Comment GetCommentById(int id)
        {
            return _context.Comments.FirstOrDefault(c => c.Id == id);
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved > 0;
        }
    }
}
