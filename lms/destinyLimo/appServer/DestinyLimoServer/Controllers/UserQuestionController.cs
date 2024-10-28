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
    public class UserQuestionController(IRepositoryManager repository, IMapper mapper, ILogger logger) : ControllerBase
    {
        private readonly IRepositoryManager _repository = repository;
        private readonly IMapper _mapper = mapper;
        private readonly ILogger _logger = logger;

        [HttpGet("{includeOnlyAnswered?}/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetUserQuestionsAsync(bool? includeOnlyAnswered = false, bool? includeInActive = true, bool? includeDeleted = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userQuestions = await _repository.UserQuestion.GetAllAsync(includeOnlyAnswered ?? false, includeInActive ?? true, includeDeleted ?? false);
            System.Console.WriteLine("UserQuestions: " + userQuestions);
            if (userQuestions == null)
            {
                _logger.LogInformation("No UserQuestions found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No User Questions found.");
            }

            var userQuestionDto = _mapper.Map<IEnumerable<UserAskedQuestionDTO>>(userQuestions);
            return APIR.SuccessResponse("User Questions Fetched Successfully.", userQuestionDto);
        }

        [HttpGet("user/{userId}")]
        async public Task<IActionResult> GetUserQuestions(int userId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userQuestions = await _repository.UserQuestion.GetUserQuestions(userId);
            if (userQuestions == null)
            {
                _logger.LogInformation("UserQuestions with userId: {userId} doesn't exist in the database.", userId);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "User Questions by userId: {userId} not found");
            }
            else
            {
                var userQuestionDto = _mapper.Map<IEnumerable<UserAskedQuestionDTO>>(userQuestions);
                return APIR.SuccessResponse("User Questions Fetched Successfully.", userQuestionDto);
            }
        }

        [HttpGet("question/{userQuestionId}")]
        async public Task<IActionResult> GetUserQuestionById(int userQuestionId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userQuestion = await _repository.UserQuestion.GetUserQuestionById(userQuestionId);
            if (userQuestion == null)
            {
                _logger.LogInformation("UserQuestion with id: {userQuestionId} doesn't exist in the database.", userQuestionId);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "User Question with id: {userQuestionId} not found");
            }
            else
            {
                var userQuestionDto = _mapper.Map<UserAskedQuestionDTO>(userQuestion);
                return APIR.SuccessResponse("User Question Fetched Successfully.", userQuestionDto);
            }
        }

        [HttpPost("answer/{userQuestionId}")]
        async public Task<IActionResult> AnswerQuestionAsync(int userQuestionId, [FromQuery] int admin_user_id, string answer)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }


            if (String.IsNullOrEmpty(answer))
            {
                _logger.LogError("Answer string sent from client is null.");
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Answer string is null");
            }

            var userAskedQuestion = _mapper.Map<UserAskedQuestion>(userQuestionId);
            bool success = await _repository.UserQuestion.AnswerQuestion(userAskedQuestion.user_question_id, userAskedQuestion.admin_answer!, userAskedQuestion.admin_user_id);

            if (!success)
            {
                _logger.LogError("Failed to answer the question with id: {userQuestionId}", userQuestionId);
                return StatusCode(500, "Failed to answer the question");
            }

            return APIR.SuccessResponse("Question answered successfully");
        }

        [HttpGet("public")]
        async public Task<IActionResult> GetPublicUserQuestions()
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var userQuestions = await _repository.UserQuestion.GetPublicUserQuestions();
            if (userQuestions == null)
            {
                _logger.LogInformation("UserQuestions that are public doesn't exist in the database.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No public User Questions found.");
            }
            else
            {
                var userQuestionDto = _mapper.Map<UserAskedQuestionDTO>(userQuestions);
                return APIR.SuccessResponse("Public User Questions Fetched Successfully.", userQuestionDto);
            }
        }

        [HttpPost("public/{userQuestionId}")]
        async public Task<IActionResult> MakePublic(int userQuestionId, bool makePublic = true)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            bool success = makePublic ? await _repository.UserQuestion.MakePublic(userQuestionId) : await _repository.UserQuestion.MakePrivate(userQuestionId);

            if (!success)
            {
                _logger.LogError("Failed to make the question with id: {userQuestionId} public", userQuestionId);
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Failed to make the question public");
            }

            return APIR.SuccessResponse("Question made public successfully");
        }

        [HttpPost]
        async public Task<IActionResult> AddUserQuestion([FromBody] UserAskedQuestionDTO userQuestionDto)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            System.Console.WriteLine("UserQuestionDTO: " + userQuestionDto);

            var userQuestion = _mapper.Map<UserAskedQuestion>(userQuestionDto);
            int userQuestionId = await _repository.UserQuestion.AddAsync(userQuestion);

            if (userQuestionId == 0)
            {
                _logger.LogError("Failed to add the user question to the database");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Failed to add the user question");
            }

            return APIR.SuccessResponse("User question added successfully", userQuestionId);
        }

        [HttpPut("{userQuestionId}")]
        async public Task<IActionResult> UpdateUserQuestion(int userQuestionId, [FromBody] UserAskedQuestionDTO userQuestionDto)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }


            var userQuestion = _mapper.Map<UserAskedQuestion>(userQuestionDto);
            bool success = await _repository.UserQuestion.UpdateAsync(userQuestion, userQuestionId);

            if (!success)
            {
                _logger.LogError("Failed to update the user question with id: {userQuestionId}", userQuestionId);
                return StatusCode(500, "Failed to update the user question");
            }

            return Ok("User question updated successfully");
        }

        [HttpDelete("{userQuestionId}")]
        async public Task<IActionResult> DeleteUserQuestion(int userQuestionId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            bool success = await _repository.UserQuestion.DeleteAsync(userQuestionId);

            if (!success)
            {
                _logger.LogError("Failed to delete the user question with id: {userQuestionId}", userQuestionId);
                return StatusCode(500, "Failed to delete the user question");
            }

            return Ok("User question deleted successfully");
        }
    }
}
