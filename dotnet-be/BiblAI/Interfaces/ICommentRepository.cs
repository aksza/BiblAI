using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface ICommentRepository
    {
        bool CreateComment(Comment comment);
        bool DeleteComment(Comment comment);
        bool CommentExists(int id);
        Comment GetCommentById(int id);
        bool Save();
    }
}
