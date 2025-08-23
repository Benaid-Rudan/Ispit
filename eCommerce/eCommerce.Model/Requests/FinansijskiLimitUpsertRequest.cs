
using System.ComponentModel.DataAnnotations;

namespace eCommerce.Model.Requests
{
    public class FinansijskiLimitUpsertRequest
    {
        [Required]
        public int KorisnikId { get; set; }
        [Required]
        public int KategorijaId { get; set; }
        [Required]
        public int Limit { get; set; }
    }
}
