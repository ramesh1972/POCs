namespace DestinyLimoServer.Models
{
    public class UserExam
    {
        public int exam_id { get; set; }            // Represents the 'exam_id' column
        public int user_id { get; set; }
        public DateTime date_created { get; set; } // Represents the 'date_created' column
        public DateTime date_started { get; set; }  // Represents the 'date_started' column
        public DateTime date_completed { get; set; } // Represents the 'date_completed' column
        public int score { get; set; }              // Represents the 'score' column
        public int result { get; set; }             // Represents the 'result' column
        public string? certificate_url { get; set; } // Represents the 'certificate_url' column
        public int num_questions { get; set; }
        public int num_attempted { get; set; }
        public int num_correct { get; set; }
        public int num_wrong { get; set; }
        public int min_correct_answers_for_pass { get; set; }
    }
}


