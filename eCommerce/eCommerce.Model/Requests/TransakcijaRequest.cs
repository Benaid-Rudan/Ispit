using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class TransakcijaRequest
    {
        
        [Required]
        public int KorisnikId { get; set; }
        [Required]
        public int Iznos { get; set; }
        [Required]
        public DateTime DatumTransakcije { get; set; }
        [Required]
        public string Opis { get; set; }
        [Required]
        public int KategorijaTransakcijeId { get; set; }
        [Required]
        public string Status { get; set; }
    }
}
