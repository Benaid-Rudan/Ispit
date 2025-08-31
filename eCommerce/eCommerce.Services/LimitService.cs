using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class LimitService : BaseCRUDService<LimitResponse, SearchObject, Limit, LimitRequest, LimitRequest>, ILimitService
    {
        public LimitService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


       

    }
}