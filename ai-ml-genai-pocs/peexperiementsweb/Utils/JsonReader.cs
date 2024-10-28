using Newtonsoft.Json;
using System.IO;

namespace PEExperimentsWeb.Utils
{
    public class JsonReader
    {
        // e.g.
        // JsonReader.ReadJsonFile<ReviewData>("review.json");
        // JsonReader.ReadJsonFile<Sentiment>("sentiment.json")
        
        public static List<T> ReadJsonFile<T>(string filePath)
        {
            string? jsonContent = File.ReadAllText(filePath);
            if (jsonContent != null)
            {
                return JsonConvert.DeserializeObject <List<T>>(jsonContent);
            }

            return default(List<T>);
        }

        
        public static T? ReadJsonString<T>(string jsonString)
        {
            if (jsonString != null)
            {
                return JsonConvert.DeserializeObject<T>(jsonString);
            }

            return default(T);
        }
    }
}

