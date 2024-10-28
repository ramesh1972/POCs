namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class UserExamAnswerDTO
    {
        public int exam_id { get; set; }  // exam_id
        public int exam_question_id { get; set; }  // exam_question_id
        public int mcq_id { get; set; }  // mcq_id
        public bool choice_1_answer { get; set; }  // choice_1_answer
        public bool choice_2_answer { get; set; }  // choice_2_answer
        public bool choice_3_answer { get; set; }  // choice_3_answer
        public bool choice_4_answer { get; set; }  // choice_4_answer

        public bool attempted { get; set; }
        public bool is_correct { get; set; }
    }
}