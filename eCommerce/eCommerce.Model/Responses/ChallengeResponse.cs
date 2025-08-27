using System;

namespace eCommerce.Model.Responses
{
    public class ChallengeResponse
    {
        public string NazivIzazova { get; set; } // Naziv izazova, npr. "Proèitaj knjigu"
        public string PraviloUspjeha { get; set; } // Pravilo uspjeha, npr. "100 sklekova"
        public string TipIzazova { get; set; } // Tip izazova: "Fizièki", "Edukativni", "Društveni"
    }
} 