using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class MoodService : BaseCRUDService<MoodResponse, MoodSearchObject, Mood, MoodRequest, MoodRequest>, IMoodService
    {
        public MoodService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        protected override IQueryable<Mood> ApplyFilter(IQueryable<Mood> query, MoodSearchObject search)
        {

            query = query.Include(x => x.Korisnik);
            if (!string.IsNullOrWhiteSpace(search.imePrezime))
            {
                query = query.Where(x=> x.Korisnik.FirstName.Contains(search.imePrezime) || x.Korisnik.LastName.Contains(search.imePrezime));
            }

            if(!string.IsNullOrWhiteSpace(search.Status))
            {
                if (Enum.TryParse<Mood.StatusRaspolozenja>(search.Status, true, out var status))
                {
                    query = query.Where(x => x.Status == status);
                }
            }

            if (search.DatumEvidencije.HasValue)
            {
                query = query.Where(x => x.DatumEvidencije.Date == search.DatumEvidencije.Value.Date);
            }

            return query;
        }

    }
}