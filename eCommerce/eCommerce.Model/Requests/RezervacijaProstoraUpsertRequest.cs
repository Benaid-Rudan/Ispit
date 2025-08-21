using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace eCommerce.Model.Requests
{
    public class RezervacijaProstoraUpsertRequest
    {
        [Required]
        public int RadniProstorId { get; set; }
        [Required]
        public int KorisnikId { get; set; }
        [Required]
        public DateTime DatumEvidencije { get; set; }
        [Required]
        public int Trajanje { get; set; }
        [Required]
        public string StatusRezervacije { get; set; }
        [Required]
        public string Napomena { get; set; }

    }
} 