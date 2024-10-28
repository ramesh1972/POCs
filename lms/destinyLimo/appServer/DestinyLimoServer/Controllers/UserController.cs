using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DestinyLimoServer.Repositories;
using Microsoft.AspNetCore.Mvc;
using AutoMapper; // Add this line to import the IMapper interface
using DestinyLimoServer.DTOs.RequestDTOs;
using DestinyLimoServer.DTOs.ResponseDTOs;
using DestinyLimoServer.Models;
using Org.BouncyCastle.Crypto.Prng;
using DestinyLimoServer.Common.Uploader;
using Newtonsoft.Json;
using System.Net;

// alias this to APIR
using APIR = DestinyLimoServer.Common.ApiResponse.ApiResponse;

namespace DestinyLimoServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController(IRepositoryManager repository, IMapper mapper, ILogger logger, IConfiguration configuration) : ControllerBase
    {
        private readonly IRepositoryManager _repository = repository;
        private readonly IMapper _mapper = mapper;
        private readonly ILogger _logger = logger;
        private readonly IConfiguration _configuration = configuration;

        public class ApiResponse<T>
        {
            public bool? Success { get; set; }
            public string? Message { get; set; }
            public T? Data { get; set; }
        }

        [HttpPost("authenticate")]
        public async Task<IActionResult> authenicateUser([FromBody] UserLoginDTO loginDTO)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            User user = await _repository.User.AuthenticateUser(loginDTO.Username, loginDTO.Password);
            if (user == null)
            {
                _logger.LogInformation("User with username: {username} is not found", loginDTO.Username);
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Invalid username or password");
            }
            else
            {
                var userDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserDTO>(user);

                var userRoles = await _repository.Role.GetUserRoles(user.user_id ?? -1);
                var userRolesDTO = _mapper.Map<IEnumerable<DTOs.ResponseDTOs.UserRoleDTO>>(userRoles);
                userDTO.Roles = userRolesDTO;

                var userProfile = await _repository.UserProfile.GetUserById(user.user_id ?? -1);
                userDTO.UserProfile = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserProfileDTO>(userProfile);

                if (userDTO.IsLocked)
                {
                    return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Account is locked", userDTO);
                }
                else if (!userDTO.IsApproved)
                {
                    return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Account not approved", userDTO);
                }

                return APIR.SuccessResponse("User authenticated successfully", userDTO);
            }
        }

        [HttpPost("approveReject")]
        public async Task<IActionResult> ApproveUser([FromBody] ApproveRejectDTO approveRejectDTO)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            User user = await _repository.User.GetUserById(approveRejectDTO.UserId);
            if (user == null)
            {
                _logger.LogInformation("User with id: {id} is not found", approveRejectDTO.UserId);
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "User not found");
            }

            var result = await _repository.User.ApproveRejectUser(approveRejectDTO.UserId, approveRejectDTO.IsApproved, approveRejectDTO.ApproveRejectReason, approveRejectDTO.ApprovedRejectedBy);
            if (result == null)
            {
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Unable to approve user");
            }

            return APIR.SuccessResponse("User approved successfully", result);
        }

        [HttpPost("lockUser")]
        public async Task<IActionResult> LockUser([FromBody] LockUnlockUserDTO userDTO)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            User user = await _repository.User.GetUserById(userDTO.UserId);
            if (user == null)
            {
                _logger.LogInformation("User with id: {id} is not found", userDTO.UserId);
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "User not found");
            }

            User user1 = await _repository.User.LockUser(userDTO.UserId, userDTO.IsLocked);
            if (user1 == null)
            {
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Unable to lock user");
            }

            return APIR.SuccessResponse("User locked successfully");
        }


        [HttpPost("resetPassword")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordDTO resetPassword)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            User user = await _repository.User.GetUserByUsername(resetPassword.Username);
            if (user == null)
            {
                _logger.LogInformation("User with username: {username} is not found", resetPassword.Username);
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Invalid username");
            }

            var userDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserDTO>(user);
            if (userDTO.IsLocked)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Account is locked", userDTO);
            }
            else if (!userDTO.IsApproved)
            {
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "Account not approved", userDTO);
            }

            await _repository.User.ResetPassword(user.user_id ?? -1, resetPassword.NewPassword);

            return APIR.SuccessResponse("Password reset successfully. Login with your new password");
        }

        [HttpGet("{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetUsersAsync(bool? includeInActive = true, bool? includeDeleted = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var users = await _repository.User.GetUsers(includeInActive ?? true, includeDeleted ?? false);
            System.Console.WriteLine("Users: " + users);
            if (users == null)
            {
                _logger.LogInformation("No Users found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No Users found.");
            }

            var usersDto = _mapper.Map<IEnumerable<DestinyLimoServer.DTOs.ResponseDTOs.UserDTO>>(users);

            // get all the profiles
            var userProfiles = await _repository.UserProfile.GetUsers(includeInActive ?? true, includeDeleted ?? false);
            if (userProfiles == null)
            {
                _logger.LogInformation("No UserProfiles found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No UserProfiles found.");
            }

            if (usersDto.Count() != userProfiles.Count())
            {
                _logger.LogInformation("Users and UserProfiles count mismatch");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "Users and UserProfiles count mismatch");
            }

            // get all the roles
            var rolesList = await _repository.Role.GetRoles();
            var userRolesList = await _repository.Role.GetAllUsersRoles();

            // map the userDTO to the userProfiles, roles and userRoles
            foreach (var userDto in usersDto)
            {
                var userProfile = userProfiles.FirstOrDefault(x => x.user_id == userDto.UserId);
                if (userProfile != null)
                {
                    userDto.UserProfile = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserProfileDTO>(userProfile);
                }

                var userRoles = userRolesList.Where(x => x.user_id == userDto.UserId);
                if (userRoles != null)
                {
                    var rolesDTO = _mapper.Map<IEnumerable<DTOs.ResponseDTOs.UserRoleDTO>>(userRoles);
                    userDto.Roles = rolesDTO;
                }
            }

            // get only the drivers 
            // TODO: make it more generic for any role
            int driverRoleId = 2;
            usersDto = usersDto.Where(x => x.Roles!.Any(y => y.role_id == driverRoleId));
            return APIR.SuccessResponse("Users Fetched Successfully.", usersDto);
        }

        [HttpGet("profile/{includeInActive?}/{includeDeleted?}")]
        public async Task<IActionResult> GetUsersProfilesAsync(bool? includeInActive = true, bool? includeDeleted = false)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var users = await _repository.UserProfile.GetUsers(includeInActive ?? true, includeDeleted ?? false);
            System.Console.WriteLine("Users: " + users);
            if (users == null)
            {
                _logger.LogInformation("No Users found.");
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "No Users found.");
            }

            var userDto = _mapper.Map<IEnumerable<DestinyLimoServer.DTOs.ResponseDTOs.UserProfileDTO>>(users);
            return APIR.SuccessResponse("Users Fetched Successfully.", userDto);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetUserAsync(int id)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var user = await _repository.User.GetUserById(id);
            if (user == null)
            {
                _logger.LogInformation("User with id: {id} doesn't exist in the database.", id);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "User not found");   
            }
            else
            {
                var userDto = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserDTO>(user);
                return APIR.SuccessResponse("User Fetched Successfully.", userDto);
            }
        }

        [HttpGet("profile/{id}")]
        public async Task<IActionResult> GetUserProfileAsync(int id)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var user = await _repository.User.GetUserById(id);
            if (user == null)
            {
                _logger.LogInformation("User with id: {id} doesn't exist in the database.", id);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "User not found");
            }
            else
            {
                var userDto = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserProfileDTO>(user);
                return APIR.SuccessResponse("User Fetched Successfully.", userDto);
            }
        }

        [HttpPost]
        async public Task<IActionResult> CreateUserAsync([FromForm] DestinyLimoServer.DTOs.RequestDTOs.UserDTOJsonString userJSON)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            DTOs.RequestDTOs.UserDTO user = JsonConvert.DeserializeObject<DTOs.RequestDTOs.UserDTO>(userJSON.user)!;

            if (user == null)
            {
                _logger.LogError("UserForCreationDto object sent from client is null.");
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "invalid user info in request");
            }

            // inputs to register
            var userEntity = _mapper.Map<User>(user);

            var userProfile = user.UserProfile;
            var userProfileEntity = _mapper.Map<UserProfile>(userProfile);

            // Handle avatar file
            var avatar = HttpContext.Request.Form.Files[0];
            if (avatar != null && avatar.Length > 0)
            {
                FileUploader fileUploader = new FileUploader(_logger, _configuration);
                await fileUploader.UploadFileAsync(avatar, UploadFilePaths.ProfilePicture);
            }

            // extract the avatar file name
            userProfileEntity.avatar = Path.GetFileName(userProfileEntity.avatar) ?? "default-avatar.png";

            // register
            User? newUser = await _repository.User.RegisterUser(userEntity, userProfileEntity);
            if (newUser == null)
            {
                _logger.LogError("Unable to register user");
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Unable to register user");
            }

            // set output
            UserProfile newUserProfile = await _repository.UserProfile.GetUserById(newUser.user_id ?? -1);

            IEnumerable<UserRole> userRoles = await _repository.Role.GetUserRoles(newUser.user_id ?? -1);

            DestinyLimoServer.DTOs.ResponseDTOs.UserDTO userDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserDTO>(newUser);
            userDTO.UserProfile = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserProfileDTO>(newUserProfile);
            userDTO.Roles = _mapper.Map<IEnumerable<DestinyLimoServer.DTOs.ResponseDTOs.UserRoleDTO>>(userRoles);

            return APIR.SuccessResponse("User registered successfully", userDTO);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserAsync(int id)
        {
            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            var user = _repository.User.GetUserById(id);
            if (user == null)
            {
                _logger.LogInformation("User with id: {id} doesn't exist in the database.", id);
                return APIR.ErrorResponse(HttpStatusCode.NotFound, "User not found");
            }

            await _repository.User.DeleteUser(id);
            var result = await _repository.UserProfile.DeleteAsync(id);
            if (!result)
            {
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Unable to delete user profile");
            }

            return APIR.SuccessResponse("User deleted successfully");
        }

        [HttpPut()]
        async public Task<IActionResult> UpdateUserAsync([FromForm] DestinyLimoServer.DTOs.RequestDTOs.UserDTOJsonString userJSON)
        {
            DTOs.RequestDTOs.UserDTO user = JsonConvert.DeserializeObject<DTOs.RequestDTOs.UserDTO>(userJSON.user)!;

            if (user == null)
            {
                _logger.LogError("UserForUpdateDto object sent from client is null.");
                return APIR.ErrorResponse(HttpStatusCode.BadRequest, "invalid user info in request");
            }

            if (!ModelState.IsValid)
            {
                _logger.LogError("Invalid model state");
                return APIR.ErrorResponse(HttpStatusCode.UnprocessableContent, "Invalid model state");
            }

            User userEntity = _mapper.Map<User>(user);
            var result = await _repository.User.UpdateUser(userEntity);
            if (result == null)
            {
                return APIR.ErrorResponse(HttpStatusCode.InternalServerError, "Unable to update user");
            }

            var userProfile = user.UserProfile;

            if (userProfile != null)
            {
                if (HttpContext.Request.Form.Files.Count > 0)
                {
                    var avatar = HttpContext.Request.Form.Files[0];
                    if (avatar != null && avatar.Length > 0)
                    {
                        FileUploader fileUploader = new FileUploader(_logger, _configuration);
                        await fileUploader.UploadFileAsync(avatar, UploadFilePaths.ProfilePicture);
                    }
                }

                userProfile.UserId = userEntity.user_id;
                var userProfileEntity = _mapper.Map<UserProfile>(userProfile);
                await _repository.UserProfile.UpdateAsync(userProfileEntity, userEntity.user_id ?? -1);

                var userResponseDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserDTO>(userEntity);

                var userProfileResponseDTO = _mapper.Map<DestinyLimoServer.DTOs.ResponseDTOs.UserProfileDTO>(userProfileEntity);
                userResponseDTO.UserProfile = userProfileResponseDTO;

                // get the roles
                var userRoles = await _repository.Role.GetUserRoles(userEntity.user_id ?? -1);
                var userRolesDTO = _mapper.Map<IEnumerable<DTOs.ResponseDTOs.UserRoleDTO>>(userRoles);
                userResponseDTO.Roles = userRolesDTO;

                return APIR.SuccessResponse("User updated successfully", userResponseDTO);
            }

            return BadRequest("User profile is required");
        }
    }
}


