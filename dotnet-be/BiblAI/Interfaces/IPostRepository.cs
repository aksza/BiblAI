using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface IPostRepository
    {
        ICollection<Post> GetPosts();
        ICollection<Post> SearchPosts(string search);
        Post GetPostById(int id);
        bool CreatePost(Post post);
        bool UpdatePost(Post post);
        bool DeletePost(Post post);
        bool Save();
    }
}
