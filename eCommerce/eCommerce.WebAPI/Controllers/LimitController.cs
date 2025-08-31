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
    public class LimitController : BaseCRUDController<LimitResponse, SearchObject, LimitRequest, LimitRequest>
    {
        public LimitController(ILimitService service) : base(service)
        {
        }
    }
}