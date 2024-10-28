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
    public class SelfConsistencyPrompting
    {
        public static void Main()
        {
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            var api = new OpenAI_API.OpenAIAPI();

            String[] prompts = new String[15];
            prompts[0] = "Q: There are 15 trees in the grove. Grove workers will plant trees in the grove today. After they are done,";
            prompts[1] = "there will be 21 trees. How many trees did the grove workers plant today?";
            prompts[2] = "A: We start with 15 trees. Later we have 21 trees. The difference must be the number of trees they planted.";
            prompts[3] = "So, they must have planted 21 - 15 = 6 trees. The answer is 6.";
            prompts[4] = "Q: If there are 3 cars in the parking lot and 2 more cars arrive, how many cars are in the parking lot?";
            prompts[5] = "A: There are 3 cars in the parking lot already. 2 more arrive. Now there are 3 + 2 = 5 cars. The answer is 5.";
            prompts[6] = "Q: Leah had 32 chocolates and her sister had 42. If they ate 35, how many pieces do they have left in total?";
            prompts[7] = "A: Leah had 32 chocolates and Leah’s sister had 42. That means there were originally 32 + 42 = 74";
            prompts[8] = "chocolates. 35 have been eaten. So in total they still have 74 - 35 = 39 chocolates. The answer is 39.";
            prompts[9] = "Q: Jason had 20 lollipops. He gave Denny some lollipops. Now Jason has 12 lollipops. How many lollipops";
            prompts[10] = "did Jason give to Denny?";
            prompts[11] = "A: Jason had 20 lollipops. Since he only has 12 now, he must have given the rest to Denny. The number of";
            prompts[12] = "lollipops he has given to Denny must have been 20 - 12 = 8 lollipops. The answer is 8.";
            prompts[13] = "Q: When I was 6 my sister was half my age. Now I’m 70 how old is my sister?";
            prompts[14] = "A:";

            // create the Chat message with prompt in assistant role as we are assisting chatGPT to respond better
            List<ChatMessage> messages = new List<ChatMessage>();

            for (int i = 0; i < 15; i++)
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
