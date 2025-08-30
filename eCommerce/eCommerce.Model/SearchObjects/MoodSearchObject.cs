using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class MoodSearchObject : BaseSearchObject
    {
        public DateTime? DatumEvidencije { get; set; }
        public string? imePrezime { get; set; }
        public string? Status { get; set; }
    }
}
