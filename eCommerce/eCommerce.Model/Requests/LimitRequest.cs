using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class LimitRequest
    {
       
        [Required]
        public int Iznos { get; set; }
        [Required]
        public int KorisnikId { get; set; }
        [Required]
        public int KategorijaTransakcijeId { get; set; }
    }
}
