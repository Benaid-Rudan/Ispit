
using System.ComponentModel.DataAnnotations;

namespace eCommerce.Model.Requests
{
    public class KategorijaTransakcijeUpsertRequest
    {
        [Required]
        public string Naziv { get; set; }
        [Required]
        public string Tip { get; set; }
    }
}
