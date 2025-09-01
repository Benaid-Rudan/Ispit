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
        public string Naziv { get; set; }
        public string Pravilo { get; set; }
        public TipIzazov TipIzazova { get; set; }

        public enum TipIzazov
        {
            Fizicki=1,
            Edukativni = 2
        }
    }
}
