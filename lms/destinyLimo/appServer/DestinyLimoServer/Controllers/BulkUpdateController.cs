using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using AutoMapper;
using Newtonsoft.Json;

// alias this to APIR
using APIR = DestinyLimoServer.Common.ApiResponse.ApiResponse;

using DestinyLimoServer.Repositories;
using DestinyLimoServer.DTOs.RequestDTOs;
using DestinyLimoServer.Models;
using DestinyLimoServer.Common.Uploader;
using System.Net;

namespace DestinyLimoServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BulkUpdateController(IBulkUpdateRepository repository, IMapper mapper, ILogger logger, IConfiguration configuration) : ControllerBase
    {
        private readonly IBulkUpdateRepository _repository = repository;
        private readonly IMapper _mapper = mapper;
        private readonly ILogger _logger = logger;
        private readonly IConfiguration _configuration = configuration;

        [HttpPost("{tableName}")]
        [RequestSizeLimit(100_000_000)]
        async public Task<IActionResult> BulkUpdate(string tableName, [FromForm] BulkUpdateDTO bulkUpdateDTO)
        {
            // Deserialize actions
            var actions = JsonConvert.DeserializeObject<List<EntityActionDTO>>(bulkUpdateDTO.Actions);

            if (actions == null || actions.Count == 0)
            {
                _logger.LogError("EntityActiondDTO object sent from client is null or empty.");
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "EntityActiondDTOs object is null or empty");
            }

            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state for the EntityActionRecordDTO object");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state for the EntityActionRecordDTO object");
            }

            // Process files
            List<IFormFile> files = HttpContext.Request.Form.Files.ToList();
            FileUploader fileUploader = new FileUploader(_logger, _configuration);

            foreach (var file in files)
            {
                if (file!.Length > 0)
                {
                    if (tableName == "content")
                        await fileUploader.UploadFileAsync(file, UploadFilePaths.Content);
                    else if (tableName.Contains("training"))
                        await fileUploader.UploadFileAsync(file, UploadFilePaths.TrainingMaterial);
                
                }
            }

            // update the table
            var entityActionsModelObjects = _mapper.Map<List<EntityAction>>(actions);
            var isSuccess = _repository.BulkUpdateEntities(tableName, entityActionsModelObjects);

            if (isSuccess)
                return APIR.SuccessResponse("Bulk update successfull");
                
            return APIR.ErrorResponse(HttpStatusCode.BadRequest, "A problem happened while handling your request.");
        }
    }
}
