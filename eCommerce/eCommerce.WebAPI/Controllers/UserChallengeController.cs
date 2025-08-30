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
    public class UserChallengeController : BaseCRUDController<UserChallengeResponse, AllSearchObject, UserChallengeRequest, UserChallengeRequest>
    {
        public UserChallengeController(IUserChallengeService service) : base(service)
        {
        }
    }
}