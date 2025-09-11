using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class UserActivityRequest
    {
        [Required]
        public int KorisnikId { get; set; }
        [Required]
        public int ActivityId { get; set; }
        [Required]
        public DateTime DateAssigned { get; set; }
        [Required]
        public string StatusActivity { get; set; }
        [Required]
        public string Note { get; set; }
        [Required]
        public DateTime CompletedAt { get; set; }
        public string? RewardTitle { get; set; }
        public DateTime? RewardedAt { get; set; }
    }
}
