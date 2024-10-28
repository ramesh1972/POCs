namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class LockUnlockUserDTO
    {
        public required int UserId { get; set; }
        public required bool IsLocked { get; set; }
    }
}