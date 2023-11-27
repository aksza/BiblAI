using BiblAI.Data;
using BiblAI.Models;
using System.Diagnostics.Metrics;

namespace BiblAI
{
    public class Seed
    {
        private readonly DataContext dataContext;
        public Seed(DataContext context)
        {
            this.dataContext = context;
        }
        public void SeedDataContext()
        {
            if (!dataContext.Posts.Any())
            {
                var user1 = new User()
                {
                    UserName = "szoverfi.dani",
                    FirstName = "Szövérfi",
                    LastName = "Dániel",
                    Email = "szoverfi.daniel@student.ms.sapientia.ro",
                    Password = "jelszo",
                    ProfilePictureUrl = "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                    BirthDate = new DateTime(1998, 12, 20),
                    Gender = true,
                    Married = false,
                    Bios = "I am a Christian and I love Jesus!",
                    Religion = "Reformed"
                };
                var user2 = new User()
                {
                    UserName = "suciu.aksza",
                    FirstName = "Suciu",
                    LastName = "Aksza",
                    Email = "suciu.aksza@student.ms.sapientia.ro",
                    Password = "jelszo",
                    ProfilePictureUrl = "https://i.pinimg.com/474x/98/51/1e/98511ee98a1930b8938e42caf0904d2d.jpg",
                    BirthDate = new DateTime(2002, 9, 18),
                    Gender = false,
                    Married = false,
                    Bios = "I am a Christian and I love Jesus!",
                    Religion = "Faith church"
                };
                var user3 = new User()
                {
                    UserName = "simon.peter",
                    FirstName = "Simon",
                    LastName = "Péter",
                    Email = "simon.peter@student.ms.sapientia.ro",
                    Password = "jelszo",
                    ProfilePictureUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3HWiMNcayzEoGFI70CWs-4GRnFFMgIcR4Ig&usqp=CAU",
                    BirthDate = new DateTime(2003, 6, 9),
                    Gender = true,
                    Married = false,
                    Bios = "I am a Christian and I love Jesus!",
                    Religion = "Reformed"
                };

                dataContext.Users.Add(user1);
                dataContext.Users.Add(user2);
                dataContext.Users.Add(user3);
                /*
                var verse1 = new Verse
                {
                    Book = "John",
                    Chapter = 3,
                    Vers = 16,
                };

                var verse2 = new Verse
                {
                    Book = "John",
                    Chapter = 14,
                    Vers = 6,
                };

                var verse3 = new Verse
                {
                    Book = "Matthew",
                    Chapter = 22,
                    Vers = 37,
                };

                var verse4 = new Verse
                {
                    Book = "Matthew",
                    Chapter = 22,
                    Vers = 39,
                };
                var verse5 = new Verse
                {
                    Book = "Matthew",
                    Chapter = 22,
                    Vers = 37,
                };

                var verse6 = new Verse
                {
                    Book = "Matthew",
                    Chapter = 22,
                    Vers = 39,
                };

                dataContext.Verses.Add(verse1);
                dataContext.Verses.Add(verse2);
                dataContext.Verses.Add(verse3);
                dataContext.Verses.Add(verse4);
                dataContext.Verses.Add(verse5);
                dataContext.Verses.Add(verse6);

                var post1 = new Post
                {
                    Question = "Who is Jesus according to the Bible?",
                    Answer = "Jesus is the son of God, who died for our sins. He is the savior of the world. He is the way, the truth and the life.",
                    Anonym = false,
                    User = user1,
                    Date = DateTime.Now,
                    Verses = new List<Verse> { verse1,verse2}
                };

                var post2 = new Post
                {
                    Question = "What is the meaning of life?",
                    Answer = "The meaning of life is to love God and to love your neighbor as yourself.",
                    Anonym = false,
                    User = user2,
                    Date = DateTime.Now,
                    Verses = new List<Verse> { verse3, verse4 }
                };

                var post3 = new Post
                {
                    Question = "What is the meaning of life?",
                    Answer = "The meaning of life is to love God and to love your neighbor as yourself.",
                    Anonym = false,
                    User = user3,
                    Date = DateTime.Now,
                    Verses = new List<Verse> { verse5, verse6 }
                };

                dataContext.Posts.Add(post1);
                dataContext.Posts.Add(post2);
                dataContext.Posts.Add(post3);

                var comment1 = new Comment
                {
                    Content = "Nice post!",
                    User = user2,
                    Post = post1,
                    Date = DateTime.Now,
                };
                var comment2 = new Comment
                {
                    Content = "Nice post!",
                    User = user2,
                    Post = post1,
                    Date = DateTime.Now,
                };
                var comment3 = new Comment
                {
                    Content = "Nice post!",
                    User = user2,
                    Post = post1,
                    Date = DateTime.Now,
                };

                dataContext.Comments.Add(comment1);
                dataContext.Comments.Add(comment2);
                dataContext.Comments.Add(comment3);

                var hashtag = new Hashtag
                {
                    Name = "Purpose of life",
                };

                dataContext.Hashtags.Add(hashtag);

                var postHashtag1 = new PostHashtag
                {
                    Post = post1,
                    Hashtag = hashtag,
                };
                var postHashtag2 = new PostHashtag
                {
                    Post = post2,
                    Hashtag = hashtag,
                };
                var postHashtag3 = new PostHashtag
                {
                    Post = post3,
                    Hashtag = hashtag,
                };

                dataContext.PostHashtags.Add(postHashtag1);
                dataContext.PostHashtags.Add(postHashtag2);
                dataContext.PostHashtags.Add(postHashtag3);

                var like1 = new Like
                {
                    Type = true,
                    User = user1,
                    Post = post1,
                };var like2 = new Like
                {
                    Type = true,
                    User = user1,
                    Post = post2,
                };var like3 = new Like
                {
                    Type = true,
                    User = user1,
                    Post = post3,
                };var like4 = new Like
                {
                    Type = true,
                    User = user2,
                    Post = post1,
                };var like5 = new Like
                {
                    Type = true,
                    User = user2,
                    Post = post3,
                };var like6 = new Like
                {
                    Type = true,
                    User = user3,
                    Post = post1,
                };

                dataContext.Likes.Add(like1);
                dataContext.Likes.Add(like2);
                dataContext.Likes.Add(like3);
                dataContext.Likes.Add(like4);
                dataContext.Likes.Add(like5);
                dataContext.Likes.Add(like6);
                */

                dataContext.SaveChanges();
                
            }
        }
    }
}
