using eCommerce.Model.Enum;
using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class PeerChallengeService : BaseCRUDService<PeerChallengeResponse, PeerChallengeSearchObject, PeerChallenge, PeerChallengeUpsert, PeerChallengeUpsert>, IPeerChallengeService
    {
        public PeerChallengeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }
        // eCommerce.Services/PeerChallengeService.cs
        public override async Task<PeerChallengeResponse?> UpdateAsync(int id, PeerChallengeUpsert request)
        {
            var peerChallenge = await _context.PeerChallenge.FindAsync(id);
            if (peerChallenge == null)
                return null;

            // Convert the string status from the request to the StatusPeer enum
            if (Enum.TryParse<StatusPeer>(request.Status, out var status))
            {
                peerChallenge.Status = status;
            }
            else
            {
                throw new ArgumentException($"Invalid status value: {request.Status}");
            }

            await _context.SaveChangesAsync();

            // Ako je prihvaæen, kreiraj UserChallenge
            if (peerChallenge.Status == StatusPeer.Prihvaæen)
            {
                var userChallenge = new UserChallenge
                {
                    ChallengeId = peerChallenge.ChallengeId,
                    IzazvaniId = peerChallenge.IzazvaniId,
                    StatusIzazova = StatusIzazov.Prihvaæen,
                    DatumPrihvatanja = DateTime.Now,
                    Napredak = 0
                };
                _context.UserChallenge.Add(userChallenge);
                await _context.SaveChangesAsync();
            }

            return MapToResponse(peerChallenge);
        }


    }
}