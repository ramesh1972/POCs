const cheerio = require('cheerio');

const html = `...`; // your HTML string here

const $ = cheerio.load(html);

function parseNode(element) {
    const result = [];

    if (element.name === 'h3' || element.name === 'a') {
        const attrs = {};
        for (let attrName in element.attribs) {
            attrs[attrName] = element.attribs[attrName];
        }

        result.push({
            tagName: element.name,
            attributes: attrs,
            textContent: $(element).text().trim(),
        });
    }

    if (element.children) {
        element.children.forEach(child => {
            result.push(...parseNode(child));
        });
    }

    return result;
}

const parsedData = [];
$('body').children().each((i, element) => {
    parsedData.push(...parseNode(element));
});
console.log(parsedData);