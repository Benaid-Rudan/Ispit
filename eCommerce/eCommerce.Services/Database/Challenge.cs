using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Services.Database
{
    public class Challenge
    {
        public int ChallengeId { get; set; }
        public string Naziv { get; set; }
        public TipIzazov TipIzazova { get; set; }
        public int PraviloUspjeha { get; set; }
    }
}
