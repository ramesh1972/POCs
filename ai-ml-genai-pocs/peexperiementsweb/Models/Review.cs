using System.ComponentModel.DataAnnotations;

namespace PEExperimentsWeb.Models
{
    public class Review
    {   
        public int? review_id { get; set; }

        public string? book_title { get; set; }
        
        public string? author { get; set; }

        public int? rating { get; set; }

        public string? ReviewText { get; set; }

        public string? Sentiment {get; set;}

    }
}