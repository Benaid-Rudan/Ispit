using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

namespace eCommerce.Services
{
    public interface IRezervacijaProstoraService : ICRUDService<RezervacijaProstoraResponse, RezervacijaProstoraSearchObject, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>
    {
    }
}
