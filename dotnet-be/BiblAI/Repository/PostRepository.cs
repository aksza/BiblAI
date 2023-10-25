using BiblAI.Interfaces;
using BiblAI.Models;

namespace BiblAI.Repository
{
    public class PostRepository : IPostRepository
    {
        public ICollection<Post> getPosts()
        {
            User user = new(1, "szoverfi.dani", "Szövérfi", "Dániel", "szoverfi.daniel@student.ms.sapientia.ro", "jelszo", true, false, "helllo hello sziasztok Daniel vagyok", "főkép reformatus");
            return new List<Post>
            {
                new(1, "who was jesus?", "Jesus is the Son of God and the promised Messiah, also known as the Christ. He came to earth to fulfill God's plan of salvation by suffering, dying on the cross, and rising again from the dead. Through His sacrifice, Jesus offers forgiveness of sins and eternal life to all who believe in Him. He is the Savior of the world and the ultimate example of love, compassion, and obedience to God's will. As Christians, we are called to follow Jesus' teachings and strive to live a life that reflects His character.", false, user),
                new(2, "what is the point of life?", "The point of life is to live it in a way that brings glory to God. Our purpose is to honor and please Him in everything we do, whether it is eating, drinking, or any other aspect of life. By seeking to live a life that is well pleasing to the Lord, we can find fulfillment and meaning. It is important to remember that our lives are not just about ourselves, but about serving God and advancing His kingdom. So, let us strive to live in a way that reflects God's love, grace, and truth, and to make a positive impact on the world around us.", false, user),
                new(1, "how can i give my life to christ?", "To give your life to Christ, you need to confess with your mouth that Jesus is Lord and believe in your heart that God raised him from the dead. This means acknowledging that Jesus is the Son of God and accepting him as your Savior and Lord. Surrender your life to him, repent of your sins, and invite him into your heart. Seek a personal relationship with Jesus through prayer, reading the Bible, and joining a community of believers. Live out your faith by following his teachings, loving others, and sharing the good news of salvation with others. Remember, salvation is a gift from God, received through faith, and it is by his grace that we are saved.", false, user),
            }.ToList();
        }
    }
}
