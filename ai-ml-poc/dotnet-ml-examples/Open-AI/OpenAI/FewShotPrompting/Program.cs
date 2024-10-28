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
    public class FewShotPrompting
    {
        public static void Main()
        {
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            var api = new OpenAI_API.OpenAIAPI();

            // Few Shot Prompting. provide examples for the actual prompt. ChatGPT will respond more accurately
            String[] prompts = new String[5];
            prompts[0] = "Positive This is awesome! ";
            prompts[1] = "This is bad! Negative";
            prompts[2] = "Wow that movie was rad!";
            prompts[3] = "Positive";
            prompts[4] = "What an interensting movie! --";


            // create the Chat message with prompt in assistant role as we are assisting chatGPT to respond better
            List<ChatMessage> messages = new List<ChatMessage>();

            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine(prompts[i]);
                 ChatMessage userMessage = new ChatMessage(ChatMessageRole.User, prompts[i]);
                messages.Add(userMessage);
            }

            ChatRequest chatRequest = new ChatRequest()
            {
                Model = Model.ChatGPTTurbo,
                Temperature = 0.0,
                MaxTokens = 500,
                Messages = messages
            };

            var results = api.Chat.CreateChatCompletionAsync(chatRequest).Result;
            Console.WriteLine(results);
        }
    }
}
