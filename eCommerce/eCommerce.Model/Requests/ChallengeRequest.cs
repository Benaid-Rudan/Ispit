using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Model.Requests
{
    public class ChallengeRequest
    {
        [Required]
        public string Naziv { get; set; }
        [Required]
        public string TipIzazova { get; set; }
        [Required]
        public int PraviloUspjeha { get; set; }

    }
}