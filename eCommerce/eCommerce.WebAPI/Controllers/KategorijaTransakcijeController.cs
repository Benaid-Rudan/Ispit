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
    public class KategorijaTransakcijeController : BaseCRUDController<KategorijaTransakcijeResponse, KategorijaTransakcijaSearchObject, KategorijaTransakcijeUpsertRequest, KategorijaTransakcijeUpsertRequest>
    {
        public KategorijaTransakcijeController(IKategorijaTransakcijeService service) : base(service)
        {
        }
    }
}