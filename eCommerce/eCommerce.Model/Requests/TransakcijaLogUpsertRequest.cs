
using System;
using System.ComponentModel.DataAnnotations;

namespace eCommerce.Model.Requests
{
    public class TransakcijaLogUpsertRequest
    {
        [Required]
        public int KorisnikId { get; set; }
        [Required]

        public int TransakcijaId { get; set; }

        [Required]
        public DateTime VrijemePromjene { get; set; }
        [Required]
        public string StaraVrijednost { get; set; }
        [Required]
        public string NovaVrijednost { get; set; }
    }
}
