$(document).ready
(
    function () 
    {
        //adpp_LoadAds(); // TEST MODE
    }
);

function adpp_LoadAds() 
{
    var thisLink = document.URL;
    var thisDocInnerText = document.getElementById('MockPage').innerText;
    myAd.pubUrl = thisLink;
    myAd.docText = thisDocInnerText;

    var myAdStr = "input='" + JSON.stringify(myAd) + "'";

    $.ajax
    (
        {
            type: "POST",
            url: "PubSubAds.ashx",  
            data: myAdStr,
            success: function (adsjson) 
            {
                HighlightAdWords1(adsjson);
            }
        }
    );
}

// *************************************************************************************
// SHOW/HIDE AD Popup
var prev_ad_obj = null;
function ShowAd(adlink, adkeyword, addesc) 
{
//    alert(adlink + " " + adkeyword + " " + addesc);

    // see if any prev ad is displayed, if so close it
    if (prev_ad_obj != null) 
    {
        document.body.removeChild(prev_ad_obj);
        prev_ad_obj = null;
    }

    var aw = 130; // ad width
    var ah = 70; // ad height
    var pad = 20;

    var cl = 0; // container left
    var ct = 0; // container top
    var highlight_a = window.event.srcElement; // document.getElementById("a_" + adkeyword);
    var rect_a = highlight_a.getBoundingClientRect();
    var bndRight = 0;
    var bndBottom = 0;

    // if there is space on the right, bottom
    if (rect_a.right + aw + 20 < document.body.clientWidth && rect_a.bottom + ah + 20 < document.body.clientHeight) 
    {
        bndRight = rect_a.right + getBody().scrollLeft;
        bndBottom = rect_a.bottom + getBody().scrollTop;
    }
    // if there is spance on the left, bottom
    else if (rect_a.left - aw - 20 > 0 && rect_a.bottom + ah + 20 < document.body.clientHeight) {
        bndRight = rect_a.left - aw + getBody().scrollLeft - (rect_a.right - rect_a.left);
        bndBottom = rect_a.top + getBody().scrollTop + (rect_a.bottom - rect_a.top);
    }
    // if there is spance on the right, top
    else if (rect_a.right + aw + 20 < document.body.clientWidth && rect_a.top - ah - 20 > document.body.clientTop) {
        bndRight = rect_a.right + getBody().scrollLeft;
        bndBottom = rect_a.top - ah + getBody().scrollTop - (rect_a.bottom - rect_a.top);
    }
    // if there is spance on the left, top
    else if (rect_a.left - aw - 20 > 0 && rect_a.top - ah - 20 > document.body.clientTop) {
        bndRight = rect_a.left - aw + getBody().scrollLeft - (rect_a.right-rect_a.left);
        bndBottom = rect_a.top - ah + getBody().scrollTop - (rect_a.bottom - rect_a.top);
    }
    //    alert(bndRight);
//    alert(window.event.clientX);
//    alert(bndBottom);
//    alert(window.event.clientY);
//    alert(getBody().scrollLeft);
//    alert(getBody().scrollTop);
//    
    // container div
    var c_divelm = document.createElement("div");
    c_divelm.id = "divadc_" + adkeyword;
    c_divelm.name = "divadc_" + adkeyword;
    c_divelm.onmouseout = HideAd;
    c_divelm.style.position = "absolute";
    c_divelm.style.left = bndRight;
    c_divelm.style.top = bndBottom;
    c_divelm.style.backgroundColor = "aqua";
    c_divelm.style.padding = "1.5mm";
    c_divelm.style.opacity = "0.3";
    c_divelm.style.border = "0.001cm groove black";

    document.body.appendChild(c_divelm);
    prev_ad_obj = c_divelm;

    // the contextual ad div
    var adhtml = "<a href='" + adlink + "'>" + adlink + "</a>" + "<br>" + addesc;

    var divelm = document.createElement("div");
    divelm.id = "divad_" + adkeyword;
    divelm.name = "divad_" + adkeyword;
    divelm.innerHTML = adhtml;
    divelm.onmouseout = HideAd;

    divelm.style.position = "relative";
    divelm.style.width = 135;
    divelm.style.backgroundColor = "white";
    divelm.style.border = "0.001cm groove black";
    divelm.style.padding = "0.2cm";
    divelm.style.opacity = 1.0;

    c_divelm.appendChild(divelm);

    // adplusplus.com
    adhtml = "<span style='font-size:12px;color:green'>Free ads by <a href=#>adPlusPlus.com</A></span>";

    divelm = document.createElement("div");
    divelm.innerHTML = adhtml;
    divelm.onmouseout = HideAd;

    divelm.style.position = "relative";
    divelm.style.padding = "0.1cm";
    divelm.style.opacity = 0;

    c_divelm.appendChild(divelm);

    /*
    // site of the day ad div
    adhtml = "<select><option>India's</option><option>America's</option></select><a href=#><br>Site of the Day</A>";

    divelm = document.createElement("div");
    divelm.id = "divadsod_" + adkeyword;
    divelm.name = "divadsod_" + adkeyword;
    divelm.innerHTML = adhtml;
    divelm.onmouseout = HideAd;
    divelm.style.position = "relative";
    divelm.style.backgroundColor = "lightgreen";
    divelm.style.border = "0.001cm groove black";
    divelm.style.padding = "0.2cm";
    divelm.style.opacity = 1.0;
    */
    c_divelm.appendChild(divelm);
}

