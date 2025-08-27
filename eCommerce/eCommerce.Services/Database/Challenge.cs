using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class Challenge
    {
        public int ChallengeId { get; set; }
        public string NazivIzazova { get; set; } // Naziv izazova, npr. "Pročitaj knjigu"
        public string PraviloUspjeha { get; set; } // Pravilo uspjeha, npr. "100 sklekova"
        public string TipIzazova { get; set; } // Tip izazova: "Fizički", "Edukativni", "Društveni"
    }
}
