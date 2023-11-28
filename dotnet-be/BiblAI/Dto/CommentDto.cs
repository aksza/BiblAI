using BiblAI.Models;

namespace BiblAI.Dto
{
    public class CommentDto
    {
        public int Id { get; set; }
        public string Content { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string ProfilePictureUrl { get; set; }
        public int NumLikes { get; set; }
        public int NumDislikes { get; set; }
        public bool LikedByUser { get; set; }
        public bool DislikedByUser { get; set; }
    }
}
