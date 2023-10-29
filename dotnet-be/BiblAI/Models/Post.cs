namespace BiblAI.Models
{
    public class Post
    {
        public Post(int id, string question, string answer, bool anonym, User user, ICollection<Comment> comments)
        {
            Id = id;
            Question = question;
            Answer = answer;
            Anonym = anonym;
            User = user;
            Date = DateTime.Now;
            Comments = comments;
            Likes = null;
            PostHashtag = null;
        }

        public int Id { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public bool Anonym { get; set; }
        public User User { get; set; }
        public DateTime Date { get; set; }
        public ICollection<Comment> Comments { get; set; }
        public ICollection<Like> Likes { get; set; }
        public ICollection<PostHashtag> PostHashtag { get; set; }
    }
}
