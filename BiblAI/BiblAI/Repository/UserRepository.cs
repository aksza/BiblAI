using BiblAI.Interfaces;
using BiblAI.Models;

namespace BiblAI.Repository
{
    public class UserRepository : IUserRepository
    {
        public User GetUserById(int id)
        {
            return new User(id, "szoverfi.dani", "Szövérfi", "Dániel", "szoverfi.daniel@student.ms.sapientia.ro", "jelszo", true, false, "helllo hello sziasztok Daniel vagyok", "főkép reformatus");
        }
    }
}
