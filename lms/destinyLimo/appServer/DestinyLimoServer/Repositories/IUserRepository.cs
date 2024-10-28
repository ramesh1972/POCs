using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public interface IUserRepository
    {
        Task<IEnumerable<User>> GetUsers(bool inactive = true, bool is_deleted = false);
        Task<IEnumerable<User>> GetApprovedUsers();
        Task<User> GetUserById(int userId);
        Task<User> GetUserByUsername(string username);
        Task<User> GetUserByEmail(string email);

        Task<IEnumerable<User>> GetUsersByRole(string roleName, bool active = true, bool approved = true);
        Task<IEnumerable<User>> GetUsersByRoleId(int roleId, bool active = true, bool approved = true);


        // --------------------------------------------
        Task<User?> RegisterUser(User user, UserProfile userProfile);

        // --------------------------------------------
        Task<User> AuthenticateUser(string userName, string password);
        Task<User?> LogoutUser();
        Task<User> ChangePassword(int userId, string oldPassword, string newPassword);
        Task<User> ForgotPassword(string email);
        Task<User> ResetPassword(int userId, string newPassword);

        // --------------------------------------------
        Task<User> ApproveRejectUser(int userId, bool isApproved = true, string? approveRejectReason = "", int approvedRejectedBy = 2);
        Task<User> LockUser(int userId, bool isLocked);

        // --------------------------------------------
        Task<User> UpdateUser(User user);
        Task<User> DeleteUser(int userId);
        Task<User> DeleteSoftUser(int userId);
    }
}