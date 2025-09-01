using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class ChallengeService : BaseCRUDService<ChallengeResponse, SearchObject, Challenge, ChallengeRequest, ChallengeRequest>, IChallengeService
    {
        public ChallengeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }



    }
}