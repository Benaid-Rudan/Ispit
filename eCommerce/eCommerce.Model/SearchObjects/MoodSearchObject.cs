using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class MoodSearchObject : BaseSearchObject
    {
        public bool? IsKorisnikIncluded { get; set; }

        public string? imePrezime { get; set; }

        public string? StatusRaspolozenja { get; set; }
        public DateTime? DatumEvidencije { get; set; }
    }
}
