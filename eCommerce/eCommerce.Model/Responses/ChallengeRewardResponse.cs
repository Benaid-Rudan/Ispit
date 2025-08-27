using System;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Responses
{
    public class ChallengeRewardResponse
    {
        public int ChallengeId { get; set; } // Strani kljuè za izazov
        public string NazivNagrade { get; set; } // Naziv nagrade
        public RewardType TipNagrade { get; set; } // Tip nagrade: "Bodovi", "Digitalni badge", "Specijalna dozvola"
        public string Uslov { get; set; } // Uslov za osvajanje (npr. "Završi u 7 dana", "Ostvari 100% rezultat")
        public int? Vrijednost { get; set; } // Vrijednost nagrade u bodovima (ako je tip "Bodovi")

        // Navigacioni property za Entity Framework
        public ChallengeResponse Challenge { get; set; }
    }
} 