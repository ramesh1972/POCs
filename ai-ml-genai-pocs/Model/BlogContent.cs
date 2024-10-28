
namespace ContentCreation.Models
{
    public class BlogContent
    {
        public string BlogTitle;
        
        public List<ContentItem> Contents = new List<ContentItem>();

        public virtual void Display();
    }

    public override string GetBlogHTML() 
    {
        string HTML = "<div>";
        foreach (ContentItem item in Contents)
            HTML += item.GetHTML();

        HTML+= "</div>";

        return HTML

    }
}