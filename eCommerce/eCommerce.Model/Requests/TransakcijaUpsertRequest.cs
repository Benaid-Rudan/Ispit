
using System;
using System.ComponentModel.DataAnnotations;

namespace eCommerce.Model.Requests
{
    public class TransakcijaUpsertRequest
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
        public string StatusTransakcije { get; set; }
    }
}
