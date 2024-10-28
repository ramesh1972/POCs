using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Text.Json;
using System.Text.Json.Serialization;
using JsonConvert = Newtonsoft.Json.JsonConvert;

class Program
{
    static readonly HttpClient client = new HttpClient();

    static async Task Main()
    {

        client.DefaultRequestHeaders.Add("Authorization", "Bearer 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");

        var response = await client.GetAsync("https://api.openai.com/v1/models");

        var responseString = await response.Content.ReadAsStringAsync();

        Console.WriteLine(responseString);
    }
}