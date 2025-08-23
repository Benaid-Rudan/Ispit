using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class Transakcija
    {
        public int TransakcijaId { get; set; }
        public int KorisnikId { get; set; }
        public User Korisnik { get; set; }
        public int Iznos { get; set; }
        public DateTime DatumTransakcije { get; set; }

        public string Opis { get; set; }
        public int KategorijaTransakcijeId { get; set; }
        public KategorijaTransakcije KategorijaTransakcije { get; set; }
        public Status StatusTransakcije { get; set; }
        public enum Status
        {
            Planiran,
            Zavrsen,
            Otkazan
        }
    }
}
