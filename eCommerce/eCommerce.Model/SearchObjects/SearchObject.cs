using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public  class SearchObject : BaseSearchObject
    {
        public string? TipIzazova { get; set; }
        public string? StatusPeera { get; set; }
        public DateTime? DatumKreiranja { get; set; }

    }
}
