using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class TransakcijaLog
    {
        public int TransakcijaLogId { get; set; }
        public int KorisnikId { get; set; }
        public DateTime VrijemePromjene { get; set; }
        public string StaraVrijednost { get; set; }
        public string NovaVrijednost { get; set; }

    }
}
