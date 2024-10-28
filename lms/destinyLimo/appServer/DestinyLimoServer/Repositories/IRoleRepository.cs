using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public interface IRoleRepository
    {
        Task<IEnumerable<Role>> GetRoles(bool inactive = true, bool is_deleted = false);
        Task<Role> GetRole(int roleId);
        Task<Role> GetRole(string roleName);
        Task<IEnumerable<UserRole>> GetUserRoles(int userId);

        Task<IEnumerable<UserRole>> GetAllUsersRoles();

        Task<int> AddAsync(Role entity, string[]? cols = null);
        Task<bool> UpdateAsync(Role entity, int id, string[]? cols = null);
        Task<bool> DeleteAsync(int id);
        Task<bool> DeleteSoftAsync(int id);

    }
}