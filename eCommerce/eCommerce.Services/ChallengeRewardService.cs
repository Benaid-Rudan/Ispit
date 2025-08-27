using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class ChallengeRewardService : BaseCRUDService<ChallengeRewardResponse, ChallengeRewardSearchObject, ChallengeReward, ChallengeRewardUpsert, ChallengeRewardUpsert>, IChallengeRewardService
    {
        public ChallengeRewardService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }



    }
}