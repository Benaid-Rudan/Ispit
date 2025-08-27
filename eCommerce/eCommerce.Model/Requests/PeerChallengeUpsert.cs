using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Requests
{
    public class PeerChallengeUpsert
    {
        
        [Required]
        public int IzazivacId { get; set; } // ID korisnika koji šalje izazov
        [Required]
        public int IzazvaniId { get; set; } // ID korisnika koji prima izazov
        [Required]
        public int ChallengeId { get; set; } // ID izazova koji se šalje

        // Status peer izazova
        [Required]
        public string Status { get; set; } // "Poslan", "Prihvaæen", "Odbijen", "Završen"
        [Required]
        public DateTime DatumKreiranja { get; set; } // Datum kreiranja (slanja) izazova

    }
}