using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
   public class TransakcijaLogResponse
    {
        public int TransakcijaLogId { get; set; }
        public int TransakcijaId { get; set; }
        
        public string StaraVrijednost { get; set; }
        public string NovaVrijednost { get; set; }
        public DateTime DatumPromjene { get; set; }
        public int KorisnikId { get; set; }
        public UserResponse Korisnik { get; set; }
    }
}
