using System;
using Azure.AI.OpenAI;

class ChatGPT {

    private static String OPEN_AI_API_KEY = "";
    private static string OPEN_AI_DEPLOYMENT_MODEL = "gpt-3.5-turbo";

    
    private ChatCompletionsOptions _options;
    private OpenAIClient aiCLient = new OpenAIClient();


    private String _systemMsg;
    private List<String> _assistantMsgs = new List<String>;
    private String _userPrompt;


    // Constructors        
    public ChatGPT() 
    {
    }

    public ChatGPT(String sysMsg, List<string> asstMsgs, String userPrompt, float temperature = .05f, float top_p = 1) 
    {
        _systemMsg = sysMsg;
        _assistantMsgs = asstMsgs;
        _userPrompt = userPrompt;

        InitOpenAIClient();
        InitChatOptions(temperature, top_p)
    }

    // initializations
    public void InitOpenAIClient() 
    {
        // init openAIClient
    }

    public void InitChatOptions(float temperature, float top_p) 
    {
        _options = new ChatCompletionsOptions
        {
            MaxTokens = 1000,
            Temperature = temperature,
            FrequencyPenalty = 0.0f,
            PresencePenalty = 0.0f,
            NucleusSamplingFactor = top_p // Top P
        };
    } 

    public void AddAssistantMessage(String msg)
    {
        if (!String.IsEmptyOrNull(msg))
            _assistantMsgs.Add(msg);
    }

    public String GetChatResponse() {
        //call to azure Open AI with 
        GetChatResponse(_systemMsg, _assistantMsgs, _userPrompt, temperature, top_p);
    }

    public String GetChatResponse(String sysMsg, List<string> assistantMsgs, String userPrompt, float temperature = .05f, float top_p = 1) {

        // set options
        InitChatOptions(temperature, float);

        // set chat role messages
        _options.Messages.Add(new ChatMessage(ChatRole.System, sysMsg));

        foreach (string assitantMsg in assistantMsgs)
            _options.Messages.Add(new ChatMessage(ChatRole.Assistant, assitantMsg));
        
        _options.Messages.Add(new ChatMessage(ChatRole.User, userPrompt));
 
        // call ChatGPT
        ChatCompletions response = await openAIClient.GetChatCompletionsAsync(OPEN_AI_DEPLOYMENT_MODEL, completionOptions);

        return response.Choices[0].Message.Content;
    }
}