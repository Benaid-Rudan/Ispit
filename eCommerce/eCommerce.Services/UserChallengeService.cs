using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using static eCommerce.Services.Database.Challenge;
using static eCommerce.Services.Database.PeerChallenge;
using static eCommerce.Services.Database.UserChallenge;

namespace eCommerce.Services
{
    public class UserChallengeService : BaseCRUDService<UserChallengeResponse, SearchObject, UserChallenge, UserChallengeRequest, UserChallengeRequest>, IUserChallengeService
    {
        public UserChallengeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        protected override IQueryable<UserChallenge> ApplyFilter(IQueryable<UserChallenge> query, SearchObject search)
        {

            query = query.Include(x => x.Challenge).Include(x => x.Izazvani);

            if (search.DatumKreiranja.HasValue)
            {
                query = query.Where(x => x.DatumPrihvatanja.Date == search.DatumKreiranja.Value.Date);
            }

            if (!string.IsNullOrWhiteSpace(search.TipIzazova))
            {
                if (Enum.TryParse<TipIzazov>(search.TipIzazova, true, out var tip))
                {
                    query = query.Where(x => x.Challenge.TipIzazova == tip);
                }
            }

            if (!string.IsNullOrWhiteSpace(search.StatusPeera))
            {
                if (Enum.TryParse<StatusIzazov>(search.StatusPeera, true, out var status))
                {
                    query = query.Where(x => x.StatusIzazova == status);
                }
            }

            return base.ApplyFilter(query, search);
        }


    }
}