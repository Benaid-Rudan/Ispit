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
    public class ChallengeController : BaseCRUDController<ChallengeResponse, AllSearchObject, ChallengeRequest, ChallengeRequest>
    {
        public ChallengeController(IChallengeService service) : base(service)
        {
        }
    }
}