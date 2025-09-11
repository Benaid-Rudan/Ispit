using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class RewardRuleResponse
    {
        public int RewardRuleId { get; set; }
        public int ActivityId { get; set; }
        public ActivityResponse Activity { get; set; }
        public string RewardTitle { get; set; }
        public int MaxDaysToComplete { get; set; }
        public int NumberOfPoints { get; set; }
    }
}
