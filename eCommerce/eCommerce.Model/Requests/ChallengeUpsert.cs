using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace eCommerce.Model.Requests
{
    public class ChallengeUpsert
    {
        [Required]
        public string NazivIzazova { get; set; } // Naziv izazova, npr. "Proèitaj knjigu"
        [Required]
        public string PraviloUspjeha { get; set; } // Pravilo uspjeha, npr. "100 sklekova"
        [Required]
        public string TipIzazova { get; set; } // Tip izazova: "Fizièki", "Edukativni", "Društveni"

    }
}