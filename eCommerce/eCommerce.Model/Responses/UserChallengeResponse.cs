using System;
using System.Collections.Generic;
using System.Text;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Model.Responses
{
    public class UserChallengeResponse
    {
        public int UserChallengeId { get; set; }
        public int IzazvaniId { get; set; }
        public UserResponse Izazvani { get; set; }
        public int ChallengeId { get; set; }
        public ChallengeResponse Challenge { get; set; }
        public DateTime DatumPrihvatanja { get; set; }
        public string StatusIzazov { get; set; }
        public int Napredak { get; set; }
        public DateTime VrijemeZavrsetka { get; set; }
    }
}
