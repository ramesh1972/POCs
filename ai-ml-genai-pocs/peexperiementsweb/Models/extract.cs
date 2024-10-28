using System.ComponentModel.DataAnnotations;

namespace PEExperimentsWeb.Models
{
    public class Extract
    {
        // hlo
        [Required]
        public string? Item { get; set; }

        public string? Company { get; set; }
  
        public string? Review { get; set; }

    }
}