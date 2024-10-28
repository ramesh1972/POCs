using System.ComponentModel.DataAnnotations;

namespace ContentCreation.Models
{
    public class Question
    {
        public string type { get; set; }
        public string question { get; set; }
        public List<string> options { get; set; }
        public object answer { get; set; }
    }
}