using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eCommerce.Model.Enum;

namespace eCommerce.Services.Database
{
    public class PeerChallenge
    {
        public int PeerChallengeId { get; set; }
        public int IzazivacId { get; set; } // ID korisnika koji šalje izazov
        public int IzazvaniId { get; set; } // ID korisnika koji prima izazov
        public int ChallengeId { get; set; } // ID izazova koji se šalje

        // Status peer izazova
        public StatusPeer Status { get; set; } // "Poslan", "Prihvaćen", "Odbijen", "Završen"
        public DateTime DatumKreiranja { get; set; } // Datum kreiranja (slanja) izazova

        // Navigacioni properties za Entity Framework
        public User Izazivac { get; set; }
        public User Izazvani { get; set; }
        public Challenge Challenge { get; set; }
    }
}
