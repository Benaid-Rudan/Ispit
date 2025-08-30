using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eCommerce.Services
{
    public interface IRadniProstorService : ICRUDService<Model.Responses.RadniProstorResponse, Model.SearchObjects.RezervacijaSearchObject, Model.Requests.RadniProstorRequest, Model.Requests.RadniProstorRequest>
    {
    }
}
