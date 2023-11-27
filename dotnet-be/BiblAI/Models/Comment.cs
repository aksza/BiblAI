﻿namespace BiblAI.Models
{
    public class Comment
    {
        public int Id { get; set; }
        public string Content { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
        public int PostId { get; set; }
        public Post Post { get; set; }
        public DateTime Date { get; set; }
        public ICollection<Like> Likes { get; set; }
    }
}
