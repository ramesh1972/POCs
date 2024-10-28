function changeIframeSrc(id, url) {
    var el = document.getElementById(id);
    if (el) {
        el.src = "StartTargetPage.aspx?loadurl=" + url;
        alert(e1.src);
        return false;
    }
    return true;
}


function OnEnterClick() {
    parent.TargetWebSite.location = "TargetWebPage.aspx?loadurl=" +  parent.UrlInput.document.getElementById("EnterTextOrUrl").value;
}

function TargetSiteOnLoad(thisFrame) {
    alert(1);
    alert(thisFrame.document.body.innerHTML);
    var headID = thisFrame.document.getElementsByTagName("head")[0];
    var newScript = thisFrame.document.createElement('script');
    newScript.type = 'text/javascript';
    newScript.src = 'Scripts/ExternalDOM.js';
    newScript.onload = scriptHasLoaded;
    newScript.onreadystatechange = scriptHasLoaded;
    headID.appendChild(newScript);

    alert(2);
}

function scriptHasLoaded() {
    alert("script loaded");
    //parent.TargetWebSite.SetupDocumentForSelection(parent.TargetWebSite.document);
}