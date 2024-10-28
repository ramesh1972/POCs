using DestinyLimoServer.Models;
using DestinyLimoServer.Common.Repository;

namespace DestinyLimoServer.Repositories
{
    public interface IExamRepository : IBaseRepository<UserExam>
    {
        Task<IEnumerable<UserExam>> GetAllUserExams(bool onlyExamsNotStarted);
        Task<IEnumerable<UserExam>> GetUserExamsByUserId(int userId);
        Task<IEnumerable<UserExamAnswer>> GetUserExamAnswersByExamId(int examId);

        Task<int> AddNewExamAsync(int userId);

        Task<IEnumerable<int>> SumbitUserExamAnswersAsync(IEnumerable<UserExamAnswer> answers);
    }
}