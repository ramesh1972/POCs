using System.Net.Http.Headers;
using Dapper;
using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories.impl
{
    public class UserProfileRepository(DapperContext dapperContext) : BaseRepository<UserProfile>(dapperContext, "user_profiles", "profile_id"), IUserProfileRepository
    {
        public async Task<IEnumerable<UserProfile>> GetUsers(bool inactive = true, bool is_deleted = false) 
        {
            var connection = CreateConnection();
            var condition = inactive ? "is_deleted = @is_deleted" : "is_active = true AND is_deleted = @is_deleted";

            var sql = "SELECT * FROM user_profiles T1 INNER JOIN users T2 ON T1.user_id = T2.user_id" + 
            " WHERE " + condition;

            var users = await connection.QueryAsync<UserProfile>(sql, new { is_deleted = is_deleted });
            return users;
        }

        public async Task<UserProfile> GetUserById(int userId)
        {
            var connection = CreateConnection();
            var user = await connection.QueryFirstOrDefaultAsync<UserProfile>(
                "SELECT * FROM user_profiles T1 INNER JOIN users T2 ON T1.user_id = T2.user_id WHERE T1.user_id = @userId",
                new { userId = userId }
            );

            return user!;
        }

        public async Task<UserProfile> GetUserByUsername(string username)
        {
            var connection = CreateConnection();
            var user = await connection.QueryFirstOrDefaultAsync<UserProfile>(
                "SELECT * FROM user_profiles T1 INNER JOIN users T2 ON T1.user_id = T2.user_id WHERE T2.username = @username",
                new { username = username }
            );

            return user!;
        }

        public async Task<UserProfile> GetUserByEmail(string email)
        {
            var connection = CreateConnection();
            var user = await connection.QueryFirstOrDefaultAsync<UserProfile>(
                "SELECT * FROM user_profiles T1 INNER JOIN users T2 ON T1.user_id = T2.user_id WHERE T2.email = @email",
                new { email = email }
            );

            return user!;
        }

        public async Task<UserProfile> GetUserByPhoneNumber(string phoneNumber)
        {
            var connection = CreateConnection();
            var user = await connection.QueryFirstOrDefaultAsync<UserProfile>(
                "SELECT * FROM user_profiles T1 INNER JOIN users T2 ON T1.user_id = T2.user_id WHERE T2.phone_number = @phoneNumber",
                new { phoneNumber = phoneNumber }
            );

            return user!;
        }
    }
}