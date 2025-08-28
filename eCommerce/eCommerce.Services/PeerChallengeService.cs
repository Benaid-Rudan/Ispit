using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using static eCommerce.Model.Enum.Enums;

namespace eCommerce.Services
{
    public class PeerChallengeService : BaseCRUDService<PeerChallengeResponse, AllSearchObject, PeerChallenge, PeerChallengeRequest, PeerChallengeRequest>, IPeerChallengeService
    {
        public PeerChallengeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override async Task<PeerChallengeResponse?> UpdateAsync(int id, PeerChallengeRequest request)
        {
            var peerChallenge = await _context.PeerChallenge.FindAsync(id);
            if (peerChallenge == null)
                return null;
            if (Enum.TryParse<StatusPeera>(request.StatusPeer, out var status))
            {
                peerChallenge.StatusPeer = status;
            }
            else throw new ArgumentException($"Invalid value type: {request.StatusPeer}");
            await _context.SaveChangesAsync();

            if(peerChallenge.StatusPeer == StatusPeera.Prihvacen)
            {
                var userChallenge = new UserChallenge
                {
                    ChallengeId = peerChallenge.ChallengeId,
                    IzazvaniId = peerChallenge.IzazvaniId,
                    StatusIzazov = StatusIzazova.Prihvacen,
                    DatumPrihvatanja = DateTime.Now
                };
                _context.UserChallenge.Add(userChallenge);
                await _context.SaveChangesAsync();
            }
            return MapToResponse(peerChallenge);
        }
        

    }
}