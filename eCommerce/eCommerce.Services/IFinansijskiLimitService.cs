using eCommerce.Services.Database;
using System.Collections.Generic;
using System.Threading.Tasks;
using eCommerce.Model.Responses;
using eCommerce.Model.Requests;
using eCommerce.Model.SearchObjects;
using eCommerce.Model.Responses;
namespace eCommerce.Services
{
    public interface IFinansijskiLimitService : ICRUDService<FinansijskiLimitResponse, FinansijskiLimitSearchObject, FinansijskiLimitUpsertRequest, FinansijskiLimitUpsertRequest>
    {
        
    }
} 