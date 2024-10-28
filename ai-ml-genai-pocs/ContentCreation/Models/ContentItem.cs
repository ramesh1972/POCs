using System.ComponentModel.DataAnnotations;

namespace ContentCreation.Models
{
    public class ContentItem
{
    public string Title { get; set; }
    public string Introduction { get; set; }
    public List<string> BulletPoints { get; set; }
    public string Code { get; set; }
    public string Conclusion { get; set; }
    // Add other properties as needed
}

}