using System;
using System.ComponentModel.DataAnnotations;

namespace eCommerce.Model.Requests
{
    public class RezervacijaProstoraRequest
    {
        [Required]
        public int KorisnikId { get; set; }
        [Required]
        public int RadniProstorId { get; set; }
        [Required]
        public DateTime DatumRezervacije { get; set; }
        [Required]
        public int Trajanje { get; set; }
        [Required]
        public string Status { get; set; }
        [Required]
        public string Napomena { get; set; }
    }
}