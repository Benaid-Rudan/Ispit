using System;

namespace eCommerce.Model.Responses
{
    public class RadniProstorResponse
    {
        public int RadniProstorId { get; set; }
        public string Oznaka { get; set; }
        public int Kapacitet { get; set; }
        public bool Aktivna { get; set; }
    }
} 