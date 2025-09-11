using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class UserActivityResponse
    {
        public int UserActivityId { get; set; }
        public int KorisnikId { get; set; }
        public UserResponse Korisnik { get; set; }
        public int ActivityId { get; set; }
        public ActivityResponse Activity { get; set; }
        public DateTime DateAssigned { get; set; }
        public string StatusActivity { get; set; }
        public string Note { get; set; }
        public DateTime CompletedAt { get; set; }
        public string? RewardTitle { get; set; }
        public DateTime? RewardedAt { get; set; }
    }
}
