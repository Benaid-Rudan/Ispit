using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Model.Requests
{
    public class PeerChallengeRequest
    {
        [Required]
        public int IzazivacId { get; set; }
        [Required]
        public int IzazvaniId { get; set; }
        [Required]
        public int ChallengeId { get; set; }
        [Required]
        public string StatusPeer { get; set; }
        [Required]
        public DateTime DatumKreiranja { get; set; }

    }
}