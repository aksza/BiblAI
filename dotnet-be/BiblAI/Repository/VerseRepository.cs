using BiblAI.Data;
using BiblAI.Interfaces;
using BiblAI.Models;
using Microsoft.EntityFrameworkCore;

namespace BiblAI.Repository
{
    public class VerseRepository : IVerseRepository
    {

        private DataContext _context;

        public VerseRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<bool> CreateVerse(Verse verse)
        {
            var existingVerse = await _context.Verses
                .Where(v => v.Book == verse.Book && v.Chapter == verse.Chapter && v.Link == verse.Link && v.PostId == verse.PostId && v.Vers == verse.Vers)
                .FirstOrDefaultAsync();

            if (existingVerse == null)
            {
                _context.Verses.Add(verse);
                return await Save();
            }
            else
            {
                return true;
            }
        }

        public async Task<bool> DeleteVerse(Verse verse)
        {
            _context.Remove(verse);
            return await Save();
        }

        public async Task<Verse> GetVerseById(int id)
        {
            return await _context.Verses.Where(u => u.Id == id)
                .FirstOrDefaultAsync();
        }

        public async Task<bool> Save()
        {
            return (await _context.SaveChangesAsync()) > 0;
        }

    }
}
