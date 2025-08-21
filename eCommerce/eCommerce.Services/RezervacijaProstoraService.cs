using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class RezervacijaProstoraService : BaseCRUDService<RezervacijaProstoraResponse, RezervacijaProstoraSearchObject, RezervacijaProstora, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>, IRezervacijaProstoraService
    {
        public RezervacijaProstoraService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        protected override IQueryable<RezervacijaProstora> ApplyFilter(IQueryable<RezervacijaProstora> query, RezervacijaProstoraSearchObject search)
        {

            if (search.IsKorisnikIncluded == true)
            {
                query = query.Include(x => x.Korisnik);
            }
            if (search.IsRadniProstorIncluded == true)
            {
                query = query.Include(x => x.RadniProstor);
            }
            if (search.KorisnikId.HasValue)
            {
                query = query.Where(x => x.KorisnikId == search.KorisnikId.Value);
            }
            if (search.RadniProstorId.HasValue)
            {
                query = query.Where(x => x.RadniProstorId == search.RadniProstorId.Value);
            }
            if (!string.IsNullOrWhiteSpace(search.StatusRezervacije))
            {
                if(Enum.TryParse<Database.RezervacijaProstora.Status>(search.StatusRezervacije,true,out var status))
                {
                    query = query.Where(x => x.StatusRezervacije == status);
                }
            }
            return base.ApplyFilter(query, search);
        }
       
    }
}