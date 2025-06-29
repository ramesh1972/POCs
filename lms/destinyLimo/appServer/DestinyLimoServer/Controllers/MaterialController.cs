using DestinyLimoServer.Repositories;
using Microsoft.AspNetCore.Mvc;
using AutoMapper; // Add this line to import the IMapper interface
using DestinyLimoServer.DTOs.RequestDTOs;
using DestinyLimoServer.Models;
using DestinyLimoServer.DTOs.ResponseDTOs;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Repositories.impl;
using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Uploader;

using System.Net;

// alias this to APIR
using APIR = DestinyLimoServer.Common.ApiResponse.ApiResponse;

namespace DestinyLimoServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MaterialController(DapperContext dapper, IMapper mapper, ILogger logger, IConfiguration configuration) : ControllerBase
    {
        private readonly DapperContext _dapper = dapper;
        private readonly IMapper _mapper = mapper;
        private readonly ILogger _logger = logger;
        private readonly IConfiguration _configuration = configuration;

        [HttpGet("material/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetMaterialsAsync(bool? includeInActive = true, bool? includeDeleted = false, bool? isPublic = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            System.Console.WriteLine("is public : controller", isPublic);
            IMaterialRepository<Material> _repository = new MaterialRepository<Material>(_dapper);

            var materials = await _repository.GetAllMaterials(isPublic ?? false, includeInActive ?? true, includeDeleted ?? false);
            if (materials == null)
            {
                _logger.LogInformation("No materials found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No material found.");
            }

            System.Console.WriteLine("materials: " + materials);

            var materialDTOs = _mapper.Map<IEnumerable<MaterialFileDTO>>(materials);

            return APIR.SuccessResponse("Material Fetched Successfully.", materialDTOs);
        }

        [HttpGet("file/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetFileMaterialsAsync(bool? includeInActive = true, bool? includeDeleted = false, bool? isPublic = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            IMaterialRepository<MaterialFile> _repository = new MaterialRepository<MaterialFile>(_dapper);

            var materials = await _repository.GetAllMaterials(isPublic ?? false, includeInActive ?? true, includeDeleted ?? false);
            if (materials == null)
            {
                _logger.LogInformation("No materials found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No material found.");
            }

            System.Console.WriteLine("materials: " + materials);

            var materialDTOs = _mapper.Map<IEnumerable<MaterialFileDTO>>(materials);

            FileUploader fileUploader = new FileUploader(_logger, _configuration);

            // copy the material_id to id field
            foreach (var materialDTO in materialDTOs)
            {
                materialDTO.id = materialDTO.material_id;
                materialDTO.file_name = fileUploader.GetFilePathName(UploadFilePaths.TrainingMaterial, materialDTO.file_name!);
            }

            return APIR.SuccessResponse("Material Fetched Successfully.", materialDTOs);
        }

        [HttpGet("text/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetTextMaterialsAsync(bool? includeInActive = true, bool? includeDeleted = false, bool? isPublic = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            IMaterialRepository<MaterialText> _repository = new MaterialRepository<MaterialText>(_dapper);

            var materials = await _repository.GetAllMaterials(isPublic ?? false, includeInActive ?? true, includeDeleted ?? false);
            if (materials == null)
            {
                _logger.LogInformation("No materials found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No material found.");
            }

            System.Console.WriteLine("materials: " + materials);

            var materialDTOs = _mapper.Map<IEnumerable<DestinyLimoServer.DTOs.ResponseDTOs.MaterialTextDTO>>(materials);

            // copy the material_id to id field
            foreach (var materialDTO in materialDTOs)
            {
                materialDTO.id = materialDTO.material_id;
            }

            return APIR.SuccessResponse("Text Material Fetched Successfully.", materialDTOs);
        }

        [HttpGet("video/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetVideoMaterialsAsync(bool? includeInActive = true, bool? includeDeleted = false, bool? isPublic = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            IMaterialRepository<MaterialVideo> _repository = new MaterialRepository<MaterialVideo>(_dapper);

            var materials = await _repository.GetAllMaterials(isPublic ?? false, includeInActive ?? true, includeDeleted ?? false);
            if (materials == null)
            {
                _logger.LogInformation("No materials found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No material found.");
            }

            System.Console.WriteLine("materials: " + materials);

            var materialDTOs = _mapper.Map<IEnumerable<MaterialVideoDTO>>(materials);

            FileUploader fileUploader = new FileUploader(_logger, _configuration);

            // copy the material_id to id field
            foreach (var materialDTO in materialDTOs)
            {
                materialDTO.id = materialDTO.material_id;

                if (materialDTO.url != null && materialDTO.url != "" && materialDTO.url.Contains("http") == false)
                    materialDTO.url = fileUploader.GetFilePathName(UploadFilePaths.TrainingMaterial, materialDTO.url!);
            }

            return APIR.SuccessResponse("Video Material Fetched Successfully.", materialDTOs);
        }

        [HttpGet("mcq/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetMCQMaterialsAsync(bool? includeInActive = true, bool? includeDeleted = false, bool? isPublic = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            IMaterialRepository<MaterialMCQ> _repository = new MaterialRepository<MaterialMCQ>(_dapper);

            var materials = await _repository.GetAllMaterials(isPublic ?? false, includeInActive ?? true, includeDeleted ?? false);
            if (materials == null)
            {
                _logger.LogInformation("No materials found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No material found.");
            }

            System.Console.WriteLine("materials: " + materials);

            var materialDTOs = _mapper.Map<IEnumerable<DestinyLimoServer.DTOs.ResponseDTOs.MaterialMCQDTO>>(materials);

            // copy the material_id to id field
            foreach (var materialDTO in materialDTOs)
            {
                materialDTO.id = materialDTO.material_id;
            }

            return APIR.SuccessResponse("MCQ Material Fetched Successfully.", materialDTOs);
        }

        private async Task<IActionResult> _getMaterialCategoriesAsync(bool? includeInActive = true, bool? includeDeleted = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            IMaterialCategoryRepository _repository = new MaterialCategoryRepository(_dapper);

            var categories = await _repository.GetAllMaterialCategories(includeInActive ?? true, includeDeleted ?? false);
            if (categories == null)
            {
                _logger.LogInformation("No materials found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No material found.");
            }

            System.Console.WriteLine("materials: " + categories);

            var categoryDTOs = _mapper.Map<IEnumerable<MaterialCategoryDTO>>(categories);
            
            return APIR.SuccessResponse("Material Category Fetched Successfully.", categoryDTOs);
        }

        [HttpGet("category/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetMaterialCategoryAsync(bool? includeInActive = true, bool? includeDeleted = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var categoryDTOs = await _getMaterialCategoriesAsync(includeInActive, includeDeleted);
            if (categoryDTOs == null)
            {
                _logger.LogInformation("No materials found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No material found.");
            }

            return categoryDTOs;
        }

        // CUD operations on MaterialText
        [HttpPost("text")]
        public async Task<IActionResult> AddMaterialTextAsync([FromBody] DestinyLimoServer.DTOs.RequestDTOs.MaterialTextDTO materialTextDTO)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var materialText = _mapper.Map<MaterialText>(materialTextDTO);
            materialText.material_type_id = 5;

            // add to material table first
            IBaseRepository<Material> repoMat = new MaterialRepository<Material>(_dapper);
            int newMaterialId = await repoMat.AddAsync(materialText as Material);

            if (newMaterialId == -1)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to add text material");
            }

            materialText.material_id = newMaterialId;
            IBaseRepository<MaterialText> repoMatText = new BaseRepository<MaterialText>(_dapper, "training_material_text", "text_id");
            var result = await repoMatText.AddAsync(materialText, ["material_id", "text"]);

            if (result == -1)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to add text material");
            }

            // get the whole material
            IMaterialRepository<MaterialText> repoMat2 = new MaterialRepository<MaterialText>(_dapper);
            var newMaterial = await repoMat2.GetMaterialById(newMaterialId);
            if (newMaterial == null)
            {
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "Added material not found.");
            }

            var materialDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.MaterialTextDTO>(newMaterial);

            return APIR.SuccessResponse("Text Material Added Successfully.", materialDTO);
        }

        // update material text
        [HttpPut("text")]
        public async Task<IActionResult> UpdateMaterialTextAsync([FromBody] DestinyLimoServer.DTOs.RequestDTOs.MaterialTextDTO materialTextDTO)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var materialText = _mapper.Map<MaterialText>(materialTextDTO);

            // update material table first
            IBaseRepository<Material> repoMat = new MaterialRepository<Material>(_dapper);
            var result = await repoMat.UpdateAsync(materialText as Material, materialText.material_id);

            if (result == false)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to update material");
            }

            IBaseRepository<MaterialText> repoMatText = new BaseRepository<MaterialText>(_dapper, "training_material_text", "text_id");
            result = await repoMatText.UpdateAsync(materialText, materialText.text_id, ["material_id", "text"]);

            if (result == false)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to update material text");
            }

            // get the whole material
            IMaterialRepository<MaterialText> repoMat2 = new MaterialRepository<MaterialText>(_dapper);
            var newMaterial = await repoMat2.GetMaterialById(materialText.material_id);
            if (newMaterial == null)
            {
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "Updated material not found.");
            }

            var materialDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.MaterialTextDTO>(newMaterial);

            return APIR.SuccessResponse("Text Material Updated Successfully.", materialDTO);
        }

        // detele material text
        [HttpDelete("text/{materialId}")]
        public async Task<IActionResult> DeleteMaterialTextAsync(int materialId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            IBaseRepository<Material> repoMat = new MaterialRepository<Material>(_dapper);
            var result = await repoMat.DeleteSoftAsync(materialId);

            if (result == false)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to delete material");
            }

            return APIR.SuccessResponse("Text Material Deleted Successfully.");
        }

        [HttpPost("mcq")]
        public async Task<IActionResult> AddMaterialMCQAsync([FromBody] DestinyLimoServer.DTOs.RequestDTOs.MaterialMCQDTO materialMCQDTO)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var materialMCQ = _mapper.Map<MaterialMCQ>(materialMCQDTO);
            materialMCQ.material_type_id = 4;

            // add to material table first
            IBaseRepository<Material> repoMat = new MaterialRepository<Material>(_dapper);
            int newMaterialId = await repoMat.AddAsync(materialMCQ as Material);

            if (newMaterialId == -1)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to add material");
            }

            materialMCQ.material_id = newMaterialId;
            IBaseRepository<MaterialMCQ> repoMatMCQ = new BaseRepository<MaterialMCQ>(_dapper, "training_material_mcqs", "question_id");
            var fieldNames = new string[] { "material_id", "question_text", "answer_1", "answer_2", "answer_3", "answer_4", "correct_1", "correct_2", "correct_3", "correct_4" };
            var result = await repoMatMCQ.AddAsync(materialMCQ, fieldNames);

            if (result == -1)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to add material mcq");
            }

            // get the whole material
            IMaterialRepository<MaterialMCQ> repoMat2 = new MaterialRepository<MaterialMCQ>(_dapper);
            var newMaterial = await repoMat2.GetMaterialById(newMaterialId);
            if (newMaterial == null)
            {
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "Added MCQ not found.");
            }   

            var materialDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.MaterialMCQDTO>(newMaterial);

            return APIR.SuccessResponse("MCQ Material Added Successfully.", materialDTO);
        }

        // update material mcq
        [HttpPut("mcq")]
        public async Task<IActionResult> UpdateMaterialMCQAsync([FromBody] DestinyLimoServer.DTOs.RequestDTOs.MaterialMCQDTO materialMCQDTO)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var materialMCQ = _mapper.Map<MaterialMCQ>(materialMCQDTO);

            // update material table first
            IBaseRepository<Material> repoMat = new MaterialRepository<Material>(_dapper);
            var result = await repoMat.UpdateAsync(materialMCQ as Material, materialMCQ.material_id);

            if (result == false)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to update material");
            }

            IBaseRepository<MaterialMCQ> repoMatMCQ = new BaseRepository<MaterialMCQ>(_dapper, "training_material_mcqs", "question_id");
            var fieldNames = new string[] { "material_id", "question_id", "question_text", "answer_1", "answer_2", "answer_3", "answer_4", "correct_1", "correct_2", "correct_3", "correct_4" };
            result = await repoMatMCQ.UpdateAsync(materialMCQ, materialMCQ.question_id, fieldNames);

            if (result == false)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to update material mcq");
            }

            // get the whole material
            IMaterialRepository<MaterialMCQ> repoMat2 = new MaterialRepository<MaterialMCQ>(_dapper);
            var newMaterial = await repoMat2.GetMaterialById(materialMCQ.material_id);
            if (newMaterial == null)
            {
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "Updated MCQ not found.");
            }

            var materialDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.MaterialMCQDTO>(newMaterial);

            return APIR.SuccessResponse("MCQ Material Updated Successfully.", materialDTO);
        }

        // detele material mcq
        [HttpDelete("mcq/{materialId}")]
        public async Task<IActionResult> DeleteMaterialMCQAsync(int materialId)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            IBaseRepository<Material> repoMat = new MaterialRepository<Material>(_dapper);
            var result = await repoMat.DeleteSoftAsync(materialId);

            if (result == false)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Failed to delete material");
            }

            return APIR.SuccessResponse("MCQ Material Deleted Successfully.");
        }

    }
}


