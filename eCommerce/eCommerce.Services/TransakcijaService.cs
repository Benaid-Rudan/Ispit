using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using static eCommerce.Services.Database.Transakcija;

namespace eCommerce.Services
{
    public class TransakcijaService : BaseCRUDService<TransakcijaResponse, SearchObject, Transakcija, TransakcijaRequest, TransakcijaRequest>, ITransakcijaService
    {
        private readonly ITransakcijaLogService _logService;
        public TransakcijaService(eCommerceDbContext context, IMapper mapper, ITransakcijaLogService logService) : base(context, mapper)
        {
            _logService = logService;
        }


        protected override IQueryable<Transakcija> ApplyFilter(IQueryable<Transakcija> query, SearchObject search)
        {
            query = query.Include(x => x.KategorijaTransakcije);
            if (search.DatumDo.HasValue)
            {
                query = query.Where(x=>x.DatumTransakcije <= search.DatumDo);
            }
            if (search.DatumOd.HasValue)
            {
                query = query.Where(x => x.DatumTransakcije >= search.DatumOd);
            }
            if (search.KategorijaTransakcijeId.HasValue)
            {
                query = query.Where(x => x.KategorijaTransakcijeId == search.KategorijaTransakcijeId);
            }
            return base.ApplyFilter(query, search);
        }
        public override async Task<Model.Responses.TransakcijaResponse> UpdateAsync(int id, TransakcijaRequest update)
        {
            //private readonly ITransakcijaLogService _logService; ++++++++ konstruktor TransakcijaLogService _logService

            var set = _context.Set<Database.Transakcija>();
            var entity = await set.FindAsync(id);
            var stariStatus = entity.Status.ToString();
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();

            if (stariStatus != entity.Status.ToString())
            {
                var log = new TransakcijaLogRequest
                {
                    TransakcijaId = entity.TransakcijaId,
                    StaraVrijednost = stariStatus,
                    NovaVrijednost = entity.Status.ToString(),
                    KorisnikId = entity.KorisnikId,
                    DatumPromjene = DateTime.Now

                };

                await _logService.CreateAsync(log);
            }
            return _mapper.Map<Model.Responses.TransakcijaResponse>(entity);
        }

}

    
}