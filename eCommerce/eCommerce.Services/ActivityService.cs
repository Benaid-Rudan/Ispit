using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class ActivityService : BaseCRUDService<ActivityResponse, SearchObject, Activity, ActivityRequest, ActivityRequest>, IActivityService
    {
        public ActivityService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


     

    }
}