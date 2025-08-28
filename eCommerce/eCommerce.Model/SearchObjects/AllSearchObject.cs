using System;
using System.Collections.Generic;
using System.Text;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Model.SearchObjects
{
    public class AllSearchObject : BaseSearchObject
    {
        public string? StatusIzazov { get; set; }
        public string? TipIzazova { get; set; }
        public DateTime? DatumPrihvatanja { get; set; }
    }
}
