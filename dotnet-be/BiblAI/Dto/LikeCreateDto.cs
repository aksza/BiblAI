using BiblAI.Models;

namespace BiblAI.Dto
{
    public class LikeCreateDto
    {
        public bool Type { get; set; }
        public int UserId { get; set; }
        public int CommentId { get; set; }
    }
}
