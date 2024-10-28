using System.ComponentModel.DataAnnotations;

public class BlogModel
{
    //public string Title { get; set; }
    public List<BlogSection> Sections { get; set; } = new List<BlogSection>();
}

public class BlogSection
{
    public ContentType Type { get; set; }
    public string Text { get; set;}
    public BulletPoint BulletPoints { get; set; } = new BulletPoint();
}

public enum ContentType
{
    Title,
    Paragraph,
    BulletPoint,
    Code
}

public class BulletPoint
{
    public List<string> Points { get; set; } = new List<string>();
}
