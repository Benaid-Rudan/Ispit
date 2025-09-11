using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class ActivityResponse
    {
        public int ActivityId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime DueDate { get; set; }
        //public int RewardRuleId { get; set; }
        //public RewardRuleResponse RewardRule { get; set; }
    }
}
