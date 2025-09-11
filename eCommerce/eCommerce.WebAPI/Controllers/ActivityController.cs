using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services;
using eCommerce.Services.Responses;
using Microsoft.AspNetCore.Mvc;

namespace eCommerce.WebAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ActivityController : BaseCRUDController<ActivityResponse, SearchObject, ActivityRequest, ActivityRequest>
    {
        public ActivityController(IActivityService service) : base(service)
        {
        }
    }
}