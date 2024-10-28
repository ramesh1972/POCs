using Azure.AI.OpenAI;

OpenAIClient client = new OpenAIClient("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");

string deploymentOrModelName = "gpt-3.5-turbo";

var requestOptions = new ChatCompletionsOptions()
{
    DeploymentName = deploymentOrModelName,
    Messages =
                {
                    new ChatRequestSystemMessage("You are a helpful assistant."),
                    new ChatRequestUserMessage("Can you help me?"),
                    new ChatRequestAssistantMessage("Of course! What do you need help with?"),
                    new ChatRequestUserMessage("What temperature should I bake pizza at?"),
                },
    MaxTokens = 10
};

ChatCompletions response =  client.GetChatCompletions(requestOptions);
ChatChoice choice = response.Choices[0];
Console.WriteLine(choice.Message.Content);