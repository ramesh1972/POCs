namespace ContentCreation.Models
{
    public class BulletList : ContentItem
    {
        public List<string> ListItems;
    }

    public override string GetHTML() 
    {
        string listHTML = "<ul>">";

        if (ListItems != null)
        {
            foreach(string listItem in ListItems)
                listHTML = "<li>" + listHTML + "<\li>";
        }

        listHTML+= "<\ul>";

        return listHTML;
    }
}