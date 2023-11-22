using BiblAI.Models;

namespace BiblAI.Dto
{
    public class PostDto
    {
        public int Id { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public bool Anonym { get; set; }
        public string UserName { get; set; }
        public int UserId { get; set; }
        public string ProfilePictureUrl { get; set; }
        public DateTime Date { get; set; }
        public int CommentsNum { get; set;  } 
        public ICollection<CommentDto> Comments { get; set; }
        public int NumLikes { get; set; }
        public int NumDislike { get; set; }
        public ICollection<PostHashtag> PostHashtag { get; set; }
    }
}
