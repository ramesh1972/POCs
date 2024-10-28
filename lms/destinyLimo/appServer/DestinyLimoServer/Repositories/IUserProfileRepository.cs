using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public interface IUserProfileRepository
    {
        Task<IEnumerable<UserProfile>> GetUsers(bool inactive = true, bool is_deleted = false);
        Task<UserProfile> GetUserById(int userId);
        Task<UserProfile> GetUserByUsername(string username);
        Task<UserProfile> GetUserByEmail(string email);
        Task<UserProfile> GetUserByPhoneNumber(string phoneNumber);
        Task<int> AddAsync(UserProfile entity, string[]? cols = null);
        Task<bool> UpdateAsync(UserProfile entity, int id, string[]? cols = null);
        Task<bool> DeleteAsync(int id);
        Task<bool> DeleteSoftAsync(int id);
    }
}