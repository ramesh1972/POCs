using Dapper;
using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public class UserQuestionRepository(DapperContext dapperContext) : BaseRepository<UserAskedQuestion>(dapperContext, "user_asked_questions", "user_question_id"), IUserQuestionRepository
    {
        public async Task<IEnumerable<UserAskedQuestion>> GetAllAsync(bool includeOnlyAnswered = false, bool includeInActive = true, bool includeDeleted = false)
        {
            var connection = CreateConnection();

            var condition = includeInActive ? "is_deleted = @is_deleted" : "is_active = true AND is_deleted = @is_deleted";

            var sql = includeOnlyAnswered ?
                    "SELECT * FROM user_asked_questions WHERE admin_answer IS NULL AND " + condition :
                    "SELECT * FROM user_asked_questions WHERE " + condition;


            var userQuestions = await connection.QueryAsync<UserAskedQuestion>(sql, new { is_deleted = includeDeleted });
            return userQuestions;
        }

        public async Task<IEnumerable<UserAskedQuestion>> GetUserQuestions(int userId)
        {
            var connection = CreateConnection();

            var userQuestions = await connection.QueryAsync<UserAskedQuestion>(
                "SELECT * FROM user_asked_questions WHERE user_id = @userId",
                new { userId = userId }
            );

            return userQuestions;
        }


        public async Task<IEnumerable<UserAskedQuestion>> GetPublicUserQuestions()
        {
            var connection = CreateConnection();

            var userQuestions = await connection.QueryAsync<UserAskedQuestion>(
                "SELECT * FROM user_asked_questions WHERE is_public = true"
            );

            return userQuestions;
        }

        public async Task<UserAskedQuestion> GetUserQuestionById(int userQuestionId)
        {
            using (var connection = CreateConnection())
            {
                var userQuestion = await connection.QueryFirstOrDefaultAsync<UserAskedQuestion>(
                    "SELECT * FROM user_asked_questions WHERE user_questions_id = @userQuestionId",
                    new { userQuestionId = userQuestionId }
                );

                return userQuestion!;
            }
        }

        public async Task<bool> AnswerQuestion(int userQuestionId, string answer, int admin_user_id)
        {
            using (var connection = CreateConnection())
            {
                var result = await connection.ExecuteAsync(
                    "UPDATE user_asked_questions SET admin_user_id = @admin_user_id, admin_answer = @answer, date_answered = @date_answered WHERE user_questions_id = @userQuestionId",
                    new { admin_user_id, answer, date_answered = DateTime.Now, userQuestionId }
                );

                return result > 0;
            }
        }

        public async Task<bool> MakePublic(int userQuestionId)
        {
            using (var connection = CreateConnection())
            {
                var result = await connection.ExecuteAsync(
                    "UPDATE user_asked_questions SET is_public = true WHERE user_questions_id = @userQuestionId",
                    new { userQuestionId = userQuestionId }
                );

                return result > 0;
            }
        }

        public async Task<bool> MakePrivate(int userQuestionId)
        {
            using (var connection = CreateConnection())
            {
                var result = await connection.ExecuteAsync(
                    "UPDATE user_asked_questions SET is_public = false WHERE user_questions_id = @userQuestionId",
                    new { userQuestionId = userQuestionId }
                );

                return result > 0;
            }
        }
    }
}