namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class ResetPasswordDTO
    {
        public required string Username { get; set; }
        public required string NewPassword { get; set; }
    }
}