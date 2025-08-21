using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace eCommerce.Model.Requests
{
    public class MoodUpsertRequest
    {
        [Required]
        public int KorisnikId { get; set; }

        [Required]
        public string StatusRaspolozenja { get; set; }
        [Required]
        public string Opis { get; set; }
        [Required]
        public DateTime DatumEvidencije { get; set; }

    }
}