using Microsoft.AspNetCore.Mvc.RazorPages;
using PEExperimentsWeb.Models;
using PEExperimentsWeb.Utils;
using System.Collections.Generic;
using System.Threading.Tasks;
//
namespace PEExperimentsWeb.Pages
{

    public class SentimentIndexModel : PageModel
    {
        private readonly ILogger<SentimentIndexModel> _logger;

        public SentimentIndexModel(ILogger<SentimentIndexModel> logger)
        {
            _logger = logger;
        }

        public List<Review> Books { get; set; } = default!;

        public Review sentimentReview { get; set; }

        public string SystemPrompt { get; set; }
        public string AssistantPrompt { get; set; }
        public string Response { get; set; }

        private  ChatGPT _chatGPT;

        public async Task OnGetAsync()
        {
            _chatGPT = new ChatGPT();

            await Task.Run(() => displaydata());

            SystemPrompt = "";
            AssistantPrompt = "sentimentReview.ReviewText";

        }

        private void displaydata()
        {
            
           Books = JsonReader.ReadJsonFile<Review>("./wwwroot/data/books.json");
           


            /*
            Books.Add(new Review() {review_id=1, book_title="The Great Gatsby", author="F. Scott Fitzgerald", rating=5, ReviewText="A timeless classic! The story of Jay Gatsby is both tragic and captivating. Fitzgerald's writing is brilliant.", Sentiment="positive"});
            Books.Add(new Review() {review_id=2, book_title="To Kill a Mockingbird", author="Harper Lee", rating=4, ReviewText="This book addresses important social issues and has memorable characters. A must-read", Sentiment="positive"});
            Books.Add(new Review() {review_id=3, book_title="1984", author="George Orwell", rating=5, ReviewText="A dystopian masterpiece that remains relevant today. Orwell's vision of the future is chilling.", Sentiment="positive"});
            Books.Add(new Review() {review_id=4, book_title="The Catcher in the Rye", author="J.D. Salinger", rating=3, ReviewText="Holden Caulfield's journey is a bit worse in my opinion, but it's not so good for a reason.", Sentiment="negative"});
            Books.Add(new Review() {review_id=5, book_title="The Hunger Games", author="Suzanne Collins", rating=4, ReviewText="A thrilling dystopian adventure featuring a strong and resourceful heroine.", Sentiment="positive"});
        */
        }

        public async Task OnPostAsync(Review sentimentReview)
        {
            SystemPrompt = "You are a Sentiment Reviewer and you need to give Sentiment reviews on the Book";
            AssistantPrompt = "Determine whether each books columns and Sentiment is displayed properly.";
 
            string userPrompt = sentimentReview.ReviewText;//"Give me Book review and Sentiment Analysis on this books dataset and use review_text as input:\n\n  \n\n";
    
            //userPrompt += $"\nBook Title: {Review.book_title}\nAuthor: {Review.author}\nRating: {Review.rating}\nReview Text: {Review.review_text}\n\n";
           // userPrompt = "Convert the results into json format"

            // Combine the system and assistant prompts
            string combinedPrompt = SystemPrompt + "\n" + AssistantPrompt;
 
            // Call ChatGPT to generate a response
            _chatGPT = new ChatGPT();
            string response = await _chatGPT.ChatCompletionsAsync(combinedPrompt, userPrompt);
            Response = response;

            Books.Add(sentimentReview);
            sentimentReview.ReviewText = string.Empty;
            sentimentReview = new Review();



            
        }
        
    }

}