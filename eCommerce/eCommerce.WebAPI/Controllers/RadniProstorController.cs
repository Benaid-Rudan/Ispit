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
    public class RadniProstorController : BaseCRUDController<RadniProstorResponse, RezervacijaSearchObject, RadniProstorRequest, RadniProstorRequest>
    {
        public RadniProstorController(IRadniProstorService service) : base(service)
        {
        }
    }
}