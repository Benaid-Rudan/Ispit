using eCommerce.Services.Database;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using eCommerce.Model.Responses;
using eCommerce.Model.Requests;
using eCommerce.Model.SearchObjects;
using System.Linq;
using System;
using MapsterMapper;
using eCommerce.Model;
using Microsoft.Extensions.Logging;

namespace eCommerce.Services
{
    public class MoodService :
            BaseCRUDService<MoodResponse, MoodSearchObject, Mood, MoodUpsertRequest, MoodUpsertRequest>, IMoodService
    {

        public MoodService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        protected override IQueryable<Mood> ApplyFilter(IQueryable<Mood> query, MoodSearchObject search)
        {
            if (search.IsKorisnikIncluded == true)
            {
                query = query.Include(m => m.Korisnik);
            }
            if (!string.IsNullOrWhiteSpace(search.imePrezime))
            {
                query = query.Where(x => x.Korisnik.FirstName.Contains(search.imePrezime) || x.Korisnik.LastName.Contains(search.imePrezime));
            }
            if (!string.IsNullOrWhiteSpace(search.StatusRaspolozenja))
            {
                if (Enum.TryParse<Database.Mood.Status>(search.StatusRaspolozenja, true, out var status))
                {
                    query = query.Where(x => x.StatusRaspolozenja == status);
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