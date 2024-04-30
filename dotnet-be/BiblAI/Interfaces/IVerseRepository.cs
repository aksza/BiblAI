using BiblAI.Models;

namespace BiblAI.Interfaces
{
    public interface IVerseRepository
    {
        Task<Verse> GetVerseById(int id);
        Task<bool> CreateVerse(Verse verse);
        Task<bool> DeleteVerse(Verse verse);
        Task<bool> Save();
    }
}
