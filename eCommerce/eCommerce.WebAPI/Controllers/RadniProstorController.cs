using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace eCommerce.WebAPI.Controllers
{
    public class RadniProstorController : BaseCRUDController<RadniProstorResponse, RadniProstorSearchObject, RadniProstorUpsertRequest, RadniProstorUpsertRequest>
    {
        public RadniProstorController(IRadniProstorService service) : base(service)
        {
        }
        
       
    }
} 