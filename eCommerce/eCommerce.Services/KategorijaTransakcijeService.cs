using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class KategorijaTransakcijeService : BaseCRUDService<KategorijaTransakcijeResponse, KategorijaTransakcijaSearchObject, KategorijaTransakcije, KategorijaTransakcijeUpsertRequest, KategorijaTransakcijeUpsertRequest>, IKategorijaTransakcijeService
    {
        public KategorijaTransakcijeService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        //protected override IQueryable<UnitOfMeasure> ApplyFilter(IQueryable<UnitOfMeasure> query, UnitOfMeasureSearchObject search)
        //{

        //    if (!string.IsNullOrEmpty(search.FTS))
        //    {
        //        query = query.Where(u => u.Name.Contains(search.FTS) || u.Abbreviation.Contains(search.FTS));
        //    }
        //    return base.ApplyFilter(query, search);
        //}

    }
}