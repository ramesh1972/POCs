<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body style='margin:0px'>
<form id=mainForm method=post runat=server>
<table class=standard_font>
    <tr>
        <td>Enter keywords for the Web Page<br /> that you want to advertise (Separate multiple keywords by comma)</td>
        <td><input type=text id=adKeyWords maxlength=55 size=60 /></td>
    </tr>
    <tr>
        <td>Enter the description of your ad</td>
        <td><textarea id=adDesc rows=3 cols=40></textarea></td>
    </tr>
    <tr>
        <td colspan=2>
            <input type=button value="Generate Ad Script" onclick="GenerateAdScript();" />
        </td>
    </tr>
</table>


<table id=ScriptDisplayTable class=generated_script border=1 style="visibility:hidden">
<tr><td align=right class=standard_font onclick="copyScriptToClipboard();"><A href=#>Copy To Clipboard</A></td></tr>
<tr><td align=left class=standard_font><div id=GeneratedScript></div></td></tr>
</table>

</form>
<u><a href=# class=adclass>Ramesh</a></u>
</body>
</html>
