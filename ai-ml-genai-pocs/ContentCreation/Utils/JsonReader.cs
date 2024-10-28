using Newtonsoft.Json;
using System.IO;

namespace ContentCreation.Utils
{
    public class JsonReader
    {
        // e.g.
        // JsonReader.ReadJsonFile<ReviewData>("review.json");
        // JsonReader.ReadJsonFile<Sentiment>("sentiment.json");
        
        public static T? ReadJsonFile<T>(string filePath)
        {
            string? jsonContent = File.ReadAllText(filePath);
            if (jsonContent != null)
            {
                return JsonConvert.DeserializeObject<T>(jsonContent);
            }

            return default(T);
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

