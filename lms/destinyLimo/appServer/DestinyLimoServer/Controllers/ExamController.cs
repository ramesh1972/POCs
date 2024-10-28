using DestinyLimoServer.Repositories;
using Microsoft.AspNetCore.Mvc;
using AutoMapper; // Add this line to import the IMapper interface
using DestinyLimoServer.DTOs.ResponseDTOs;
using DestinyLimoServer.Models;
using System.Net;

// alias this to APIR
using APIR = DestinyLimoServer.Common.ApiResponse.ApiResponse;

namespace DestinyLimoServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExamController(IRepositoryManager repository, IMapper mapper, ILogger logger) : ControllerBase
    {
        private readonly IRepositoryManager _repository = repository;
        private readonly IMapper _mapper = mapper;
        private readonly ILogger _logger = logger;

        private readonly int numQuestions = 15;

        [HttpGet("{onlyExamsNotStarted}")]
        public async Task<IActionResult> GetUserExamsAsync(bool onlyExamsNotStarted = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userExams = await _repository.Exam.GetAllUserExams(onlyExamsNotStarted);
            System.Console.WriteLine("UserExams: " + userExams);

            if (userExams == null)
            {
                _logger.LogInformation("No UserExams found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No UserExams found.");
            }

            var userExamsDto = _mapper.Map<IEnumerable<UserExamDTO>>(userExams);
            return APIR.SuccessResponse("UserExams Fetched Successfully.", userExamsDto);
        }

        [HttpGet("user/{userId}")]
        async public Task<IActionResult> GetUserExamsForUser(int userId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userExams = await _repository.Exam.GetUserExamsByUserId(userId);
            if (userExams == null)
            {
                _logger.LogInformation("UserExam with id: {id} doesn't exist in the database.", userId);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "UserExam with id: {id} doesn't exist in the database.");
            }
            else
            {
                var userExamsDto = _mapper.Map<IEnumerable<UserExamDTO>>(userExams);
                return APIR.SuccessResponse("UserExams Fetched Successfully.", userExamsDto);
            }
        }


        [HttpGet("questions/{examId}")]
        async public Task<IActionResult> GetExam(int examId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userExam = await _repository.Exam.GetByIdAsync(examId);
            if (userExam == null)
            {
                _logger.LogInformation("UserExam with id: {id} doesn't exist in the database.", examId);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "UserExam with id: {id} doesn't exist in the database.");
            }
            else
            {
                var userExamDto = _mapper.Map<UserExamDTO>(userExam);

                // create the questions for the exam
                var mcqs = await _repository.Material<MaterialMCQ>().GetRandomQuestions(numQuestions);
                if (mcqs == null)
                {
                    _logger.LogInformation("No MCQs found.");
                    return APIR.ErrorResponse(HttpStatusCode.NotFound, "No MCQs found.");
                }

                double min_correct_answers_for_pass = Math.Round((double)(numQuestions / 2), 0);

                // return the exam
                userExamDto.DateStarted = DateTime.Now;
                userExamDto.min_correct_answers_for_pass = Convert.ToInt32(min_correct_answers_for_pass);
                userExamDto.ExamQuestions = _mapper.Map<IEnumerable<MaterialMCQDTO>>(mcqs);

                return APIR.SuccessResponse("MCQs Fetched Successfully.", userExamDto);
            }
        }

        [HttpGet("answers/{examId}")]
        async public Task<IActionResult> GetUserExamQuestionsAnswers(int examId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userExamAnswers = await _repository.Exam.GetUserExamAnswersByExamId(examId);
            if (userExamAnswers == null)
            {
                _logger.LogInformation("Exam with id: {id} doesn't exist in the database.", examId);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "Exam with id: {id} doesn't exist in the database.");
            }
            else
            {
                var userExamAnswersDto = _mapper.Map<IEnumerable<UserExamAnswerDTO>>(userExamAnswers);
                return APIR.SuccessResponse("User Exam Answers Fetched Successfully.", userExamAnswersDto);
            }
        }

        [HttpPost("admin/{userId}")]
        async public Task<IActionResult> AddNewExamByAdminAsync(int userId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            // create a record of the new exam
            int newExamId = await _repository.Exam.AddNewExamAsync(userId);
            if (newExamId < 1)
            {
                _logger.LogError("Exam not created.");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Exam not created.");
            }

            return APIR.SuccessResponse("Exam created successfully.", newExamId);
        }

        [HttpPost("{userId}")]
        async public Task<IActionResult> AddNewExamAsync(int userId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            // create a record of the new exam
            int newExamId = await _repository.Exam.AddNewExamAsync(userId);
            if (newExamId < 1)
            {
                _logger.LogError("Exam not created.");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Exam not created.");
            }

            // create the questions for the exam
            var mcqs = await _repository.Material<MaterialMCQ>().GetRandomQuestions(numQuestions);
            if (mcqs == null)
            {
                _logger.LogInformation("No MCQs found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No MCQs found.");
            }

            double min_correct_answers_for_pass = Math.Round((double)(numQuestions / 2), 0);

            // return the exam
            var userExam = new UserExamDTO
            {
                ExamId = newExamId,
                UserId = userId,
                DateStarted = DateTime.Now,
                min_correct_answers_for_pass = Convert.ToInt32(min_correct_answers_for_pass),
                ExamQuestions = _mapper.Map<IEnumerable<MaterialMCQDTO>>(mcqs),
            };

            return APIR.SuccessResponse("Exam created successfully.", userExam);
        }

        [HttpPut()]
        async public Task<IActionResult> UpdateUserExamAsyn(UserExamDTO newExam)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userExams = _mapper.Map<IEnumerable<UserExamAnswer>>(newExam.UserExamAnswers);
            var examAnswerIds = await _repository.Exam.SumbitUserExamAnswersAsync(userExams);
            if (examAnswerIds == null)
            {
                _logger.LogError("Exam answers not submitted.");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Exam answers not submitted.");
            }

            // update score
            int score = newExam.UserExamAnswers!.Where(x => x.is_correct == true).Count();
            newExam.Score = score;

            // update result
            newExam.num_correct = score;
            newExam.num_attempted = newExam.UserExamAnswers!.Where(x => x.attempted == true).Count();
            newExam.num_wrong = newExam.num_questions - newExam.num_correct;

            newExam.Result = score >= newExam.min_correct_answers_for_pass ? 1 : 0;

            // update date completed
            newExam.DateCompleted = DateTime.Now;

            var userExam = _mapper.Map<UserExam>(newExam);
            Boolean result = await _repository.Exam.UpdateAsync(userExam, userExam.exam_id);
            if (!result)
            {
                _logger.LogError("UserExam not updated.");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "User Exam not Submitted.");
            }

            return APIR.SuccessResponse("User Exam Submitted Successfully.", newExam);
        }
    }
}


