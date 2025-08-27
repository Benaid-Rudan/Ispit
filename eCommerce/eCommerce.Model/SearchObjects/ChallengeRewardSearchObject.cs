using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class ChallengeRewardSearchObject : BaseSearchObject
    {
        public string? Code { get; set; }

        public string? CodeGTE { get; set; }
    }
}
