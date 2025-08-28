using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Model.Requests
{
    public class UserChallengeRequest
    {
        [Required]
        public int IzazvaniId { get; set; }
        [Required]
        public int ChallengeId { get; set; }
        [Required]
        public DateTime DatumPrihvatanja { get; set; }
        [Required]
        public string StatusIzazov { get; set; }
        [Required]
        public int Napredak { get; set; }
        [Required]
        public DateTime VrijemeZavrsetka { get; set; }

    }
}