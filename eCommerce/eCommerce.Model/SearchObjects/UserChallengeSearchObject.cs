using System;
using System.Collections.Generic;
using System.Text;
using eCommerce.Model.Enum;

namespace eCommerce.Model.SearchObjects
{
    public class UserChallengeSearchObject : BaseSearchObject
    {
        public string? StatusIzazova { get; set; } // Filter po statusu izazova
        public string? TipIzazova { get; set; } // Filter po tipu izazova
        public DateTime? DatumPrihvatanja { get; set; }
    }
}
