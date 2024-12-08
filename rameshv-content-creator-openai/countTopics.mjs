import fs from "fs";

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

async function readFile(fileName) {
    console.log('fileName: ', fileName);

    const data = await new Promise(async (resolve, reject) => {
        try {
            const data = await fs.promises.readFile(fileName, 'utf8');
            resolve(data);
        } catch (err) {
            reject(err);
        }
    });

    //console.log('data: ', data);
    return data;
}



async function main() {


    (async () => {
        var subjectsCount = 0;
        var categoriesCount = 0;
        var topicsCount = 0;
        var contentsCount = 0;
        var codeSnippetsCount = 0;
        console.log('main');

        const dataJSONStr = await readFile('./data/content/contentSubjectsNew.json');

        const subjectsJSON = await JSON.parse(dataJSONStr).subjects;

        subjectsJSON.map((subject) => {
            subjectsCount++;
            subject.categories.map(async (category) => {
                categoriesCount++;

                const topicsFile = category.fileName;
                //console.log('topicsFile: ', topicsFile);

                const topicsJSONStr = await readFile("./" + topicsFile);
                //console.log('topicsJSONStr: ', topicsJSONStr);
                const topicsJSON = JSON.parse(topicsJSONStr).topics;

                topicsJSON.map((topic) => {
                    //console.log('topic-->: ', topic.topic);
                    topicsCount++;
                    console.log('topics COunt: ', topicsCount);

                    topic.contents.map((content) => {
                        contentsCount++;
                        //console.log('contentsCount: ', contentsCount);
                        if (content.codeSnippet != undefined && content.codeSnippet != "")
                            codeSnippetsCount++;
                    }
                    );
                }
                );
            }
            );
        });

        console.log('subjectsCount: ', subjectsCount);
        console.log('categoriesCount: ', categoriesCount);
        console.log('topicsCount: ', topicsCount);
        console.log('contentsCount: ', contentsCount);
        console.log('codeSnippetsCount: ', codeSnippetsCount);

        const contentCounts = {};
        contentCounts.subjects = subjectsCount;
        contentCounts.categories = categoriesCount;
        contentCounts.topics = topicsCount;
        contentCounts.contents = contentsCount;
        contentCounts.codeSnippets = codeSnippetsCount;

        saveToFile('./data/content/contentCounts.json', JSON.stringify(contentCounts, null, 2));

    })();
}

await main();