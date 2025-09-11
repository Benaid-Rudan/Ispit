using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class UserActivity
    {
        public int UserActivityId { get; set; }
        public int KorisnikId { get; set; }
        public User Korisnik { get; set; }
        public int ActivityId { get; set; }
        public Activity Activity { get; set; }
        public DateTime DateAssigned { get; set; }
        public Status StatusActivity { get; set; }
        public string Note { get; set; }
        public DateTime CompletedAt { get; set; }
        public string? RewardTitle { get; set; }
        public DateTime? RewardedAt { get; set; }
        public enum Status
        {
            Assigned,
            InProgress,
            Completed,
            Cancelled
        }
    }
}
