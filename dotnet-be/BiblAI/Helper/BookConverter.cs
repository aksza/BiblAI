namespace BiblAI.Helper
{
    public class BookConverter
    {
        private readonly Dictionary<string, string> _nameMappings = new Dictionary<string, string>
        {
            {"Gen", "GEN"},
            {"Ex", "EXO"},
            {"Lev", "LEV"},
            {"Num", "NUM"},
            {"Deut", "DEU"},
            {"Josh", "JOS"},
            {"Judg", "JDG"},
            {"Ruth", "RUT"},
            {"1 Sam", "1SA"},
            {"2 Sam", "2SA"},
            {"1 Kings", "1KI"},
            {"2 Kings", "2KI"},
            {"1 Chron", "1CH"},
            {"2 Chron", "2CH"},
            {"Ezra", "EZR"},
            {"Neh", "NEH"},
            {"Est", "EST"},
            {"Job", "JOB"},
            {"Psalm", "PSA"},
            {"Prov", "PRO"},
            {"Eccles", "ECC"},
            {"Song", "SNG"},
            {"Isa", "ISA"},
            {"Jer", "JER"},
            {"Lam", "LAM"},
            {"Ezek", "EZK"},
            {"Dan", "DAN"},
            {"Hos", "HOS"},
            {"Joel", "JOL"},
            {"Amos", "AMO"},
            {"Obad", "OBA"},
            {"Jonah", "JON"},
            {"Mic", "MIC"},
            {"Nah", "NAM"},
            {"Hab", "HAB"},
            {"Zeph", "ZEP"},
            {"Hag", "HAG"},
            {"Zech", "ZEC"},
            {"Mal", "MAL"},
            {"Matt", "MAT"},
            {"Mark", "MRK"},
            {"Luke", "LUK"},
            {"John", "JHN"},
            {"Acts", "ACT"},
            {"Rom", "ROM"},
            {"1 Cor", "1CO"},
            {"2 Cor", "2CO"},
            {"Gal", "GAL"},
            {"Eph", "EPH"},
            {"Phil", "PHP"},
            {"Col", "COL"},
            {"1 Thess", "1TH"},
            {"2 Thess", "2TH"},
            {"1 Tim", "1TI"},
            {"2 Tim", "2TI"},
            {"Titus", "TIT"},
            {"Phlm", "PHM"},
            {"Heb", "HEB"},
            {"Jas", "JAS"},
            {"1 Pet", "1PE"},
            {"2 Pet", "2PE"},
            {"1 John", "1JN"},
            {"2 John", "2JN"},
            {"3 John", "3JN"},
            {"Jude", "JUD"},
            {"Rev", "REV"}
        };

        public string ConvertToSpecificName(string originalName)
        {
            _nameMappings.TryGetValue(originalName, out var specificName);
            return specificName;
        }
    }
}
