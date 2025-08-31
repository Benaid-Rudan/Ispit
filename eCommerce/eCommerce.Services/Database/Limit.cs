using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class Limit
    {
        public int LimitId { get; set; }
        public int Iznos { get; set; }
        public int KorisnikId { get; set; }
        public User Korisnik { get; set; }
        public int KategorijaTransakcijeId { get; set; }
        public KategorijaTransakcije KategorijaTransakcije { get; set; }
    }
}
