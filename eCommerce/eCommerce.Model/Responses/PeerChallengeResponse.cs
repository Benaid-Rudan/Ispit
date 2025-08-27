using System;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Responses
{
    public class PeerChallengeResponse
    {
        public int PeerChallengeId { get; set; }

        public int IzazivacId { get; set; } // ID korisnika koji šalje izazov
        public int IzazvaniId { get; set; } // ID korisnika koji prima izazov
        public int ChallengeId { get; set; } // ID izazova koji se šalje

        // Status peer izazova
        public string Status { get; set; } // "Poslan", "Prihvaæen", "Odbijen", "Završen"
        public DateTime DatumKreiranja { get; set; } // Datum kreiranja (slanja) izazova

        // Navigacioni properties za Entity Framework
        public UserResponse Izazivac { get; set; }
        public UserResponse Izazvani { get; set; }
        public ChallengeResponse Challenge { get; set; }
    }
} 