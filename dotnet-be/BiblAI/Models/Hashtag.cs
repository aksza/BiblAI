namespace BiblAI.Models
{
    public class Hashtag
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<PostHashtag> PostHashtag { get; set; }
    }
}
