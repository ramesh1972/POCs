using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;
using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Repositories;

namespace DestinyLimoServer.Repositories.impl
{
    public class RoleRepository(DapperContext dapperContext) : BaseRepository<Role>(dapperContext, "roles", "role_id"), IRoleRepository
    {
        public async Task<IEnumerable<Role>> GetRoles(bool inactive = true, bool is_deleted = false)
        {
            return await GetAllAsync(inactive, is_deleted);
        }

        public async Task<Role> GetRole(int roleId)
        {
            return await GetByIdAsync(roleId);
        }

        public async Task<Role> GetRole(string roleName)
        {
            return await QueryFirstOrDefaultAsync("SELECT * FROM Role WHERE RoleName = @RoleName", new { RoleName = roleName });
        }

        public async Task<IEnumerable<UserRole>> GetUserRoles(int userId)
        {
            BaseRepository<UserRole> userRoleRepo = new BaseRepository<UserRole>(_context, "user_roles", "user_role_id");

            var sql = "SELECT ur.user_role_id, ur.user_id, ur.role_id, r.role_name FROM user_roles ur JOIN roles r ON ur.role_id = r.role_id WHERE user_id = @userId";

            return await userRoleRepo.QueryAsync(sql, new { userId = userId });
        }

        public async Task<IEnumerable<UserRole>> GetAllUsersRoles()
        {
            BaseRepository<UserRole> userRoleRepo = new BaseRepository<UserRole>(_context, "user_roles", "user_role_id");

            var sql = "SELECT ur.user_role_id, ur.user_id, ur.role_id, r.role_name FROM user_roles ur JOIN roles r ON ur.role_id = r.role_id";
            return await userRoleRepo.QueryAsync(sql);
        }
    }
}