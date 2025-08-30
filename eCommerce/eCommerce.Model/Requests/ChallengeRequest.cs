using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Requests
{
    public class ChallengeRequest
    {
        [Required]
        public string Naziv { get; set; }
        [Required]
        public string PraviloUspjeha { get; set; }
        [Required]
        public string TipIzazova { get; set; }

    }
}