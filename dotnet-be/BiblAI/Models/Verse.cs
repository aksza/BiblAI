namespace BiblAI.Models
{
    public class Verse
    {
        public int Id { get; set; }
        public string Book { get; set; }
        public int Chapter { get; set; }
        public int Vers { get; set; }
        public int PostId { get; set; }
        public Post Post { get; set; }
    }
}
