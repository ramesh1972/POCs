using DestinyLimoServer.DTOs.ResponseDTOs;

namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class UserLoginDTO
    {
        public required string Username { get; set; }
        public required string Password { get; set; }
    }
}
