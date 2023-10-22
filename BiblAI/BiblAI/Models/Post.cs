namespace BiblAI.Models
{
    public class Post
    {
        public Post(int id, string question, string answer, bool anonym, User user)
        {
            Id = id;
            Question = question;
            Answer = answer;
            Anonym = anonym;
            User = user;
        }

        public int Id { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public bool Anonym { get; set; }
        public User User { get; set; }

    }
}
