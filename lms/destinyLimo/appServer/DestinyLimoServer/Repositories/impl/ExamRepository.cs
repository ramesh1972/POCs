using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories.impl
{
    public class ExamRepository : BaseRepository<UserExam>, IExamRepository
    {
        public ExamRepository(DapperContext dapperContext) : base(dapperContext, "user_exams", "exam_id")
        {
            //Dapper.SqlMapper.SetTypeMap(typeof(Exam), new ColumnAttributeTypeMapper<Exam>());
        }

        public async Task<IEnumerable<UserExam>> GetAllUserExams(bool onlyExamsNotStarted)
        {

            string query = onlyExamsNotStarted ? $"SELECT * FROM user_exams WHERE date_started is NULL" :
                "SELECT * FROM user_exams";

            return await QueryAsync(query);
        }

        public async Task<IEnumerable<UserExam>> GetUserExamsByUserId(int userId)
        {
            string query = $"SELECT * FROM user_exams WHERE user_id = @userId";
            return await QueryAsync(query, new { userId = userId });
        }

        public async Task<IEnumerable<UserExamAnswer>> GetUserExamAnswersByExamId(int examId)
        {
            BaseRepository<UserExamAnswer> userExamAnswerRepository = new(this._context, "user_exam_answers", "exam_id");
            var answers = await userExamAnswerRepository.GetMultipleByIdAsync(examId);
            return answers!;
        }

        public async Task<int> AddNewExamAsync(int userId)
        {
            UserExam exam = new()
            {
                user_id = userId,
                date_created = System.DateTime.Now
            };

            return await AddAsync(exam);
        }

        public async Task<IEnumerable<int>> SumbitUserExamAnswersAsync(IEnumerable<UserExamAnswer> answers)
        {
            BaseRepository<UserExamAnswer> userExamAnswerRepository = new(this._context, "user_exam_answers", "exam_question_id");
            return await userExamAnswerRepository.AddMultipleAsync(answers);
        }
    }
}