using System;
using System.Collections.Generic;
using System.Text;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Model.Responses
{
    public class ChallengeResponse
    {
        public int ChallengeId { get; set; }
        public string Naziv { get; set; }
        public string TipIzazova { get; set; }
        public int PraviloUspjeha { get; set; }
    }
}
