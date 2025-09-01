using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class PeerRequest
    {
        [Required]
        public int IzazivacId { get; set; }
        [Required]
        public int IzazvaniId { get; set; }
        [Required]
        public int ChallengeId { get; set; }
        [Required]
        public string StatusPeera { get; set; }
        [Required]
        public DateTime DatumKreiranja { get; set; }
    }
}
