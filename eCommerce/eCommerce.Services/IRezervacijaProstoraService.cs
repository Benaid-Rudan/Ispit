using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eCommerce.Services
{
    public interface IRezervacijaProstoraService : ICRUDService<RezervacijaProstoraResponse, RezervacijaProstoraSearchObject, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>
    {
    }
}