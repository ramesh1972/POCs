import OpenAIApi from "openai";
import fs from "fs";

const openai = new OpenAIApi({
    apiKey: "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",
});

var topicNo = 0;
function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function saveToFile(fileName, str) {
    fs.writeFile(fileName, str, (err) => {
        if (err) {
            console.error(err);
            return;
        }
        console.log("File has been created");
        return;
    });
}

function getCompletion(prompt, temperature = 0) {
    const response = openai.createCompletion({
        model: 'gpt-3.5-turbo',
        prompt: prompt,
        temperature // Degree of randomness of the model's output
    })

    return response.choices[0].message.content
}

async function getCompletionFromMessages(messages, temperature = 0) {
    const response = await openai.chat.completions.create({
        messages: messages,
        temperature: temperature,
        model: "gpt-3.5-turbo",
    }).catch(async (e) => {
        if (e.statusCode === 429) {
            await sleep(1500);
            return getCompletionFromMessages(messages, temperature);
        }
    });

    return response.choices[0].message.content;
}

async function generateContent(content, topic, category, subject) {
    console.log("----------------------------------")
    console.log('generateContent: Content-->' + content + ' Topic-->' + topic + " Cat --> " + category + " Sub--> " + subject);
    let messages = [
        { 'role': 'system', 'content': 'You are an excellent technical content creator. you need to provide infromation about a certain content' },
        { 'role': 'user', 'content': 'provide content info for the content "' + content + '" in topic "' + topic + '" in the caetgory of "' + category + '"' + ' in the subject of "' + subject + '"' },
        { 'role': 'user', 'content': 'provide an example  for the content if applicable' },
        { 'role': 'user', 'content': 'provide a code snippet for the content if applicable' },
        { 'role': 'user', 'content': 'return always only a single json object holding the content info  in the format {text:, example:, codeSnippet:, codeLanguage:}' },
        { 'role': 'user', 'content': 'ensure that example is not similar to the codeSnippet then ignore example in the output' },
        { 'role': 'user', 'content': 'do not insert the words "example" or "json" in the output json' },
        { 'role': 'user', 'content': 'return only json object' },
    ]

    var response = await getCompletionFromMessages(messages, .2)
    //console.log('response: ', response);
    if (response != null && response != undefined) {
        //console.log("----------------------------------")
        //console.log("contents = " + response);
        //console.log("----------------------------------")
        return response;
    }

    return null;
}

async function generateContents(topic, category, subject) {
    //console.log("----------------------------------")
    //console.log('generateContents: Topic-->' + topic + " Cat --> " + category + " Sub--> " + subject);
    let messages = [
        { 'role': 'system', 'content': 'You are an excellent technical content creator. you need to provide training content for a given topic' },
        { 'role': 'user', 'content': 'provide contents for the topic "' + topic + '" in the caetgory of "' + category + '"' + ' in the subject of "' + subject + '"' },
        { 'role': 'user', 'content': 'provide examples for each content where applicable' },
        { 'role': 'user', 'content': 'provide code snippet for each content where applicable' },
        { 'role': 'user', 'content': 'return always only the content json array in the format [{text:, example:, codeSnippet:, codeLanguage:},{text:, example:, codeSnippet:, codeLanguage:}]' },
        { 'role': 'user', 'content': 'ensure that example is not similar to the codeSnippet then ignore example in the output' },
        { 'role': 'user', 'content': 'do not insert the words "example" or "json" in the output json' },
        { 'role': 'user', 'content': 'return ONLY json array' },
    ]

    var response = await getCompletionFromMessages(messages, .2)
    //console.log('response: ', response);
    if (response != null && response != undefined) {
        //console.log("----------------------------------")
        //console.log("contents = " + response);
        //console.log("----------------------------------")
        return response;
    }

    return null;
}

async function fetchTopicContentKnowledge(content, topic, category, subject) {
    var c = generateContent(content, topic, category, subject);

    return c;
}

