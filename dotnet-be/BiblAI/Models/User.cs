namespace BiblAI.Models
{
    public class User
    {
        public User(int id, string userName, string firstName, string lastName, string email, string password, bool gender, bool married, string bios, string religion)
        {
            Id = id;
            UserName = userName;
            FirstName = firstName;
            LastName = lastName;
            Email = email;
            Password = password;
            BirthDate = DateTime.Now;
            Gender = gender;
            Married = married;
            Bios = bios;
            Religion = religion;
            Comments = null;
            Posts = null;
            Likes = null;
        }

        public int Id { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public DateTime BirthDate { get; set; }
        public bool Gender { get; set; }
        public bool Married { get; set; }
        public string Bios { get; set; }
        public string Religion { get; set; }
        public ICollection<Post> Posts { get; set; }
        public ICollection<Comment> Comments { get; set; }
        public ICollection<Like> Likes { get; set;  }
    }
}
