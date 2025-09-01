using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class UserChallenge
    {
        public int UserChallengeId { get; set; }
        public int KorisnikId { get; set; }
        public User Korisnik { get; set; }
        public int ChallengeId { get; set; }
        public Challenge Challenge { get; set; }
        public DateTime DatumPrihvatanja { get; set; }
        public StatusIzazov StatusIzazova { get; set; }
        public int Napredak { get; set; }
        public DateTime VrijemeZavrsetka { get; set; }
        public enum StatusIzazov
        {
            Prihvacen=1,
            UToku=2,
            Zavrsen=3,
            Odustao=4
        }
    }
}
