namespace BiblAI.Models
{
    public class AiAnswer
    {
        public string Answer { get; set; }
        public string Question { get; set; }
        public string Time { get; set; }
        public ICollection<AiVerse> Verses { get; set; }
    }
}
