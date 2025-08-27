// eCommerce.Services/ICurrentUserService.cs
public interface ICurrentUserService
{
    int? UserId { get; }
    string? Username { get; }
}
