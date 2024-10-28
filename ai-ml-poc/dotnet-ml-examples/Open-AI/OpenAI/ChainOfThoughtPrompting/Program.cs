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
    public class ChainOfThoughtPrompting
    {
        public static void Main()
        {
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            var api = new OpenAI_API.OpenAIAPI();

            // Call ChatGPT Chat Completion with a CoT (Chain of THought) prompting technique
            // You will see that ChatGPT most likely will give the right answer. This is because in the prompt
            // the thinking process is given in the form of examples
            String[] prompts = new String[10];
            prompts[0] = "The odd numbers in this group add up to an even number: 4, 8, 9, 15, 12, 2, 1.";
            prompts[1] = "A: The answer is False.";
            prompts[2] = "The odd numbers in this group add up to an even number: 17,  10, 19, 4, 8, 12, 24.";
            prompts[3] = "A: The answer is True.";
            prompts[4] = "The odd numbers in this group add up to an even number: 16,  11, 14, 4, 8, 13, 24.";
            prompts[5] = "A: The answer is True.";
            prompts[6] = "The odd numbers in this group add up to an even number: 17,  9, 10, 12, 13, 4, 2.";
            prompts[7] = "A: The answer is False.";
            prompts[8] = "The odd numbers in this group add up to an even number: 15, 32, 4, 13, 82, 7, 1. ";
            prompts[9] = "A: ";

            // create the Chat message with prompt in assistant role as we are assisting chatGPT to respond better
            List<ChatMessage> messages = new List<ChatMessage>();

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine(prompts[i]);
                ChatMessage assistantMessage = new ChatMessage(ChatMessageRole.Assistant, prompts[i]);
                messages.Add(assistantMessage);
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
