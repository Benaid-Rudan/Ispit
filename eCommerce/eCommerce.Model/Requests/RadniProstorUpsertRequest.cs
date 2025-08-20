using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace eCommerce.Model.Requests
{
    public class RadniProstorUpsertRequest
    {
        [Required]
        public string Oznaka { get; set; }
        [Required]
        public int Kapacitet { get; set; }
        [Required]
        public bool Aktivna { get; set; }

    }   
}