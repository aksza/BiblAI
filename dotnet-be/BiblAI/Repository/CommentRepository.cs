using BiblAI.Data;
using BiblAI.Interfaces;
using BiblAI.Models;
using Microsoft.EntityFrameworkCore;

namespace BiblAI.Repository
{
    public class CommentRepository : ICommentRepository
    {
        private DataContext _context;
        public CommentRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<bool> CommentExists(int id)
        {
            return await _context.Comments.AnyAsync(c => c.Id == id);
        }

        public async Task<bool> CreateComment(Comment comment)
        {
            _context.Add(comment);
            return await Save();
        }

        public async Task<bool> DeleteComment(Comment comment)
        {
            _context.Remove(comment);
            return await Save();
        }

        public async Task<Comment> GetCommentById(int id)
        {
            return await _context.Comments.FirstOrDefaultAsync(c => c.Id == id);
        }

        public async Task<bool> Save()
        {
            return (await _context.SaveChangesAsync()) > 0;
        }
    }
}
