using BiblAI.Models;

namespace BiblAI.Dto
{
    public class UserDto
    {
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime BirthDate { get; set; }
        public bool Gender { get; set; }
        public bool Married { get; set; }
        public string Bios { get; set; }
        public string Religion { get; set; }
        public string ProfilePictureUrl { get; set; }
        public ICollection<PostDto> Posts { get; set; }
    }
}
