using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class PeerChallengeResponse
    {
        public int PeerChallengeId { get; set; }
        public int IzazivacId { get; set; }
        public UserResponse Izazivac { get; set; }
        public int IzazvaniId { get; set; }
        public UserResponse Izazvani { get; set; }
        public int ChallengeId { get; set; }
        public ChallengeResponse Challenge { get; set; }
        public string StatusPeera { get; set; }
        public DateTime DatumKreiranja { get; set; }
    }
}
