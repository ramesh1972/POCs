function CXml(xmlString) {
    this.xmlDoc = new ActiveXObject("Msxml2.DOMDocument.6.0");
    this.xmlDoc.async = "false";
 
    // load the xml string from the hidden variable
    this.xmlDoc.loadXML(xmlString);
}

CXml.prototype.documentElement = function () {
    if (this.xmlDoc != null)
        return new CXmlNode(this.xmlDoc.documentElement);

    return null;
}

function CXmlNode(sysXmlNode) {
    this.xmlNode = sysXmlNode;
}

CXmlNode.prototype.isNull = function () {
    if (this.xmlNode == null)
        return true;
    return false;
}

CXmlNode.prototype.intAttribute = function (attrName) {
    if (this.xmlNode == null)
        return 0;

    if (attrName == null || attrName == "")
        return 0;

    var attrValue = this.xmlNode.getAttributeNode(attrName);
    if (attrValue != null)
        return parseInt(attrValue.nodeTypedValue);
    else
        return -1;
}

CXmlNode.prototype.stringAttribute = function (attrName) {
    if (this.xmlNode == null)
        return "";

    if (attrName == null || attrName == "")
        return "";

    var attrValue = this.xmlNode.getAttributeNode(attrName);
    if (attrValue != null)
        return attrValue.nodeTypedValue;
    else
        return "";
}


CXmlNode.prototype.boolAttribute = function (attrName) {
    if (this.xmlNode == null)
        return 0;

    if (attrName == null || attrName == "")
        return 0;

    var attrValue = this.xmlNode.getAttributeNode(attrName);
    if (attrValue != null)
        if (attrValue.nodeTypedValue == "true")
            return true;
    
    return false;
}

CXmlNode.prototype.subSections = function () {
    this.subSectionNodeList = new Array();

    for (var idx = 0; idx < this.xmlNode.childNodes.length; idx++)
        if (this.xmlNode.childNodes[idx].nodeName == "section")
            this.subSectionNodeList.push(new CXmlNode(this.xmlNode.childNodes[idx]));

    return this.subSectionNodeList;
}

CXmlNode.prototype.childNode = function (index) {
    if (index >= this.subSectionNodeList.length)
        return null;

    return this.subSectionNodeList[index];
}

CXmlNode.prototype.getHtml = function () {
    if (this.xmlNode == null)
        return "No HTML";

    var htmlNode = this.xmlNode.selectSingleNode("html");
    if (htmlNode == null)
        return "No HTML";

    // strip the <html>
    var html = htmlNode.xml.replace(/<html>/, "").replace(/<\/html>/,"");
    return html;
}