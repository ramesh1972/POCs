namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class UserExamDTO
    {
        public int ExamId { get; set; }
        public int UserId { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateStarted { get; set; }
        public DateTime DateCompleted { get; set; }
        public int Score { get; set; }
        public int Result { get; set; }
        public string? CertificateUrl { get; set; }
        public int num_questions { get; set; }
        public int num_attempted { get; set; }
        public int num_correct { get; set; }
        public int num_wrong { get; set; }
        public int min_correct_answers_for_pass { get; set; }
        public IEnumerable<DestinyLimoServer.DTOs.ResponseDTOs.MaterialMCQDTO>? ExamQuestions { get; set; }
        public IEnumerable<UserExamAnswerDTO>? UserExamAnswers { get; set; }
    }
}
