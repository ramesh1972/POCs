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
    public class ContentController(IRepositoryManager repository, IMapper mapper, ILogger logger) : ControllerBase
    {
        private readonly IRepositoryManager _repository = repository;
        private readonly IMapper _mapper = mapper;
        private readonly ILogger _logger = logger;

        [HttpGet("{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetContentAsync(bool? includeInActive = true, bool? includeDeleted = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state for the EntityActionRecordDTO object");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state for the EntityActionRecordDTO object");
            }

            var Contents = await _repository.Content.GetAllContents(includeInActive ?? true, includeDeleted ?? false);
            System.Console.WriteLine("Contents: " + Contents);

            if (Contents == null)
            {
                _logger.LogInformation("No Content found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No Content found.");
            }

            var ContentDto = _mapper.Map<IEnumerable<ContentDTO>>(Contents);
            if (ContentDto == null)
            {
                _logger.LogInformation("No Content found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No Content found.");
            }

            return APIR.SuccessResponse("Content Fetched Successfully.", ContentDto);
        }

        [HttpGet("{id}")]
        async public Task<IActionResult> GetContent(int id)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state for the EntityActionRecordDTO object");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state for the EntityActionRecordDTO object");
            }

            var Content = await _repository.Content.GetContentById(id);
            if (Content == null)
            {
                _logger.LogInformation("Content with id: {id} doesn't exist.", id);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No Content found.");
            }
            else
            {
                var ContentDto = _mapper.Map<ContentDTO>(Content);
                return APIR.SuccessResponse("Content Fetched Successfully.", ContentDto);
            }
        }

        [HttpPost]
        async public Task<IActionResult> CreateContentAsync([FromBody] ContentDTO contentDTO)
        {
            if (contentDTO == null)
            {
                _logger.LogError("ContentForCreationDto object sent from client is null.");
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "ContentForCreationDto object is null");
            }

            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state for the ContentForCreationDTO object");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state for the ContentForCreationDTO object");
            }

            var content = _mapper.Map<Content>(contentDTO);
            var result = await _repository.Content.AddAsync(content);
            if (result < 1)
            {
                _logger.LogError("Content object not created.");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Content not created.");
            }

            return APIR.SuccessResponse("Content Created Successfully.", content);
        }

        [HttpDelete("{id}")]
        async public Task<IActionResult> DeleteContentAsync(int id)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state for the ContentForCreationDTO object");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state for the ContentForCreationDTO object");
            }

            var content = await _repository.Content.GetContentById(id);
            if (content == null)
            {
                _logger.LogInformation("Content with id: {id} doesn't exist.", id);
                APIR.ErrorResponse(HttpStatusCode.NotFound, "No Content found.");
            }

            bool result = await _repository.Content.DeleteAsync(id);
            if (!result)
            {
                _logger.LogError("Content object not deleted.");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Content not deleted.");
            }

            return APIR.SuccessResponse("Content Deleted Successfully.");
        }

        [HttpPost("{id}")]
        async public Task<IActionResult> UpdateContentAsync(int id, [FromBody] ContentDTO contentDTO)
        {
            if (contentDTO == null)
            {
                _logger.LogError("ContentForUpdateDto object sent from client is null.");
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "ContentForUpdateDto object is null");
            }

            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state for the ContentForUpdateDto object");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state for the ContentForUpdateDto object");
            }

            Content content = _mapper.Map<Content>(contentDTO);

            bool result = await _repository.Content.UpdateAsync(content, id);
            if (!result)
            {
                _logger.LogError("Content object not updated.");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Content not updated.");
            }

            return APIR.SuccessResponse("Content Updated Successfully.");
        }
    }
}


