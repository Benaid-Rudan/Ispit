using System.ComponentModel.DataAnnotations;

namespace eCommerce.Model.Requests
{
    public class RadniProstorRequest
    {
        [Required]
        public string Oznaka { get; set; }
        [Required]
        public int Kapacitet { get; set; }
        [Required]
        public bool Aktivna { get; set; }
    }
}