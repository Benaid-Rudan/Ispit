using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class LimitResponse
    {
        public int LimitId { get; set; }
        public int Iznos { get; set; }
        public int KorisnikId { get; set; }
        public UserResponse Korisnik { get; set; }
        public int KategorijaTransakcijeId { get; set; }
        public KategorijaTransakcijeResponse KategorijaTransakcije { get; set; }
    }
}
