using Microsoft.EntityFrameworkCore;
using BiblAI.Models;

namespace BiblAI.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {

        }

        public DbSet<User> Users { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Like> Likes { get; set; }
        public DbSet<Hashtag> Hashtags { get; set; }
        public DbSet<Verse> Verses { get; set; }
        public DbSet<PostHashtag> PostHashtags { get; set; }

       
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PostHashtag>()
                 .HasKey(ph => new { ph.PostId, ph.HashtagId });
            modelBuilder.Entity<PostHashtag>()
                    .HasOne(p => p.Post)
                    .WithMany(ph => ph.PostHashtags)
                    .HasForeignKey(p => p.PostId);
            modelBuilder.Entity<PostHashtag>()
                    .HasOne(h => h.Hashtag)
                    .WithMany(ph => ph.PostHashtag)
                    .HasForeignKey(h => h.HashtagId);
        }
    } 
}
