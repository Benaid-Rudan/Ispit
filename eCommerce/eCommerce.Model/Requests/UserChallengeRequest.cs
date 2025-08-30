using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using eCommerce.Model.Enum;

namespace eCommerce.Model.Requests
{
    public class UserChallengeRequest
    {
        [Required]
        public int ChallengeId { get; set; }
        [Required]
        public int IzazvaniId { get; set; }
        [Required]
        public DateTime DatumPrihvatanja { get; set; }
        [Required]
        public int Napredak { get; set; }
        [Required]
        public string StatusIzazova { get; set; }
        [Required]
        public DateTime VrijemeZavrsetka { get; set; }

    }
}