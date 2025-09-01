using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class SearchObject: BaseSearchObject
     {
        public string? StatusIzazova { get; set; }
        public string? TipIzazova { get; set; }
        public DateTime? DatumPrihvatanja { get; set; }
    }
}
