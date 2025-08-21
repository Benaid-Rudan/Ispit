using eCommerce.Model;
using eCommerce.Model.SearchObjects;
using eCommerce.Model.Responses;
using eCommerce.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using eCommerce.Model.Requests;
using Microsoft.AspNetCore.Authorization;

namespace eCommerce.WebAPI.Controllers
{

    public class RezervacijaProstoraController : BaseCRUDController<RezervacijaProstoraResponse, RezervacijaProstoraSearchObject, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>
    {
        IRezervacijaProstoraService _rezervacijaService;
        public RezervacijaProstoraController(IRezervacijaProstoraService service) : base(service)
        {
            _rezervacijaService = service;
        }

    }
}
