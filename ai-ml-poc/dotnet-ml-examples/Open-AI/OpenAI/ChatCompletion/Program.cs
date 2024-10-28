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
    public class ChatCompletion
    {
        public static void Main()
        {
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            var api = new OpenAI_API.OpenAIAPI();

            ChatRequest chatRequest = new ChatRequest()
            {
                Model = Model.ChatGPTTurbo,
                Temperature = 0.0,
                MaxTokens = 500,
                Messages = new ChatMessage[] {
                    new ChatMessage(ChatMessageRole.System, "You are a helpful assistant designed to output JSON."),
                    new ChatMessage(ChatMessageRole.User, "Who won the world series in 2020?  Return JSON of a 'wins' dictionary with the year as the numeric key and the winning team as the string value.")
                }
            };

            var results = api.Chat.CreateChatCompletionAsync(chatRequest).Result;
            Console.WriteLine(results);
        }
    }
}
