using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface ICommentRepository
    {
        Task<bool> CreateComment(Comment comment);
        Task<bool> DeleteComment(Comment comment);
        Task<bool> CommentExists(int id);
        Task<Comment> GetCommentById(int id);
        Task<bool> Save();
    }
}
