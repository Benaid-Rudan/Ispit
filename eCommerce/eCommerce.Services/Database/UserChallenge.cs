using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Services.Database
{
    public class UserChallenge
    {
        public int UserChallengeId { get; set; }
        public int IzazvaniId { get; set; }
        public User Izazvani { get; set; }
        public int ChallengeId { get; set; }
        public Challenge Challenge { get; set; }
        public DateTime DatumPrihvatanja { get; set; }
        public StatusIzazova StatusIzazov { get; set; }
        public int Napredak { get; set; }
        public DateTime VrijemeZavrsetka { get; set; }
    }
}
