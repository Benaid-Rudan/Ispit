using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class KategorijaTransakcije
    {
        public int KategorijaTransakcijeId { get; set; }
        public string Naziv { get; set; }
        public string Tip { get; set; }
    }
}
