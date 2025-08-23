using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class FinansijskiLimit
    {
        public int FinansijskiLimitId { get; set; }
        public int KorisnikId { get; set; }
        public int KategorijaId { get; set; }
        public int Limit { get; set; }
    }
}
