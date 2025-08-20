using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class RezervacijaProstoraResponse
    {
        public int RezervacijaProstoraId { get; set; }
        public int KorisnikId { get; set; }
        public UserResponse Korisnik { get; set; }
        public int RadniProstorId { get; set; }
        public RadniProstorResponse RadniProstor { get; set; }
        public DateTime DatumRezervacije { get; set; }
        public int Trajanje { get; set; }
        public string StatusRezervacije { get; set; }
        public string Napomena { get; set; }
    }
}
