using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class ChallengeRequest
    {
        [Required]
        public string Naziv { get; set; }
        [Required]
        public string Pravilo { get; set; }
        [Required]
        public string TipIzazova { get; set; }
    }
}
