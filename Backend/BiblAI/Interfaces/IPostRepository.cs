using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface IPostRepository
    {
        ICollection<Post> getPosts();
    }
}
