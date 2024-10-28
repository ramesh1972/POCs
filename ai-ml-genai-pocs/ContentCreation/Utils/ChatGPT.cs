using System;
using System.Collections.Generic;
using Azure.AI.OpenAI;

namespace ContentCreation.Utils
{
    public class ChatGPT
    {
        private string AOAI_KEY = "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";
        private string AOAI_DEPLOYMENTID = "gpt-3.5-turbo";

        private OpenAIClient _openAIClient;

        public ChatGPT()
        {
            _openAIClient = new OpenAIClient(AOAI_KEY);
        }



        public async Task<string> ChatCompletionsAsync(string systemPrompt, string userPrompt, List<string>? assistantPrompts = null, float temperature = 1)
        {
            // set options
            var completionOptions = new ChatCompletionsOptions
            {
                MaxTokens = 1000,
                Temperature = temperature,
                FrequencyPenalty = 0.0f,
                PresencePenalty = 0.0f,
                NucleusSamplingFactor = 1 
            };

            // create the messages JSON array
            completionOptions.Messages.Add(new ChatMessage(ChatRole.System, systemPrompt));

            if (assistantPrompts != null)
            {
                foreach (var assistantPrompt in assistantPrompts)
                    completionOptions.Messages.Add(new ChatMessage(ChatRole.Assistant, assistantPrompt));
            }

            completionOptions.Messages.Add(new ChatMessage(ChatRole.User, userPrompt));

            // cāll ChatGPT 
            ChatCompletions response = await _openAIClient.GetChatCompletionsAsync(AOAI_DEPLOYMENTID, completionOptions);

            return response.Choices[0].Message.Content;
        }

        internal Task<string> GetCompletion(object prompt)
        {
            throw new NotImplementedException();
        }
    }
}