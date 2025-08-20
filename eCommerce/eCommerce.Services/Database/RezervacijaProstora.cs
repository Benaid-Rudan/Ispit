using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class RezervacijaProstora
    {
        public int RezervacijaProstoraId { get; set; }
        public int KorisnikId { get; set; }
        public User Korisnik { get; set; }
        public int RadniProstorId { get; set; }
        public RadniProstor RadniProstor { get; set; }
        public DateTime DatumRezervacije { get; set; }
        public int Trajanje { get; set; }
        public Status StatusRezervacije { get; set; }
        public string Napomena { get; set; }
        public enum Status
        {
            Aktivna,
            Otkazana,
            Zavrsena
        }
    }
}
