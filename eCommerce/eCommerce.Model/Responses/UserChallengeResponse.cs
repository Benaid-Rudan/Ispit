using System;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Responses
{
    public class UserChallengeResponse
    {
        public int UserChallengeId { get; set; }
        public int IzazvaniId { get; set; } // Strani ključ za korisnika koji je prihvatio izazov
        public int ChallengeId { get; set; } // Strani ključ za prihvaćeni izazov

        // Status izazova za ovog korisnika
        public string StatusIzazova { get; set; } // "Prihvaćen", "U toku", "Završeno", "Odustao"
        public DateTime DatumPrihvatanja { get; set; } // Datum prihvatānja
        public int Napredak { get; set; } // Brojčani napredak (npr. 50 od 100 sklekova)
        public DateTime? VrijemeZavrsetka { get; set; } // Vrijeme završetka (null ako nije završeno)

        // Navigacioni properties za Entity Framework
        public UserResponse Korisnik { get; set; }
        public ChallengeResponse Challenge { get; set; }
    }
} 