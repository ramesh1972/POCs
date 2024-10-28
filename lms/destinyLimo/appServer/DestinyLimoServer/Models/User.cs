namespace DestinyLimoServer.Models
{
    public class User
    {
        public int? user_id { get; set; }

        public required string username { get; set; }

        public string? password_hash { get; set; }

        public string? email { get; set; }

        public bool is_approved { get; set; }

        public int? approved_rejected_by { get; set; }

        public string? approved_rejected_reason { get; set; }

        public DateTime approved_rejected_datetime { get; set; }

        public bool is_locked { get; set; }

        public bool is_deleted { get; set; }

        public DateTime? created_at { get; set; }

        public DateTime? updated_at { get; set; }

        public IEnumerable<Role>? user_roles { get; set; }

        public UserProfile? UserProfile { get; set;}
    }
}