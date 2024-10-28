using Azure.AI.OpenAI;
using Newtonsoft;
using System.Text.Json;

OpenAIClient client = new OpenAIClient("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");
string deploymentOrModelName = "gpt-3.5-turbo";

FunctionDefinition s_futureTemperatureFunction = new()
    {
        Name = "get_future_temperature",
        Description = "requests the anticipated future temperature at a provided location to help inform "
                + "advice about topics like choice of attire",
        Parameters = BinaryData.FromObjectAsJson(new
        {
            Type = "object",
            Properties = new
            {
                LocationName = new
                {
                    Type = "string",
                    Description = "the name or brief description of a location for weather information"
                },
                Date = new
                {
                    Type = "string",
                    Description = "the day, month, and year for which to retrieve weather information"
                }
            }
        },
            new JsonSerializerOptions() { PropertyNamingPolicy = JsonNamingPolicy.CamelCase })
    };

var requestOptions = new ChatCompletionsOptions()
{
    DeploymentName = deploymentOrModelName,
    Functions = { s_futureTemperatureFunction },
    Messages =
            {
                new ChatRequestSystemMessage("You are a helpful assistant."),
                new ChatRequestUserMessage("What should I wear in Honolulu next Thursday?"),
            },
    MaxTokens = 512,
};

ChatCompletions response = client.GetChatCompletions(requestOptions);

ChatChoice choice = response.Choices[0];
ChatResponseMessage message = choice.Message;

ChatCompletionsOptions followupOptions = new()
{
    DeploymentName = deploymentOrModelName,
    Functions = { s_futureTemperatureFunction },
    MaxTokens = 512,
};

foreach (ChatRequestMessage originalMessage in requestOptions.Messages)
{
    followupOptions.Messages.Add(originalMessage);
}

followupOptions.Messages.Add(new ChatRequestAssistantMessage(response.Choices[0].Message.Content)
{
    FunctionCall = new(message.FunctionCall.Name, message.FunctionCall.Arguments),
});

followupOptions.Messages.Add(new ChatRequestFunctionMessage(
    name: message.FunctionCall.Name,
    content: JsonSerializer.Serialize(
        new
        {
            Temperature = "31",
            Unit = "celsius",
        },
        new JsonSerializerOptions() { PropertyNamingPolicy = JsonNamingPolicy.CamelCase })));

ChatCompletions followupResponse = client.GetChatCompletions(followupOptions);

Console.WriteLine(followupResponse.Choices[0].Message.Content);

