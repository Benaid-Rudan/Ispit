using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class PeerChallenge
    {
        public int PeerChallengeId { get; set; }
        public int IzazivacId { get; set; }
        public User Izazivac { get; set; }
        public int IzazvaniId { get; set; }
        public User Izazvani { get; set; }
        public int ChallengeId { get; set; }
        public Challenge Challenge { get; set; }

        public StatusPeer StatusPeera { get; set; }
        public DateTime DatumKreiranja { get; set; }
        public enum StatusPeer
        {
            Poslan=1,
            Prihvacen=2,
            Odbijen=3
        }
    }
}
