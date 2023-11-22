using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface ILikeRepository
    {
        ICollection<Like> GetLikes();
        int GetPostLikes(int postId);
        int GetPostDislikes(int postId);
        int GetCommentLikes(int commentId);
        int GetCommentDislikes(int ommentId);
        bool Like(Like like);
        bool Unlike(Like like);
        bool Save();
    }
}
