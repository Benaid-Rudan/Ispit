using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class TransakcijaService : BaseCRUDService<TransakcijaResponse, TransakcijaSearchObject, Transakcija, TransakcijaUpsertRequest, TransakcijaUpsertRequest>, ITransakcijaService
    {
        private readonly ITransakcijaLogService _logService;
        
        public TransakcijaService(eCommerceDbContext context, IMapper mapper, ITransakcijaLogService logService) : base(context, mapper)
        {
            _logService = logService;
        }

        public override async Task<Model.Responses.TransakcijaResponse> UpdateAsync(int id, TransakcijaUpsertRequest update)
        {
            var set = _context.Set<Database.Transakcija>();
            var entity = await set.FindAsync(id);
            var stariStatus = entity.StatusTransakcije.ToString();
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();

            if (stariStatus != entity.StatusTransakcije.ToString())
            {
                var log = new TransakcijaLogUpsertRequest
                {
                    TransakcijaId = entity.TransakcijaId,
                    StaraVrijednost = stariStatus,
                    NovaVrijednost = entity.StatusTransakcije.ToString(),
                    KorisnikId = entity.KorisnikId,
                    VrijemePromjene = DateTime.Now

                };

                await _logService.CreateAsync(log);
            }
            return _mapper.Map<Model.Responses.TransakcijaResponse>(entity);


        }
        public override async Task<TransakcijaResponse> CreateAsync(TransakcijaUpsertRequest request)
        {
            if (request.Iznos == null || request.KategorijaTransakcijeId == 0)
                throw new Exception("Iznos i KategorijaTransakcijeId su obavezni.");

            var limit = await _context.Set<FinansijskiLimit>()
                .FirstOrDefaultAsync(fl => fl.KorisnikId == request.KorisnikId &&
                                           fl.KategorijaId == request.KategorijaTransakcijeId);

            if (limit == null)
                throw new Exception("Limit nije postavljen za kategoriju.");

            var mjesec = DateTime.Now;
            var ukupno = await _context.Set<Transakcija>()
                .Where(t => t.KorisnikId == request.KorisnikId &&
                           t.KategorijaTransakcijeId == request.KategorijaTransakcijeId &&
                           t.DatumTransakcije.Month == mjesec.Month)
                .SumAsync(t => t.Iznos);

            if (ukupno + request.Iznos > limit.Limit)
                throw new Exception($"Prelazite limit od {limit.Limit} KM. Trenutno: {ukupno} KM.");

            return await base.CreateAsync(request);
        }



        protected override IQueryable<Transakcija> ApplyFilter(IQueryable<Transakcija> query, TransakcijaSearchObject search)
        {

            if (search.IsKategorijaIncluded == true)
            {
                query = query.Include(x => x.KategorijaTransakcije);
            }
            if (search.KategorijaId.HasValue)
            {
                query = query.Where(x => x.KategorijaTransakcijeId == search.KategorijaId.Value);
            }
            if (search.DatumOd.HasValue)
            {
                query = query.Where(x => x.DatumTransakcije >= search.DatumOd.Value);
            }
            if (search.DatumDo.HasValue)
            {
                query = query.Where(x => x.DatumTransakcije <= search.DatumDo.Value);
            }
            return base.ApplyFilter(query, search);
        }

    }
}