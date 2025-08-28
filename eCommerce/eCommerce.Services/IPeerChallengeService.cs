using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;
using eCommerce.Services.Responses;

namespace eCommerce.Services
{
    public interface IPeerChallengeService : ICRUDService<PeerChallengeResponse, AllSearchObject, PeerChallengeRequest, PeerChallengeRequest>
    {
    }
}