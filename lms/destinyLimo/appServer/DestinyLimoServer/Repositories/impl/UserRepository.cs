using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;
using DestinyLimoServer.Repositories;

namespace DestinyLimoServer.Repositories.impl
{
    public class UserRepository(DapperContext dapperContext) : BaseRepository<User>(dapperContext, "users", "user_id"), IUserRepository
    {

        public async Task<IEnumerable<User>> GetUsers(bool inactive = true, bool is_deleted = false)
        {
            return await GetAllAsync(inactive, is_deleted);
        }

        public async Task<User> GetUserById(int userId)
        {
            return await GetByIdAsync(userId);
        }

        public async Task<User> GetUserByUsername(string username)
        {
            return await QueryFirstOrDefaultAsync("SELECT * FROM users WHERE username = @username", new { username = username });
        }

        public async Task<User> GetUserByEmail(string email)
        {
            return await QueryFirstOrDefaultAsync("SELECT * FROM users WHERE email = @email", new { email = email });
        }

        public async Task<IEnumerable<User>> GetApprovedUsers()
        {
            return await QueryAsync("SELECT * FROM users is_approved = true");
        }

        public async Task<IEnumerable<User>> GetUsersByRole(string roleName, bool active = true, bool approved = true)
        {
            return await QueryAsync("SELECT * FROM users T1 INNER JOIN user_roles T2 ON T1.user_id = T2.user_id WHERE T1.is_active = @active AND T1.is_approved = @approved AND T2.role_id = (SELECT role_id FROM roles WHERE role_name = @roleName)", new { active = active, approved = approved, roleName = roleName });
        }

        public async Task<IEnumerable<User>> GetUsersByRoleId(int roleId, bool active = true, bool approved = true)
        {
            return await QueryAsync("SELECT * FROM users T1 INNER JOIN user_role T2 ON T1.user_id = T2.user_id WHERE T1.is_active = @active AND T2.is_approved = @approved AND T2.role_id = @roleId", new { active = active, approved = approved, roleId = roleId });
        }

        public async Task<User?> RegisterUser(User user, UserProfile userProfile)
        {
            // add in user table
            int userId = await AddAsync(user);
            if (userId == -1)
            {
                return null;
            }

            // add in user_profile table
            userProfile.user_id = userId;
            UserProfileRepository userProfileRepo = new UserProfileRepository(_context);

            await userProfileRepo.AddAsync(userProfile);

            // add in user_roles table
            // TODO: assuming the role is driver for now
            var sql = "INSERT INTO user_roles (user_id, role_id) VALUES (@userId, 2)";
            await ExecuteAsync(sql, new { userId = userId });

            // get the whole object
            return await GetUserById(userId);
        }

        // --------------------------------------------
        public async Task<User> AuthenticateUser(string username, string password)
        {
            User user = await QueryFirstOrDefaultAsync("SELECT * FROM users WHERE username = @username AND password_hash = @password", new { username = username, password = password });
            return user;
        }

        public async Task<User?> LogoutUser()
        {
            // TODO: add login related table and update the login status
            await Task.Delay(0);
            return null!;
        }

        // TODO: hash the password
        public async Task<User> ChangePassword(int userId, string oldPassword, string newPassword)
        {
            User user = await QueryFirstOrDefaultAsync("SELECT user_id FROM users WHERE user_id = @userId AND password_hash = @oldPassword", new { userId = userId, oldPassword = oldPassword });
            if (user == null)
            {
                return null!;
            }

            await ExecuteAsync("UPDATE users SET password_hash = @newPassword WHERE user_id = @userId", new { userId = userId, newPassword = newPassword });

            return user;
        }

        public async Task<User> ForgotPassword(string email)
        {
            User user = await QueryFirstOrDefaultAsync("SELECT user_id FROM users WHERE email = @email", new { email = email });
            if (user == null)
            {
                return null!;
            }

            // TODO send email with password reset link
            return user;
        }

        // TODO: hash the password
        public async Task<User> ResetPassword(int userId, string newPassword)
        {
            await ExecuteAsync("UPDATE users SET password_hash = @newPassword WHERE user_id = @userId", new { userId = userId, newPassword = newPassword });
            return await GetUserById(userId);
        }

        // --------------------------------------------
        public async Task<User> ApproveRejectUser(int userId, bool isApproved = true, string? approveRejectReason = "", int approvedRejectedBy = 2)
        {
            string dateNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            await ExecuteAsync("UPDATE users SET is_approved = @isApproved, approved_rejected_reason = @approveRejectReason, approved_rejected_by = @approvedRejectedBy, approved_rejected_datetime='" + dateNow + "' " + " WHERE user_id = @userId", new { userId = userId, isApproved = isApproved, approveRejectReason = approveRejectReason, approvedRejectedBy = approvedRejectedBy });
            return await GetUserById(userId);
        }

        public async Task<User> LockUser(int userId, bool isLocked)
        {
            await ExecuteAsync("UPDATE users SET is_locked = @isLocked WHERE user_id = @userId", new { userId = userId, isLocked = isLocked });
            return await GetUserById(userId);
        }

        // --------------------------------------------
        public async Task<User> UpdateUser(User user)
        {
            var sql = "UPDATE users SET email = @email WHERE user_id = @userId";
            await ExecuteAsync(sql, new { email = user.email, userId = user.user_id });
            return await GetUserById((int)user.user_id!);
        }

        public async Task<User> DeleteUser(int userId)
        {
            await DeleteAsync(userId);
            return await GetUserById(userId);
        }

        public async Task<User> DeleteSoftUser(int userId)
        {
            await ExecuteAsync("UPDATE users SET is_deleted = true WHERE user_id = @userId", new { userId = userId });
            return await GetUserById(userId);
        }
    }
}