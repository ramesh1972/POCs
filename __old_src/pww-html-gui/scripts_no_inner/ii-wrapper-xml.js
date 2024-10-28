function CXml(xmlString) {
    this.xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
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

    for (var idx = 0; idx < this.xmlNode.attributes.length; idx++)
        if (this.xmlNode.attributes[idx].nodeName == attrName)
            return parseInt(this.xmlNode.attributes[idx].nodeValue);

    return 0;
}

CXmlNode.prototype.stringAttribute = function (attrName) {
    if (this.xmlNode == null)
        return "";

    if (attrName == null || attrName == "")
        return "";

    for (var idx = 0; idx < this.xmlNode.attributes.length; idx++)
        if (this.xmlNode.attributes[idx].nodeName == attrName)
            return this.xmlNode.attributes[idx].nodeValue;

    return "";
}


CXmlNode.prototype.boolAttribute = function (attrName) {
    if (this.xmlNode == null)
        return "";

    if (attrName == null || attrName == "")
        return "";

    for (var idx = 0; idx < this.xmlNode.attributes.length; idx++)
        if (this.xmlNode.attributes[idx].nodeName == attrName) {
            if (this.xmlNode.attributes[idx].nodeValue == "true")
                return true;
            else
                return false;
        }

    return false;
}

CXmlNode.prototype.childNodes = function () {
    this.childNodesList = new Array();

    for (var idx = 0; idx < this.xmlNode.childNodes.length; idx++)
        this.childNodesList.push(new CXmlNode(this.xmlNode.childNodes[idx]));

    return this.childNodesList;
}

CXmlNode.prototype.childNode = function (index) {
    if (index >= this.childNodesList.length)
        return null;

    return this.childNodesList[index];
}