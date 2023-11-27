namespace BiblAI.Dto
{
    public class UserCreateDto
    {
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string ProfilePictureUrl { get; set; }
        public DateTime BirthDate { get; set; }
        public bool Gender { get; set; }
        public bool Married { get; set; }
        public string Bios { get; set; }
        public string Religion { get; set; }
    }
}
