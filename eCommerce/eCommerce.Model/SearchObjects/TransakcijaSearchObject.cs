using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class TransakcijaSearchObject : BaseSearchObject
    {
        public bool? IsKategorijaIncluded { get; set; }
        public int? KategorijaId { get; set; }
        public DateTime? DatumOd { get; set; }
        public DateTime? DatumDo { get; set; }


    }
}
