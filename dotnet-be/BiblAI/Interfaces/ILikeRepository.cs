using BiblAI.Models;
using System.ComponentModel.Design;

namespace BiblAI.Interfaces
{
    public interface ILikeRepository
    {
        ICollection<Like> GetLikes();
        ICollection<Like> GetLikesByCommentId(int commentId);
        int GetPostLikes(int postId);
        int GetPostDislikes(int postId);
        int GetCommentLikes(int commentId);
        int GetCommentDislikes(int commentId);
        bool CommentLikeExists(int userId, int commentId);
        Like GetCommentLikeByIds(int userId, int commentId);
        bool PostLikeExists(int userId, int commentId);
        Like GetPostLikeByIds(int userId, int commentId);
        bool Like(Like like);
        bool UpdateLike(Like like);
        bool Unlike(Like like);
        bool DeleteCommentLikes(ICollection<Like> likes);
        bool Save();
    }
}
