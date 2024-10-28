using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PEExperimentsWeb.Models;
using PEExperimentsWeb.Utils;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PEExperimentsWeb.Pages
{
    public class AbProductModel : PageModel
    {
        public List<AbProduct> AbPrds {get; set;} = new List<AbProduct>();
        public AbProduct abProduct { get; set;}
            public string SystemPrompt {get; set;}
            public string Response {get; set;}
            public string AssistantPrompt { get; set;}
    
    
        private ChatGPT _chatGPT;
        private readonly ILogger<AbProductModel> _logger;

        public AbProductModel(ILogger<AbProductModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {

        }

        public async Task OnPostAsync(AbProduct abProduct )
        {
            SystemPrompt = @"you are a virtual agent Identify the following items in the following text:
                            -Sentiment (positive or negative)
                            -Is the reviewer expressing anger? (true or false)
                            - Item purchased by reviewer
                            - Company that mde the item
                            
                            Format your response as a Json object with  
                            sentiment, Anger,Item,Company as keys.";
            AssistantPrompt = $"Determine the sentiment and anger and item and brand details";
            string userPrompt = abProduct.Review;

            string combinedPrompt = SystemPrompt + "\n"+userPrompt +"\n"+AssistantPrompt ;



            // Call ChatGPT to generate a response
            _chatGPT = new ChatGPT();
            string response = await _chatGPT.ChatCompletionsAsync(SystemPrompt, combinedPrompt);
            Response = response;
            AbPrds.Add(abProduct);
            abProduct = new AbProduct();
            

        }
    }
}

