using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class RezervacijaProstoraSearchObject : BaseSearchObject
    {
        public bool? IsKorisnikIncluded { get; set; }
        public bool? IsRadniProstorIncluded { get; set; }
        public int? KorisnikId { get; set; }

        public int? RadniProstorId { get; set; }
        public string? StatusRezervacije { get; set; }
    }
}
