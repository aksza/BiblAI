using BiblAI.Models;

namespace BiblAI.Dto
{
    public class PostCreateDto
    {
        public string Question { get; set; }
        public string Answer { get; set; }
        public string Content { get; set; }
        public bool Anonym { get; set; }
        public int UserId { get; set; }
        public DateTime Date { get; set; }
    }
}
