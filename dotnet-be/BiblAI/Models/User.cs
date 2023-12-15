namespace BiblAI.Models
{
    public class User
    { 
        public int Id { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public byte[] PasswordSalt { get; set; }
        public byte[] PasswordHash { get; set; }
        public string ProfilePictureUrl { get; set; }
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
