namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class UserRoleDTO
    {
        public int user_role_id { get; set; }

        public int user_id { get; set; }

        public int role_id { get; set; }

        public string? role_name { get; set; }

        public DateTime? created_at  { get; set; }
        public DateTime? updated_at { get; set; }
    }
}