SetupDocumentForSelection();

function CreateSelHTMLElement(pHTMLDoc) {
    var lHead = pHTMLDoc.createElement("Div");
    var height = 20;
    lHead.IsSelectionHeader = "true";
    lHead.style.backgroundColor = "blue";
    lHead.style.width = "100%";
    lHead.style.height = height;
    lHead.innerHTML = "Sel";

    return lHead;
}

function SetupElementForSelection(pHTMLDoc, pHTMLElem) {
    if (pHTMLElem.childNodes != null) {
        for (var idx = pHTMLElem.childNodes.length - 1; idx >= 0; idx--) {
            SetupElementForSelection(pHTMLDoc, pHTMLElem.childNodes(idx));
        }
    }

    if (pHTMLElem.tagName != "BODY" && pHTMLElem.tagName != undefined && pHTMLElem.tagName != "" && pHTMLElem.innerHTML != "" && pHTMLElem.innerHTML != undefined) {
        var lHead = CreateSelHTMLElement(pHTMLDoc);
        pHTMLElem.parentNode.insertBefore(lHead, pHTMLElem);
    }
}

function SetupDocumentForSelection() {
    SetupElementForSelection(document, document.body);
    var lHead = CreateSelHTMLElement(document);
    document.body.insertBefore(lHead, document.body.firstChild);
}
