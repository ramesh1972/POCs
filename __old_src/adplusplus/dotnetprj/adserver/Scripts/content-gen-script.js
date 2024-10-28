function get_gen_script_content() 
{
    var htmlStr = "<div style='margin:8px'><table class=standard_font>" +
    "<tr><td colspan=2 style='color:blue;font-weight:bold;font-size:large'>Generate Script for your advertisement using the form below<br></td></tr>" +
    "<tr>" +
        "<td>Enter keywords for the Web Page<br /> that you want to advertise.</td>" +
        "<td>(<span style=color:blue>Separate multiple keywords by comma</span>)<br><input type=text id=adKeyWords maxlength=55 size=60 /></td>" +
    "</tr>" +
    "<tr>" +
        "<td>Enter the description of your ad.</td>" +
        "<td><textarea id=adDesc rows=3 cols=40></textarea></td>" +
    "</tr>" +
    "<tr>" +
        "<td colspan=2>" +
            "<input type=button value=\"Generate Ad Script\" onclick=\"GenerateAdScript();\" />" +
        "</td>" +
    "</tr>" +
    "<tr>" +
        "<td colspan=2>" +
            "<div id=outerTableScript></div>" +
        "</td>" +
    "</tr>" +
    "</table>";

    return htmlStr;
}

function GenerateAdScript() 
{
    var strScript =
    "<!-- Please check if the following 2 script includes are NOT already present in your web page -->\n" +
    "<!-- If any one or both script includes are found, then you can ignore the lines below accordingly. -->\n" + 
    "<script type=\"text/javascript\" language=\"javascript\" src=\"http://www.adplusplus.com/scripts/json2.js\"/>\n" + 
    "<script type=\"text/javascript\" language=\"javascript\" src=\"http://www.adplusplus.com/scripts/jquery-1.4.1.min.js\" />\n\n" + 
    "<script type=\"text/javascript\" language=\"javascript\" src=\"http://www.adplusplus.com/scripts/adplusplus.js\" />\n" + 
    "<script type=\"text/javascript\" language=\"javascript\">\n" + 
    "var myAd = \n" +
    "{\n" +
        "\t\t\t\tadkeywords: \"" + document.getElementById("adKeyWords").value + "\"" +
        ", addesc: \"" + document.getElementById("adDesc").value + "\"\n" +
    "};\n" +
    "<\/script>";

    var table = "<br><table id=ScriptDisplayTable >" +
    "<tr><td style='color:blue;font-weight:bold;font-size:large;backgorund-color:aqua'>The ad script has been generated below. <br>Please copy this to the header part of your Web Page. <A href=# class=standard_font onclick=\"copyScriptToClipboard();\">Copy To Clipboard</A></td></tr>" +
    "<tr><td align=left><div id=GeneratedScript class=standard_font style='padding:4px;background-color:yellow'></div></td></tr>" +
    "</table></div>";

    document.getElementById("outerTableScript").innerHTML = table;
    document.getElementById("GeneratedScript").innerText = strScript;
}
