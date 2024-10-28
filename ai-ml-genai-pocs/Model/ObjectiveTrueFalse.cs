namespace ContentCreation.Models
{
    public class ObjectiveTrueFalse : ContentItem
    {
        public string Question;

        public int RightAnswer; // 1 or 2
    }

    public override string GetHTML() 
    {
       // TODO: build your HTML layout and return
       return "";
    }
}