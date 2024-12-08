const fs = require('fs');
const cheerio = require('cheerio');
const json = require('stream/consumers');




fs.readFile('bookmarks_2_7_24.html', 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }

    var jsonObj = [];
    var h3WithA = false;
    const $ = cheerio.load(data);

    $('body').children().each((i, element) => {
        jsonObj = parseNode(element, h3WithA);
    });

    console.log(jsonObj);
});

var hyphens = "--";


function parseNode(element, h3WithA = true) {
    if (element == undefined || element == null) {
        return null;
    }

    console.log(hyphens + "in parse " + element.name);

    if (element.children == undefined || element.children == null) {
        return null;
    }



    element.children.forEach(elem => {

        jsonObj = parseNode(elem, h3WithA);
        if (jsonObj != null) {


            if (element.name == 'a') {
                var link = element.attribs['href'];
                linkText = element.children[0].data;

                console.log(hyphens + "in a " + linkText + "+++" + link);

                jsonObj.push({ "link": link, "title": linkText });

                h3WithA = true;
                return jsonObj;
            }
            else if (element.name == 'h3') {
                var node_title = element.children[0].data;

                console.log(hyphens + "in h3 " + node_title);

                if (!h3WithA) {
                    jsonObj.push({ "parent_folder_title": node_title, children: [] });
                    h3WithA = true;
                    return jsonObj.children;
                }
                else {
                    jsonObj.push({ "folder_title": node_title, "list": [] });
                    return jsonObj.list;
                }
            }
            else {
                console.log(hyphens + "in else 1");

            }

            return jsonObj;
        }
    });

    hyphens = hyphens + "--";
}


