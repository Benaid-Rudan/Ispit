using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public class RadniProstorService : BaseCRUDService<RadniProstorResponse, RadniProstorSearchObject, RadniProstor, RadniProstorUpsertRequest, RadniProstorUpsertRequest>, IRadniProstorService
    {
        public RadniProstorService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }



    }
}