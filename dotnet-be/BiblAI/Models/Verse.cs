namespace BiblAI.Models
{
    public class Verse
    {
        public int Id { get; set; }
        public string Book { get; set; }
        public string Chapter { get; set; }
        public string Vers { get; set; }
        public string Link { get; set; }
        public int PostId { get; set; }
        public Post Post { get; set; }
    }
}
