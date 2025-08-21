using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class Mood
    {
        public int MoodId { get; set; }
        public int KorisnikId { get; set; }
        public User Korisnik { get; set; }
        public Status StatusRaspolozenja { get; set; }
        public string Opis { get; set; }
        public DateTime DatumEvidencije { get; set; }
        public enum Status
        {
            Sretan,
            Tuzan,
            Umoran
        }
    }
}
