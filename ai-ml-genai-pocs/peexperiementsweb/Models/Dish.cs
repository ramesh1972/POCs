using System.ComponentModel.DataAnnotations;

namespace PEExperimentsWeb.Models
{
    public class Dish
    {
        public int Id { get; set; }

        [Required]
        public string? Name { get; set; }

        [Range(0.01, 9999.99)]
        public decimal Price { get; set; }

        [Range(0.01, 20)]
        public decimal Discount { get; set; }

        public string? ImagePathAndFile {get; set;}

        public bool IsAvailable {get; set;}
    }
}