async function fetchTopicContents(topic, category, subject) {
    var t = {};
    var contentarr = [];

    if (topic.contents != null && topic.contents != undefined) {
        await Promise.all(topic.contents.map(async (content) => {
            var contentJSON = await fetchTopicContentKnowledge(content, topic.topic, category.category, subject.subject);

            //console.log('contentJSON ------------------: ', contentJSON);
            var contentObj = JSON.parse(contentJSON);
            contentarr.push(contentObj);
        }))
    }

    var contentStr = await generateContents(topic.topic, category.category, subject.subject);
    if (contentStr == null || contentStr == undefined) {
        return;
    }

    //console.log('contentStr ------------------: ', contentStr);
    var contentsObj = JSON.parse(contentStr);

    contentsObj.forEach((content) => {
        contentarr.push(content);
    }
    );

    //console.log('++++++++++++++++++++++ TOPIC ', t);

    t.topic = topic.topic;
    t.topic_no = ++topicNo;
    t.contents = contentarr;

    return t;
}

async function fetchCategory(category, subject) {
    var c = {};

    var ts = [];
    for (var i = 0; i < category.topics.length; i++) {
        // add exception handling
        try {
            var topic = category.topics[i];
            var topicsJSON = await fetchTopicContents(topic, category, subject);

            if (topicsJSON == null || topicsJSON == undefined) {
                continue;
            }

            ts.push(topicsJSON);
        }
        catch (e) {
            console.log('Error: ', e);
            continue;
        }
    }

    c.category = category.category;
    c.topics = ts;
    //console.log('++++++++++++++++++++++ CATEGORY ', c);

    var fileName = c.category.toString().replace(/ /g, "_");
    var dir = subject.subject.toString().replace(/ /g, "_");

    // remove special characters
    dir = '/data/content/' + dir.replace(/[^a-zA-Z0-9_]/g, '');
    fileName = fileName.replace(/[^a-zA-Z0-9_]/g, '');

    let dirPath = "." + dir;
    if (!fs.existsSync(dirPath)) {
        fs.mkdirSync(dirPath);
    }

    fileName = dirPath + '/' + fileName + ".json";
    var jsonString = JSON.stringify(c, null, 2);

    //console.log('fileName: ', fileName);
    //console.log('jsonString: ', jsonString);

    saveToFile(fileName, jsonString);

    return fileName;
}


async function fetchSubject(subject) {
    var s = {};

    var cats = [];
    await Promise.all(subject.categories.map(async (category) => {
        var c = await fetchCategory(category, subject);

        // remove leading .
        c = c.replace(/^\.\//, '');
        cats.push({ category: category.category, fileName: c });
    }));

    s.subject = subject.subject;
    s.categories = cats;

    //console.log('++++++++++++++++++++++SUBJECT: ', s);
    return s;
}


async function fetchSubjects(subjectsJSON) {
    var subjects = [];

    await Promise.all(subjectsJSON.map(async (subject) => {
        var s = await fetchSubject(subject);
        subjects.push(s);
    }));

    return subjects;
}

async function main() {
    (async () => {
        try {
            const data = await new Promise((resolve, reject) => {
                fs.readFile('contentTopics.json', 'utf8', (err, data) => {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(data);
                    }
                });
            });

    
            if (!fs.existsSync('./data')) {
                fs.mkdirSync('./data');
            }

            if (!fs.existsSync('./data/content')) {
                fs.mkdirSync('./data/content');
            }

            const subjectsJSON = JSON.parse(data).data;

            console.log('subjectsJSON: ', subjectsJSON);    
            return;

            const subs = await fetchSubjects(subjectsJSON);

            const finalJSON = {};
            finalJSON.topics_count = topicNo;
            finalJSON.subjects = subs;
            //console.log('subjectsJSON output: ', JSON.stringify(subs, null, 2));
            saveToFile('./data/content/contentSubjectsNew.json', JSON.stringify(finalJSON, null, 2));

        } catch (err) {
            console.error(err);
        }
    })();
}

await main();


//var subss = await generateContent('React');
//console.log('<><><><><>subss: ', subss);

