using Newtonsoft.Json;
using OpenAI_API.Chat;
using OpenAI_API.Completions;
using OpenAI_API.Models;
using OpenAI_API.Moderation;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OpenAI_Examples
{
    public class SimpleChat
    {
        public static void Main()
        {
            // Replace the Open AI API Key with your own
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            // create the API handle
            var api = new OpenAI_API.OpenAIAPI();

            // call the chat completion API with a sample prompt
            var results = api.Chat.CreateChatCompletionAsync(new ChatRequest()
            {
                Model = Model.ChatGPTTurbo,
                Temperature = 0.1,
                MaxTokens = 50,
                Messages = new ChatMessage[] {
                    new ChatMessage(ChatMessageRole.User, "Capital of India!")
                }
            }).Result;

            // dispaly the respose frmo ChatGPT
            Console.WriteLine(results);
        }
    }
}
