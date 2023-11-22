using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface ICommentRepository
    {
        bool CreateComment(Comment comment);
        bool DeleteComment(Comment comment);
        Comment GetCommentById(int id);
        bool Save();
    }
}
