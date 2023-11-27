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

        public bool CreateUser(User user)
        {
            _context.Add(user);
            return Save();
        }

        public bool DeleteUser(User user)
        {
            _context.Remove(user);
            return Save();
        }

        public User GetUserById(int id)
        {
            return _context.Users.Where(u => u.Id == id)
                .Include(u => u.Posts).Include(u => u.Comments)
                .FirstOrDefault();
        }

        public ICollection<User> GetUsers()
        {
            return _context.Users.ToList();
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved > 0;
        }

        public bool UpdateUser(User user)
        {
            _context.Update(user);
            return Save();
        }
    }
}
