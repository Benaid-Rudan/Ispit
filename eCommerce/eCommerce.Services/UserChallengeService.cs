using eCommerce.Model.Enum;
using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class UserChallengeService : BaseCRUDService<UserChallengeResponse, AllSearchObject, UserChallenge, UserChallengeRequest, UserChallengeRequest>, IUserChallengeService
    {
        public UserChallengeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        protected override IQueryable<UserChallenge> ApplyFilter(IQueryable<UserChallenge> query, AllSearchObject search)
        {

            query=query.Include(x => x.Challenge).Include(x => x.Izazvani);

            if (!string.IsNullOrWhiteSpace(search.StatusIzazova))
            {
                if (Enum.TryParse<StatusIzazov>(search.StatusIzazova, true, out var status))
                {
                    query = query.Where(x => x.StatusIzazova == status);
                }
            }
            if (!string.IsNullOrWhiteSpace(search.TipIzazova))
            {
                if (Enum.TryParse<TipIzazov>(search.TipIzazova, true, out var tip))
                {
                    query = query.Where(x => x.Challenge.TipIzazova == tip);
                }
            }
            if (search.DatumPrihvatanja.HasValue)
            {
                query = query.Where(x => x.DatumPrihvatanja.Date == search.DatumPrihvatanja.Value.Date);
            }

            return base.ApplyFilter(query, search);
        }

    }
}