using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services.Database
{
    public class RewardRule
    {
        public int RewardRuleId { get; set; }
        public int ActivityId { get; set; }
        public Activity Activity { get; set; }
        public string RewardTitle { get; set; }
        public int MaxDaysToComplete { get; set; }
        public int NumberOfPoints { get; set; }

    }
}
