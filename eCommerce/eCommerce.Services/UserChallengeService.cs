using eCommerce.Model.Enum;
using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace eCommerce.Services
{
    public class UserChallengeService : BaseCRUDService<UserChallengeResponse, UserChallengeSearchObject, UserChallenge, UserChallengeUpsert, UserChallengeUpsert>, IUserChallengeService
    {
        public UserChallengeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        protected override IQueryable<UserChallenge> ApplyFilter(IQueryable<UserChallenge> query, UserChallengeSearchObject search)
        {

             query = query
                .Include(uc => uc.Challenge)
                .Include(uc => uc.Korisnik)
                .AsQueryable();

            // Primjena samo 3 tražena filtera
            if (!string.IsNullOrEmpty(search.StatusIzazova))
            {
                if (Enum.TryParse<StatusIzazov>(search.StatusIzazova, true, out var status))
                {
                    query = query.Where(x => x.StatusIzazova == status);
                }
            }


            if (!string.IsNullOrEmpty(search.TipIzazova))
                query = query.Where(x => x.Challenge.TipIzazova == search.TipIzazova);

            if (search.DatumPrihvatanja.HasValue)
                query = query.Where(x => x.DatumPrihvatanja.Date == search.DatumPrihvatanja.Value.Date);


            return base.ApplyFilter(query, search);
        }

    }
}