using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using ContentCreation.Models;
using ContentCreation.Utils;
using System.Collections.Generic;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ContentCreation.Pages;

public class Lahari_ContentModel : PageModel
{
    public List<Lahari_Content> content { get; set; } = new List<Lahari_Content>(); 
    public Lahari_Content contents { get; set; }
        public string SystemPrompt { get; set; }
        public string AssistantPrompt { get; set; }
        public string AssistantPrompt2 { get; set; }
        public string Response { get; set; }
        public string MCQResponse { get; set; }
        public DeserializedContent deserializedContent { get; set; }
        public BlogModel blog {get; set;}

        //public dynamic DynamicJsonData { get; set; }

   // private  JsonReader _Json;
    private  ChatGPT _chatGPT;
    private readonly ILogger<Lahari_ContentModel> _logger;

    public Lahari_ContentModel(ILogger<Lahari_ContentModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
    public async Task OnPostAsync(Lahari_Content contents)
        {
            string action = Request.Form["action"];
        if (action == "GenerateContent" || action == "ReGenerate")
        {
           //SystemPrompt = "You are a virtual agent that helps users to generate Json format content that contains blog for the given software topics, only provide Json data don't mention any other content like sure";
           //AssistantPrompt = @"determine the blog that contains few lines paragraphs, sample bullet points and relavent code ,
                              //   and format like Title,Sections[type: ,Text:], for type BulletPoint mention content without square brace,
                               // mention the content type at start like Title, Paragraph, BulletPoint, code and the content type should be only Title or Paragraph or BulletPoint or Code .";
           SystemPrompt = "You are a virtual agent that helps users to create blogs for the given  software topics";
           AssistantPrompt = "determine the blog with a simple paragraph , sample bullet lists and relavent code .";
           AssistantPrompt2="give us 3 questions on the given topic, in that questions 1 should me MCQ and 2 should be true/false give output in json format and mention the question type also at starting";
            string userPrompt = contents.UserInput;
            // Combine the system and assistant prompts
           string combinedPrompt = SystemPrompt + "\n"+userPrompt +"\n"+AssistantPrompt ;
            
            string combinedPrompt2=SystemPrompt+"\n"+userPrompt +"\n"+AssistantPrompt2;
            // Call ChatGPT to generate a response
            _chatGPT = new ChatGPT();
            string content = await _chatGPT.ChatCompletionsAsync(SystemPrompt, combinedPrompt);
            content = content.Replace("\"", " ");
            Response = System.Text.RegularExpressions.Regex.Replace(content, @"(({|})|Title:|Introduction:|Conclusion:|\d+\.)|\s-\s|\n|\n\n", "<br>$0 ");
            //content = content.Replace("\"", " ").Replace("{", "").Replace("}", "").Replace("[", "").Replace("]", "").Replace(";", "");
           // Response=content;

            //_logger.LogInformation($"Content JSON: {content}");

             //blog = JsonConvert.DeserializeObject<BlogModel>(content);
           //var Sections = blog.Sections;
            //return View("DisplayBlog", blog);



            string content2 = await _chatGPT.ChatCompletionsAsync(SystemPrompt, combinedPrompt2);
            MCQResponse=content2;
            
             deserializedContent = JsonConvert.DeserializeObject<DeserializedContent>(content2);

            // You can access the deserialized data as needed
            var questions = deserializedContent.questions;
        }
        
        }
}

 public class DeserializedContent
    {
        public List<Question> questions { get; set; }
    }

    public class Question
    {
        public string type { get; set; }
        public string question { get; set; }
        public List<string> options { get; set; }
        public object answer { get; set; }
    }







