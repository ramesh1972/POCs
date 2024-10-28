namespace DestinyLimoServer.Models
{
    public class UserProfile
    {
        public int? profile_id { get; set; }            // Maps to `profile_id`
        public int? user_id { get; set; }               // Maps to `user_id`
        public required string first_name { get; set; }         // Maps to `first_name`
        public string? last_name { get; set; }          // Maps to `last_name`
        public string? avatar { get; set; }             // Maps to `avatar`
        public string? address { get; set; }            // Maps to `address`
        public string? phone_number { get; set; }       // Maps to `phone_number`
        public DateTime? dob { get; set; }             // Maps to `dob`
        public string? license_number { get; set; }     // Maps to `license_number`
        public DateTime? license_issue_date { get; set; } // Maps to `license_issue_date`
        public DateTime? license_expiry_date { get; set; } // Maps to `license_expiry_date`
    }
}