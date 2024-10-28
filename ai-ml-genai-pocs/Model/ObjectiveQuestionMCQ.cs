namespace ContentCreation.Models
{
    public class ObjectiveQuestionMCQ : ContentItem
    {
        public string Question;
        public List<string> Choices;

        public List<int> RightChoices;
    }

    public override string GetHTML() 
    {
       // TODO: build your HTML layout and return
       return "";
    }
}