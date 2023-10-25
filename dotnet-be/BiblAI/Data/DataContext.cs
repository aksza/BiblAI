using Microsoft.EntityFrameworkCore;
using BiblAI.Models;

namespace BiblAI.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {

        }

        public DbSet<User> User { get; set; }
        public DbSet<Post> Post { get; set; }
        public DbSet<Comment> Comment { get; set; }
        public DbSet<Like> Like { get; set; }
        public DbSet<Hashtag> Hashtag { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PostHashtag>()
                 .HasKey(ph => new { ph.PostId, ph.HashtagId });
            modelBuilder.Entity<PostHashtag>()
                    .HasOne(p => p.Post)
                    .WithMany(ph => ph.PostHashtag)
                    .HasForeignKey(p => p.PostId);
            modelBuilder.Entity<PostHashtag>()
                    .HasOne(h => h.Hashtag)
                    .WithMany(ph => ph.PostHashtag)
                    .HasForeignKey(h => h.HashtagId);
        }
    } 
}
