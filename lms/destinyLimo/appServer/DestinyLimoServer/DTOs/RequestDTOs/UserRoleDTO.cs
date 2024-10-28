namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class UserRoleDTO
    {
        public int UserRoleId { get; set; }
        public required UserDTO UserDTOObj { get; set; }
        public required RoleDTO RoleDTOObj { get; set; }
    }
}