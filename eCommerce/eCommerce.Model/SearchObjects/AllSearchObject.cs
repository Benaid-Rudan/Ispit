using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class AllSearchObject : BaseSearchObject
    {
        public string? TipIzazova { get; set; }
        public string? StatusIzazova { get; set; }
        public DateTime? DatumPrihvatanja { get; set; }
    }
}
