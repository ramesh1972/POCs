namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class UserProfileDTO
    {
        public int? ProfileId { get; set; }           // Maps to `profile_id`
        public int? UserId { get; set; }              // Maps to `user_id`
        public required string FirstName { get; set; }        // Maps to `first_name`
        public string? LastName { get; set; }         // Maps to `last_name`
        public string? Avatar { get; set; }           // Maps to `avatar` (BLOB data type)
        public string? Address { get; set; }          // Maps to `address`
        public string? PhoneNumber { get; set; }      // Maps to `phone_number`
        public DateTime? Dob { get; set; }           // Maps to `dob` (nullable DateTime)
        public string? LicenseNumber { get; set; }    // Maps to `license_number`
        public DateTime? LicenseIssueDate { get; set; } // Maps to `license_issue_date` (nullable DateTime)
        public DateTime? LicenseExpiryDate { get; set; } // Maps to `license_expiry_date` (nullable DateTime)
    }
}