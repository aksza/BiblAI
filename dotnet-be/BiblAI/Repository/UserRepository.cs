using BiblAI.Data;
using BiblAI.Interfaces;
using BiblAI.Models;
using Microsoft.EntityFrameworkCore;

namespace BiblAI.Repository
{
    public class UserRepository : IUserRepository
    {
        private DataContext _context;

        public UserRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<bool> CreateUser(User user)
        {
            _context.Add(user);
            return await Save();
        }

        public async Task<bool> DeleteUser(User user)
        {
            _context.Remove(user);
            return await Save();
        }

        public async Task<User> GetUserById(int id)
        {
            var user = await _context.Users
        .Where(u => u.Id == id)
        .Select(u => new
        {
            User = u,
            Posts = u.Posts.Select(p => new
            {
                Post = p,
                Comments = p.Comments,
                Verses = p.Verses
            })
        })
        .FirstOrDefaultAsync();

            if (user != null)
            {
                user.User.Posts = user.Posts.Select(p => p.Post).ToList();
                return user.User;
            }

            return null;
        }

        public async Task<User> GetUserByUserName(string userName)
        {
            return await _context.Users.Where(u => u.UserName == userName).FirstOrDefaultAsync();
        }

        public async Task<ICollection<User>> GetUsers()
        {
            return await _context.Users.ToListAsync();
        }

        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0;
        }

        public async Task<bool> UpdateUser(User user)
        {
            _context.Update(user);
            return await Save();
        }
    }
}
