using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;
using eCommerce.Model.Responses;

namespace eCommerce.Model.Requests
{
    public class RewardRuleRequest
    {
        [Required]
        public int ActivityId { get; set; }
        [Required]
        public string RewardTitle { get; set; }
        [Required]
        public int MaxDaysToComplete { get; set; }
        [Required]
        public int NumberOfPoints { get; set; }
    }
}
