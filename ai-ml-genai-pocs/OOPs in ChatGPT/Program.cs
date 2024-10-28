Main(args[]) 
{
    // read args
    fileName = args[0];

    // get data from file
    FileReader f = new FileReader();
    string data = f.readFile(filename)
    //or 
    JsonReader j = new JsonReader()
    j.ParseJSONStr(data);

    // call GPT
    ChatGPT _gptHandle = new ChatGPT();
    string result = _gptHandle.GetChatResponse(sysMsg, asstMsgs, userPrompt, .9, .7);
    // or
    ChatGPT _gptHandle = new ChatGPT(sysMsg, asstMsgs, userPrompt, .9, .7);
    string result = _gptHandle.GetChatResponse();

    LogToFile(result);

    // parse and print output
    Product p = new Product();
    p.Parse(result);
    p.PrintProduct();
}