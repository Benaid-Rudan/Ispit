using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class TransakcijaResponse
    {
        public int TransakcijaId { get; set; }
        public int KorisnikId { get; set; }
        public UserResponse Korisnik { get; set; }
        public int Iznos { get; set; }
        public DateTime DatumTransakcije { get; set; }
        public string Opis { get; set; }
        public int KategorijaTransakcijeId { get; set; }
        public KategorijaTransakcijeResponse KategorijaTransakcije { get; set; }

        public string Status { get; set; }
    }
}
