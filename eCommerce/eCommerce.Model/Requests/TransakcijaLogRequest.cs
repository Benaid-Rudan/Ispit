using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
   public class TransakcijaLogRequest
    {
        
        [Required]
        public int TransakcijaId { get; set; }
        [Required]

        public string StaraVrijednost { get; set; }
        [Required]
        public string NovaVrijednost { get; set; }
        [Required]
        public DateTime DatumPromjene { get; set; }
        [Required]
        public int KorisnikId { get; set; }
    }
}
