namespace DestinyLimoServer.Models
{
    public class MaterialMCQ : Material
    {
        public int question_id { get; set; }
        public string? question_text { get; set; }
        public string? answer_1 { get; set; }
        public string? answer_2 { get; set; }
        public string? answer_3 { get; set; }
        public string? answer_4 { get; set; }
        public bool correct_1 { get; set; } = false;
        public bool correct_2 { get; set; } = false;
        public bool correct_3 { get; set; } = false;
        public bool correct_4 { get; set; } = false;
    }
}