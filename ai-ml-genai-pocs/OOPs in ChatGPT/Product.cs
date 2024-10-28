class Product 
{
    public string Item;
    public string Company;

    void Parse(string productStr)
    {
        string parts[2] = productStr.Spit("":");
        // get Item out of productStr
        Item = parts[0];

        // get COmpany of productStr
        Company = parts[1];

        // or if JSON
        Product p = JsonConvert(Json.Deserialize(productStr))
    }

    void PrintProduct()
    {
        Console.WriteLine("Item =  {Item}");
        Console.WriteLine("company = {Company}")
    }
}