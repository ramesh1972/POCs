using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PEExperimentsWeb.Models;
using PEExperimentsWeb.Utils;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PEExperimentsWeb.Pages;

public class ExtractProductModel : PageModel
{
    public List<Product> Prd { get; set; } = new List<Product>(); 
    public Product product { get; set; }
        public string SystemPrompt { get; set; }
        public string AssistantPrompt { get; set; }
        public string Response { get; set; }



    private  ChatGPT _chatGPT;
    private readonly ILogger<ExtractProductModel> _logger;

    public ExtractProductModel(ILogger<ExtractProductModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
    public async Task OnPostAsync(Product product)
        {
           SystemPrompt = "You are a virtual agent that helps users to extract Information of Item purchased by reviewerm and Company that made the item from the given reviews";
           
 
           AssistantPrompt = $"determine the Item and Company details in Json format ";
 
            string userPrompt = product.Review;
 
            // Combine the system and assistant prompts
           string combinedPrompt = SystemPrompt + "\n"+userPrompt +"\n"+AssistantPrompt ;
 
            // Call ChatGPT to generate a response
            _chatGPT = new ChatGPT();
            string response = await _chatGPT.ChatCompletionsAsync(SystemPrompt, combinedPrompt);
            Response = response;

            Prd.Add(product);
            product = new Product();
        }


    
}
