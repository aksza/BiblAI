using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface IPostRepository
    {
        Task<ICollection<Post>> GetPosts();
        Task<ICollection<Post>> SearchPosts(string search);
        Task<Post> GetPostById(int id);
        Task<bool> CreatePost(Post post);
        Task<bool> UpdatePost(Post post);
        Task<bool> DeletePost(Post post);
        Task<bool> Save();
    }
}
