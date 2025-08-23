using System;

namespace eCommerce.Model.Responses
{
    public class TransakcijaLogResponse
    {
        public int TransakcijaLogId { get; set; }
        public int KorisnikId { get; set; }
        public DateTime VrijemePromjene { get; set; }
        public string StaraVrijednost { get; set; }
        public string NovaVrijednost { get; set; }
    }
} 