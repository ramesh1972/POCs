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
    public class GeneralKnowledgePrompting
    {
        public static void Main()
        {
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            var api = new OpenAI_API.OpenAIAPI();

            String[] prompts = new String[3];
            prompts[0] = "Question: Part of golf is trying to get a higher point total than others. Yes or No?";
            prompts[1] = "Knowledge: The objective of golf is to play a set of holes in the least number of strokes. A round of golf typically consists of 18 holes. Each hole is played once in the round on a standard golf course. Each stroke is counted as one point, and the total number of strokes is used to determine the winner of the game.";
            prompts[2] = "Explain and Answer: ";

            // create the Chat message with prompt in assistant role as we are assisting chatGPT to respond better
            List<ChatMessage> messages = new List<ChatMessage>();

            for (int i = 0; i < 3; i++)
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
