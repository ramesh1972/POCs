namespace ContentCreation.Models
{
    public class Paragraph : ContentItem
    {
        public string Text;
    }

    public override string GetHTML() 
    {
        string paraHTML = "<p>" + Text + "<\p>";

        if (SectionTitle != "")
            paraHTML = "<h4>" + SectionTitle + "\h4>" + paraHTML;

        return paraHTML;
    }
}