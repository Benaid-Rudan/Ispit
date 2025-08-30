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

           if(Enum.TryParse<StatusPeer>(request.StatusPeera,true,out var status))
           {
               peerChallenge.StatusPeera = status;
           }
           else
           {
               throw new ArgumentException($"Invalid status value: {request.StatusPeera}");
           }
           await _context.SaveChangesAsync();
           if(peerChallenge.StatusPeera == StatusPeer.Prihvacen)
           {
               var userChallenge = new UserChallenge
               {
                   ChallengeId = peerChallenge.ChallengeId,
                   IzazvaniId = peerChallenge.IzazvaniId,
                   StatusIzazova = StatusIzazov.Prihvacen,
                   DatumPrihvatanja = DateTime.Now,
               };
               _context.UserChallenge.Add(userChallenge);
               await _context.SaveChangesAsync();
           }
           return MapToResponse(peerChallenge);        


       }

    }
}