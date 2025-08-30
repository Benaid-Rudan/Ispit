using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class MoodResponse
    {
        public int MoodId { get; set; }
        public int KorisnikId { get; set; }
        public UserResponse Korisnik { get; set; }
        public string Status { get; set; }
        public DateTime DatumEvidencije { get; set; }
        public string Opis { get; set; }
    }
}
