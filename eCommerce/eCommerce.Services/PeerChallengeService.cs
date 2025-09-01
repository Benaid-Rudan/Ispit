using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using static eCommerce.Services.Database.Challenge;
using static eCommerce.Services.Database.PeerChallenge;

namespace eCommerce.Services
{
    public class PeerChallengeService : BaseCRUDService<PeerChallengeResponse, SearchObject, PeerChallenge, PeerRequest, PeerRequest>, IPeerChallengeService
    {
        public PeerChallengeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        protected override IQueryable<PeerChallenge> ApplyFilter(IQueryable<PeerChallenge> query, SearchObject search)
        {
            query = query.Include(x => x.Challenge);
            if (!string.IsNullOrWhiteSpace(search.StatusIzazova))
            {
                if(Enum.TryParse<StatusPeer>(search.StatusIzazova,true,out var status))
                {
                    query = query.Where(x => x.StatusPeera == status);
                }
            }
            if(search.DatumPrihvatanja.HasValue)
            {
                query = query.Where(x => x.DatumKreiranja.Date == search.DatumPrihvatanja.Value.Date);
            }
            if (!string.IsNullOrWhiteSpace(search.TipIzazova))
            {
                if (Enum.TryParse<TipIzazov>(search.TipIzazova, true, out var tip))
                {
                    query = query.Where(x => x.Challenge.TipIzazova == tip);
                }
            }

            return base.ApplyFilter(query, search);
        }

        public override async Task<PeerChallengeResponse?> UpdateAsync(int id, PeerRequest request)
        {
            var peerChallenge = await _context.PeerChallenge.FindAsync(id);
            
            if (peerChallenge == null) return null;

            if(Enum.TryParse<StatusPeer>(request.StatusPeera,true,out var status))
            {
                peerChallenge.StatusPeera = status;
            }
            await _context.SaveChangesAsync();

            if(peerChallenge.StatusPeera == StatusPeer.Prihvacen)
            {
                var userChallenge = new UserChallenge
                {
                    ChallengeId = peerChallenge.ChallengeId,
                    KorisnikId = peerChallenge.IzazvaniId,
                    DatumPrihvatanja = DateTime.Now,
                    StatusIzazova = UserChallenge.StatusIzazov.Prihvacen,
                };
                _context.UserChallenge.Add(userChallenge);
                await _context.SaveChangesAsync();
            }

            return MapToResponse(peerChallenge);
        }
    }
}