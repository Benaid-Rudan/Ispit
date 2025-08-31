using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class SearchObject : BaseSearchObject
    {
        public DateTime? DatumOd { get; set; }
        public DateTime? DatumDo{ get; set; }
        public int? KategorijaTransakcijeId { get; set; }

    }
}
