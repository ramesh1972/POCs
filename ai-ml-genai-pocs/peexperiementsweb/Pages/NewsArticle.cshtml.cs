using Microsoft.AspNetCore.Mvc.RazorPages;
using PEExperimentsWeb.Models;
using PEExperimentsWeb.Utils;
using System.Collections.Generic;
using System.Threading.Tasks;


namespace PEExperimentsWeb.Pages
{
    public class ExtractNewsModel : PageModel
    {
        public List<NewsArticle> NewsArticles { get; set; } = new List<NewsArticle>();
        public NewsArticle newsArticle { get; set; }
        public string SystemPrompt { get; set; }
        public string AssistantPrompt { get; set; }
        public string Response { get; set; }

        private  ChatGPT _chatGPT;
        private readonly ILogger<ExtractNewsModel> _logger;

    public ExtractNewsModel(ILogger<ExtractNewsModel> logger)
    {
        _logger = logger;
    }
        

        public void OnGet()
        {

      //  SystemPrompt = "Determine five topics in the following text, Make each item one or two words long.";
     //   AssistantPrompt = "Determine whether each item in the following list of topics is a topic in the text below";
        }

        public async Task OnPostAsync(NewsArticle newsArticle)
        {
           SystemPrompt = "Determine five topics only in the following text, No other content,Make each item one or two words long";
           AssistantPrompt = "after printing the five topics line by line - tell weather it's releated to nasa or not  ";

            string userPrompt = newsArticle.Article;

            // Combine the system and assistant prompts
           string combinedPrompt = SystemPrompt + "\n"+userPrompt+"\n"+AssistantPrompt ;

            // Call ChatGPT to generate a response
            _chatGPT = new ChatGPT();
            string response = await _chatGPT.ChatCompletionsAsync(SystemPrompt, combinedPrompt);
            Response = response;
            NewsArticles.Add(newsArticle);
         //   newsArticle.Article = string.Empty;
            newsArticle = new NewsArticle();
        }
    }
}
