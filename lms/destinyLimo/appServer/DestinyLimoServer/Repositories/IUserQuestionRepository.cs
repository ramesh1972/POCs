using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public interface IUserQuestionRepository
    {
        Task<IEnumerable<UserAskedQuestion>> GetAllAsync(bool includeOnlyAnswered = false, bool includeInActive = true, bool includeDeleted = false);   
        Task<IEnumerable<UserAskedQuestion>> GetUserQuestions(int userId);
        Task<IEnumerable<UserAskedQuestion>> GetPublicUserQuestions();
        Task<UserAskedQuestion> GetUserQuestionById(int userQuestionId);

        Task<bool> AnswerQuestion(int userQuestionId, string answer, int admin_user_id);
        Task<bool> MakePublic(int userQuestionId);
        Task<bool> MakePrivate(int userQuestionId);

        Task<int> AddAsync(UserAskedQuestion entity, string[]? cols = null);
        Task<bool> UpdateAsync(UserAskedQuestion entity, int id, string[]? cols = null);
        Task<bool> DeleteAsync(int id);
        Task<bool> DeleteSoftAsync(int id);
    }
}