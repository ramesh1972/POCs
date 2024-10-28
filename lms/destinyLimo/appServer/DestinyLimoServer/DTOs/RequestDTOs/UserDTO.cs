using DestinyLimoServer.DTOs.RequestDTOs;

namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class UserDTO
    {
        public int? UserId { get; set; }
        public required string Username { get; set; }
        public required string Email { get; set; }
        public string? Password { get; set; }

        public bool IsApproved { get; set; }
        public string? ApproveRejectReason { get; set; }
        public int ApprovedByAdminId { get; set; }
        public DateTime? ApprovedAt { get; set; }

        public bool IsLocked { get; set; }
        public bool IsDeleted { get; set; }

        public DateTime CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }

        public UserProfileDTO? UserProfile { get; set; }

        public IEnumerable<RoleDTO>? Roles { get; set; }
    }
}
