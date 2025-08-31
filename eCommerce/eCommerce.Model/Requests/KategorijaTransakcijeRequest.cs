using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
   public class KategorijaTransakcijeRequest
    {
        [Required]
        public string Naziv { get; set; }
        [Required]
        public string Tip { get; set; }
    }
}
