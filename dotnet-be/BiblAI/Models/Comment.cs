namespace BiblAI.Models
{
    public class Comment
    {
        public Comment(int id, string content, User user)
        {
            Id = id;
            Content = content;
            User = user;
            Post = null;
            Date = DateTime.Now;
        }

        public int Id { get; set; }
        public string Content { get; set; }
        public User User { get; set; }
        public Post Post { get; set; }
        public DateTime Date { get; set; }
    }
}
