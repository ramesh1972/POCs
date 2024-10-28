
namespace ContentCreation.Models
{

    public enum ContentItemType { Paragraph, BulletList, CodeSnippet, Quiz_MCQ, Quiz_TrueFalse }

    public class ContentItem
    {
        public int Id;

        public string SectionTitle;

        public ContentItemType ItemType;

        public virtual void GetHTML();
    }
}