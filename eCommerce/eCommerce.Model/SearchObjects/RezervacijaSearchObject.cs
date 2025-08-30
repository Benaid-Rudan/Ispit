using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class RezervacijaSearchObject : BaseSearchObject
    {
        public string? imePrezime { get; set; }
        public int? RadniProstorId { get; set; }
        public string? Status { get; set; }
    }
}
