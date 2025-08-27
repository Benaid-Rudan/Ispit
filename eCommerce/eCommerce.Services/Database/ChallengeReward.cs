using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eCommerce.Model.Enum;

namespace eCommerce.Services.Database
{
    public class ChallengeReward
    {
        public int ChallengeRewardId { get; set; }
        public int ChallengeId { get; set; } // Strani ključ za izazov
        public string NazivNagrade { get; set; } // Naziv nagrade
        public RewardType TipNagrade { get; set; } // Tip nagrade: "Bodovi", "Digitalni badge", "Specijalna dozvola"
        public string Uslov { get; set; } // Uslov za osvajanje (npr. "Završi u 7 dana", "Ostvari 100% rezultat")
        public int? Vrijednost { get; set; } // Vrijednost nagrade u bodovima (ako je tip "Bodovi")

        // Navigacioni property za Entity Framework
        public Challenge Challenge { get; set; }
    }
}
