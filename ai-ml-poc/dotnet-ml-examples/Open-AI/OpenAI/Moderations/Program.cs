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
    public class PromptElements
    {
        public static void Main()
        {
            OpenAI_API.APIAuthentication.Default = new OpenAI_API.APIAuthentication("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");

            var api = new OpenAI_API.OpenAIAPI();

            var chat = api.Chat.CreateConversation();
            chat.Model = Model.GPT4_Turbo;
            chat.RequestParameters.Temperature = 0;

            /// give instruction as System
            chat.AppendSystemMessage("You are a teacher who helps children to avoid hate speech");

            // give a few examples as user and assistant
            chat.AppendUserInput("Is the following hate speech? I hate my teacher");

            // and get the response
            string response = chat.GetResponseFromChatbotAsync().Result;

            // the entire chat history is available in chat.Messages
            foreach (ChatMessage msg in chat.Messages)
            {
                Console.WriteLine($"{msg.Role}: {msg.Content}");
            }

            Console.WriteLine(response); // "Yes"
        }
    }
}
