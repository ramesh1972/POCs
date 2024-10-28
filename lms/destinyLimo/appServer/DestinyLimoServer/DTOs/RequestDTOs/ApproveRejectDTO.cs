namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class ApproveRejectDTO
    {
        public required int UserId { get; set; }
        public required bool IsApproved { get; set; }
        public string? ApproveRejectReason { get; set; }
        public int ApprovedRejectedBy { get; set; }
    }
}