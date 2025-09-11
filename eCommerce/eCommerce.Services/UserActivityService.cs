using eCommerce.Model.Requests;
using eCommerce.Model.Responses;
using eCommerce.Model.SearchObjects;
using eCommerce.Services.Database;

using eCommerce.Services.Responses;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using static eCommerce.Services.Database.UserActivity;

namespace eCommerce.Services
{
    public class UserActivityService : BaseCRUDService<UserActivityResponse, SearchObject, UserActivity, UserActivityRequest, UserActivityRequest>, IUserActivityService
    {
        public UserActivityService(eCommerceDbContext context, IMapper mapper) : base(context, mapper)
        {
        }


        protected override IQueryable<UserActivity> ApplyFilter(IQueryable<UserActivity> query, SearchObject search)
        {
            
            query = query.Include(x => x.Activity).Include(x=>x.Korisnik);
            if (!string.IsNullOrWhiteSpace(search.StatusActivity))
            {
                if(Enum.TryParse<Status>(search.StatusActivity,true,out var status))
                {
                    query = query.Where(x => x.StatusActivity == status);
                }
            }
            
            return base.ApplyFilter(query, search);
        }
        public override async Task<UserActivityResponse?> UpdateAsync(int id, UserActivityRequest request)
        {
            var entity = await _context.UserActivity
                .Include(x => x.Activity)
                .FirstOrDefaultAsync(x => x.UserActivityId == id);

            if (entity == null)
                return null;

            if (!Enum.TryParse<Status>(request.StatusActivity, true, out var newStatus))
                throw new ArgumentException("Invalid status value.");

            var oldStatus = entity.StatusActivity;

            // Validacija tranzicija
            bool valid = false;
            if (oldStatus == Status.Assigned && newStatus == Status.InProgress)
                valid = true;
            else if (oldStatus == Status.Assigned && newStatus == Status.Cancelled)
                valid = true;
            else if (oldStatus == Status.InProgress && newStatus == Status.Completed)
                valid = true;
            else if (oldStatus == Status.InProgress && newStatus == Status.Cancelled)
                valid = true;
            else if (oldStatus == Status.Assigned && newStatus == Status.Completed)
                valid = true; 
            if (oldStatus == Status.Completed && newStatus != Status.Completed)
                throw new InvalidOperationException("Transition from Completed is not allowed.");

            if (!valid && oldStatus != newStatus)
                throw new InvalidOperationException($"Transition {oldStatus} -> {newStatus} is not allowed.");

            if (oldStatus == Status.Assigned && newStatus == Status.InProgress)
            {
                if (entity.Activity != null && DateTime.UtcNow > entity.Activity.DueDate)
                    throw new InvalidOperationException("Cannot start activity after due date.");
            }

            if (newStatus == Status.Completed && request.CompletedAt == default)
                throw new InvalidOperationException("CompletedAt must be set when completing activity.");

            entity.Note = request.Note;
            entity.StatusActivity = newStatus;
            entity.CompletedAt = request.CompletedAt;

            if (oldStatus != Status.Completed && newStatus == Status.Completed)
            {
                var rewardRule = await _context.RewardRule.FirstOrDefaultAsync(r => r.ActivityId == entity.ActivityId);
                if (rewardRule != null)
                {
                    var days = (entity.CompletedAt - entity.DateAssigned).TotalDays;
                    if (days <= rewardRule.MaxDaysToComplete)
                    {
                        entity.RewardTitle = rewardRule.RewardTitle;
                        entity.RewardedAt = DateTime.UtcNow;
                    }
                }
            }

            await _context.SaveChangesAsync();
            return MapToResponse(entity);
        }

    }
}