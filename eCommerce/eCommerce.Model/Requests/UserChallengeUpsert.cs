using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Requests
{
    public class UserChallengeUpsert
    {
        [Required]
        public int IzazvaniId { get; set; } // Strani ključ za korisnika koji je prihvatio izazov
        [Required]
        public int ChallengeId { get; set; } // Strani ključ za prihvaćeni izazov

        // Status izazova za ovog korisnika
        [Required]
        public StatusIzazov StatusIzazova { get; set; } // "Prihvaćen", "U toku", "Završeno", "Odustao"
        [Required]
        public DateTime DatumPrihvatanja { get; set; } // Datum prihvatānja
        [Required]
        public int Napredak { get; set; } // Brojčani napredak (npr. 50 od 100 sklekova)
        [Required]
        public DateTime? VrijemeZavrsetka { get; set; } // Vrijeme završetka (null ako nije završeno)

    }
}