using System;
using System.ComponentModel.DataAnnotations;
using eCommerce.Model.Responses;

namespace eCommerce.Model.Requests
{
    public class MoodRequest
    {
        [Required]
        public int KorisnikId { get; set; }
        [Required]
        public string Status { get; set; }
        [Required]
        public DateTime DatumEvidencije { get; set; }
        [Required]
        public string Opis { get; set; }
    }
}