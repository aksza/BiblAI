using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface IUserRepository
    {
        User GetUserById(int id);
    }
}