function HideAd() 
{
    var addiv = prev_ad_obj;
    if (addiv == null || addiv == undefined)
        return;

    var x = window.event.clientX;
    var y = window.event.clientY;
    var l = addiv.getBoundingClientRect().left + document.body.scrollLeft;
    var t = addiv.getBoundingClientRect().top + document.body.scrollTop;

    var r = addiv.getBoundingClientRect().right + document.body.scrollLeft;
    var b = addiv.getBoundingClientRect().bottom + document.body.scrollTop;
    //    alert(x + "y=" + y + "l=" + l + "t=" + t + "w=" + w + "h=" + h);
    if (x < l || x > r || y < t || y > b) 
    {
        document.body.removeChild(addiv);
        prev_ad_obj = null;
    }
}

// **********************************************************************************************
// highlighting - By parsing the html
/*
* This is sort of a wrapper function to the doHighlight function.
* It takes the searchText that you pass, optionally splits it into
* separate words, and transforms the text on the current web page.
* Only the "searchText" parameter is required; all other parameters
* are optional and can be omitted.
*/
function HighlightAdWords1(adsJson) 
{
    var bodyText = document.getElementById('MockPage').innerHTML; //.body.innerHTML TEST MODE
    for (var i = 0; i < adsJson.ads.length; i++) 
    {
        var highlightStartTag = "<SPAN class=adclass id='a_" + adsJson.ads[i].adkeyword + "' href=# onmouseover='ShowAd(\"" + adsJson.ads[i].adlink + "\",\"" + adsJson.ads[i].adkeyword + "\",\"" + adsJson.ads[i].adlinkdesc + "\");'" + ">";
        var highlightEndTag = "</SPAN>";
        bodyText = HighlightAdWords1Helper(bodyText, adsJson.ads[i].adkeyword, highlightStartTag, highlightEndTag);
    }

    // document.body.innerHTML = bodyText;
    document.getElementById('MockPage').innerHTML = bodyText; // TEST MODE

    return true;
}

function HighlightAdWords1Helper(bodyText, searchTerm, highlightStartTag, highlightEndTag) 
{
    // the highlightStartTag and highlightEndTag parameters are optional
    if ((!highlightStartTag) || (!highlightEndTag)) 
    {
        highlightStartTag = "<font class='adclass'>";
        highlightEndTag = "</font>";
    }

    // find all occurences of the search term in the given text,
    // and add some "highlight" tags to them (we're not using a
    // regular expression search, because we want to filter out
    // matches that occur within HTML tags and script blocks, so
    // we have to do a little extra validation)
    var newText = "";
    var i = -1;
    var lcSearchTerm = searchTerm.toLowerCase();
    var lcBodyText = bodyText.toLowerCase();

    while (bodyText.length > 0) 
    {
        i = lcBodyText.indexOf(lcSearchTerm, i + 1);
        if (i < 0) 
        {
            newText += bodyText;
            bodyText = "";
        }
        else 
        {
            // skip anything inside an HTML tag
            if (bodyText.lastIndexOf(">", i) >= bodyText.lastIndexOf("<", i)) 
            {
                // skip anything inside a <script> block
                if (lcBodyText.lastIndexOf("/script>", i) >= lcBodyText.lastIndexOf("<script", i)) 
                {
                    newText += bodyText.substring(0, i) + highlightStartTag + bodyText.substr(i, searchTerm.length) + highlightEndTag;
                    bodyText = bodyText.substr(i + searchTerm.length);
                    lcBodyText = bodyText.toLowerCase();
                    i = -1;
                }
            }
        }
    }

    return newText;
}    

// **********************************************************************************************
// Another way of highlighting - Using Text Range object
function HighlightKeyWords2(msg) 
{
    var before = ' <font style="color: #000000;text-decoration:none;background-color: ';
    var after = '</b> </font> ';

    var k; var i; var rng;

    try 
    {
        for (k = 0; k < msg.length; k++) 
        {
            rng = document.body.createTextRange();

            for (i = 0; rng.findText(msg[k].adkeyword) != false; i++) 
            {
                try 
                {
                    rng.pasteHTML(before + 'red' + ';"> <b>' + rng.text + after);
                }
                catch (e) 
                {
                }
                finally 
                {
                    rng.collapse(false);
                }
            }

            rng.collapse(true);
        }
    }
    catch (e1) 
    {
    }
}

// **********************************************************************************************
// Another way of highlighting is also possible Using DOM walker


// ***********************************************************************************************
// UTILS
function getBody() 
{
    return (document.compatMode == 'BackCompat' ? document.body : document.documentElement);
}
