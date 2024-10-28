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
    public class EffectivePrompts
    {
        public static void Main()
        {
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            var api = new OpenAI_API.OpenAIAPI();

            var chat = api.Chat.CreateConversation();
            chat.Model = Model.GPT4_Turbo;
            chat.RequestParameters.Temperature = 0;

            /// give instruction as System
            chat.AppendSystemMessage("You are a math teacher who helps children to learn math");

            // give a few examples as user and assistant
            chat.AppendUserInput("what is 2 + 3?");
            chat.AppendExampleChatbotOutput("5");
            chat.AppendUserInput("what is 2 + 4?");
            chat.AppendExampleChatbotOutput("6");

            // now let's ask it a question
            chat.AppendUserInput("what is 5 + 9?");
            
            // and get the response
            string response = chat.GetResponseFromChatbotAsync().Result;

            // the entire chat history is available in chat.Messages
            foreach (ChatMessage msg in chat.Messages)
            {
                Console.WriteLine($"{msg.Role}: {msg.Content}");
            }

            Console.WriteLine("---------------"); // "Yes"
            Console.WriteLine(response); // "Yes"
        }
    }
}
