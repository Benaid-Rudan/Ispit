using System;

namespace eCommerce.Model.Responses
{
    public class FinansijskiLimitResponse
    {
        public int FinansijskiLimitId { get; set; }
        public int KorisnikId { get; set; }
        public int KategorijaId { get; set; }
        public int Limit { get; set; }
    }
} 