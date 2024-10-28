namespace DestinyLimoServer.Models
{
    public class UserAskedQuestion
    {
        public int user_question_id { get; set; }
        public int user_id { get; set; }          // Represents the 'user_id' column
        public string? asked_question { get; set; } // Represents the 'asked_question' column
        public int admin_user_id { get; set; }     // Represents the 'admin_user_id' column
        public string? admin_answer { get; set; }  // Represents the 'admin_answer' column
        public DateTime? date_asked { get; set; }         // Represents the 'date_asked' column
        public DateTime? date_answered { get; set; }      // Represents the 'date_answered' column
        public Boolean is_public { get; set; }       // Represents the 'is_public' column
        public Boolean is_deleted { get; set; }      // Represents the 'is_deleted' column
        public Boolean is_active { get; set; }       // Represents the 'is_active' column
    }
}