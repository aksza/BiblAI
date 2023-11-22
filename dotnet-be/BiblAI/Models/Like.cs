namespace BiblAI.Models
{
    public class Like
    {
        public int Id { get; set; }
        public bool Type { get; set; }
        public User User { get; set; }
        public Post? Post { get; set; }
        public Comment? Comment { get; set; }
    }
}
