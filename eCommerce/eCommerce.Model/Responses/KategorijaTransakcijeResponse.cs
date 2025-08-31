using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class KategorijaTransakcijeResponse
    {
        public int KategorijaTransakcijeId { get; set; }
        public string Naziv { get; set; }
        public string Tip { get; set; }
    }
}
