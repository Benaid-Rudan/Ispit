using eCommerce.Services.Database;
using System.Collections.Generic;
using System.Threading.Tasks;
using eCommerce.Model.Responses;
using eCommerce.Model.Requests;
using eCommerce.Model.SearchObjects;

namespace eCommerce.Services
{
    public interface IMoodService : ICRUDService<MoodResponse, MoodSearchObject, MoodUpsertRequest, MoodUpsertRequest>
    {
    }
} 