using Microsoft.AspNetCore.Mvc.RazorPages;
using PEExperimentsWeb.Models;
using PEExperimentsWeb.Pages;
using System.Collections.Generic;
using System.Threading.Tasks;
 
 
namespace PEExperimentsWeb.Pages
{
    public class GenModel : PageModel
    {
        public List<Gen> NewsArticles { get; set; } = new List<Gen>();
        public Gen newsArticle { get; set; }
        public string SystemPrompt { get; set; }
        public string AssistantPrompt { get; set; }
        public string Response { get; set; }
 
        private  ChatGPT _chatGPT;
        private readonly ILogger<GenModel> _logger;
 
    public GenModel(ILogger<GenModel> logger)
    {
        _logger = logger;
    }

 
        public void OnGet()
        {
 
      //  SystemPrompt = "Determine five topics in the following text, Make each item one or two words long.";
     //   AssistantPrompt = "Determine whether each item in the following list of topics is a topic in the text below";
        }
 
        public async Task OnPostAsync(Gen newsArticle)
        {
           SystemPrompt = "Determine five topics only in the following text, No other content,Make each item one or two words long";
           AssistantPrompt = "after printing the five topics - print 1 if it is releated to nasa or print 0 ";
 
            string userPrompt = Gen.Description;
 
            // Combine the system and assistant prompts
           string combinedPrompt = SystemPrompt + "\n"+userPrompt+"\n"+AssistantPrompt ;
 
            // Call ChatGPT to generate a response
            _chatGPT = new ChatGPT();
            string response = await _chatGPT.ChatCompletionsAsync(SystemPrompt, combinedPrompt);
            Response = response;
            Gen.Add(newsArticle);
         //   newsArticle.Article = string.Empty;
            newsArticle = new Gen();
        }
    }
}