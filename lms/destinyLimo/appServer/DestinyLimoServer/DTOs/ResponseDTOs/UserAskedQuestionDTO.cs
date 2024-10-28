namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class UserAskedQuestionDTO
    {
        public int Id { get; set; }
        public string? Question { get; set; }
        public string? Answer { get; set; }
        public DateTime DateAsked { get; set; }
        public DateTime? DateAnswered { get; set; }
        public int? AnsweredBy { get; set; }
        public int? AskedBy { get; set; }
        public bool is_public { get; set; }
        public bool is_deleted { get; set; }
        public bool is_active { get; set; }
    }
}