using Microsoft.AspNetCore.Mvc.RazorPages;
using PEExperimentsWeb.Models;
using PEExperimentsWeb.Utils;

namespace PEExperimentsWeb.Pages
{
    public class EmotionsIndexModel : PageModel
    {
        public List<Emotion> Emotions { get; set; } = new List<Emotion>();
        public Emotion emotion { get; set; }
        private readonly ILogger<EmotionsIndexModel> _logger;
        private ChatGPT _chatGPT;

        public string userPrompt { get; set; }

        public string AnalysisResult { get; set; }
        public string SystemPrompt { get; private set; }
        public string AssistantPrompt { get; private set; }

        public EmotionsIndexModel(ILogger<EmotionsIndexModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {
        }

        public async Task OnPostAsync(Emotion emotion)
        {
            
            SystemPrompt = "You are an emotion type analyzer";
            AssistantPrompt = "Identify a list of emotions that the writer of the following review is expressing. Include no more than five items in the list. Format your answer as a list of lower-case words separated by commas.";
            string userPrompt = emotion.Emo1;

            // Combine the system and assistant prompts
            string combinedPrompt = SystemPrompt + "\n"+userPrompt+"\n"+AssistantPrompt;
            
            _chatGPT = new ChatGPT();
            string response = await _chatGPT.ChatCompletionsAsync(SystemPrompt, combinedPrompt);
            AnalysisResult = response;
            Emotions.Add(emotion);
            emotion = new Emotion();
        }
                }
};
