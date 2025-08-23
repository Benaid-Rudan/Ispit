using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class FinansijskiLimitService : BaseCRUDService<FinansijskiLimitResponse, FinansijskiLimitSearchObject, FinansijskiLimit, FinansijskiLimitUpsertRequest, FinansijskiLimitUpsertRequest>, IFinansijskiLimitService
    {
        public FinansijskiLimitService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }



    }
}