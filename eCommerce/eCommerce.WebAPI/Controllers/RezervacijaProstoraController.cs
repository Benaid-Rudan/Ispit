using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services;
using eCommerce.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace eCommerce.WebAPI.Controllers
{
    public class RezervacijaProstoraController : BaseCRUDController<RezervacijaProstoraResponse, RezervacijaProstoraSearchObject, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>
    {
        public RezervacijaProstoraController(IRezervacijaProstoraService service) : base(service)
        {
        }

    }
}