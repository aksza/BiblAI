namespace BiblAI.Models
{
    public class Post
    {
        public int Id { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public bool Anonym { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
        public DateTime Date { get; set; }
        public ICollection<Comment> Comments { get; set; }
        public ICollection<Verse> Verses { get; set; }
        public ICollection<Like> Likes { get; set; }
        public ICollection<PostHashtag> PostHashtags { get; set; }
    }
}
