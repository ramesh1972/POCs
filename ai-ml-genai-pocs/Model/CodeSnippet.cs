namespace ContentCreation.Models
{
    public class CodeSnippet : ContentItem
    {
        public string Code;
    }

    public override string GetHTML() 
    {
        string codeHTML = "<code>" + Code + "<\code>";

           if (SectionTitle != "")
            codeHTML = "<h4>" + SectionTitle + "\h4>" + codeHTML;

        return codeHTML;
    }
}