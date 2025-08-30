using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using static eCommerce.Services.Database.RezervacijaProstora;

namespace eCommerce.Services
{
    public class RezervacijaProstoraService : BaseCRUDService<RezervacijaProstoraResponse, RezervacijaSearchObject, RezervacijaProstora, RezervacijaProstoraRequest, RezervacijaProstoraRequest>, IRezervacijaProstoraService
    {
        public RezervacijaProstoraService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        protected override IQueryable<RezervacijaProstora> ApplyFilter(IQueryable<RezervacijaProstora> query, RezervacijaSearchObject search)
        {
            query = query.Include(x=>x.Korisnik).Include(x=>x.RadniProstor); 
            if (!string.IsNullOrEmpty(search.imePrezime))
            {
                query = query.Where(u => u.Korisnik.FirstName.Contains(search.imePrezime) || u.Korisnik.LastName.Contains(search.imePrezime));
            }
            if (search.RadniProstorId.HasValue)
            {
                query=query.Where(x=>x.RadniProstorId==search.RadniProstorId);
            }
            if (!string.IsNullOrWhiteSpace(search.Status))
            {
                if(Enum.TryParse<StatusRezervacije>(search.Status,true,out var status))
                {
                    query = query.Where(x => x.Status == status);
                }
            }

            return base.ApplyFilter(query, search);
        }

    }
}