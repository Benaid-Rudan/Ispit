using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class ChallengeResponse
    {
        public int ChallengeId { get; set; }
        public string Naziv { get; set; }
        public string PraviloUspjeha { get; set; }
        public string TipIzazova { get; set; }
    }
}
