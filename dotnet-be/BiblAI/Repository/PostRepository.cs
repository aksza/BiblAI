using BiblAI.Data;
using BiblAI.Interfaces;
using BiblAI.Models;
using Microsoft.EntityFrameworkCore;

namespace BiblAI.Repository
{
    public class PostRepository : IPostRepository
    {
        private DataContext _context;

        public PostRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<bool> CreatePost(Post post)
        {
            _context.Add(post);
            return await Save();
        }

        public async Task<bool> DeletePost(Post post)
        {
            _context.Remove(post);
            return await Save();
        }

        public async Task<Post> GetPostById(int id)
        {
            return await _context.Posts.FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<ICollection<Post>> GetPosts()
        {
            return await _context.Posts.Include(p => p.Comments).ToListAsync();
        }

        public async Task<bool> Save()
        {
            return (await _context.SaveChangesAsync()) > 0;
        }

        public async Task<ICollection<Post>> SearchPosts(string search)
        {
            return await _context.Posts.Where(p => p.Question.ToUpper().Contains(search.ToUpper())).Include(p => p.Comments).ToListAsync();
        }

        public async Task<bool> UpdatePost(Post post)
        {
            _context.Update(post);
            return await Save();
        }
    }
}
