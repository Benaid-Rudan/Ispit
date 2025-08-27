using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Requests
{
    public class ChallengeRewardUpsert
    {
        
        [Required]
        public int ChallengeId { get; set; } // Strani kljuè za izazov
        [Required]
        public string NazivNagrade { get; set; } // Naziv nagrade
        [Required]
        public RewardType TipNagrade { get; set; } // Tip nagrade: "Bodovi", "Digitalni badge", "Specijalna dozvola"
        [Required]
        public string Uslov { get; set; } // Uslov za osvajanje (npr. "Završi u 7 dana", "Ostvari 100% rezultat")
        [Required]
        public int? Vrijednost { get; set; } // Vrijednost nagrade u bodovima (ako je tip "Bodovi")

    }
}