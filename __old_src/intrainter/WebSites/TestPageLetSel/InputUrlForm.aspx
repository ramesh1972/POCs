<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InputUrlForm.aspx.cs" Inherits="InputUrlForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<script type="text/javascript" language=javascript src="Scripts/Main.js"/>
<script type="text/javascript" language=javascript src="Scripts/ExternalDOM.js"></script>

</head>
<body style='margin:0;padding:0;background-color:Red'>
<table width=100% height=100% cellpadding=0 cellspacing=0 style='margin:0;padding:0;backgroundcolor:Red'>
<tr valign=middle align=left>
<td height=100>Enter Search Terms Or Enter URL to Browse<br />
<input type=text name="EnterTextOrUrl" id="EnterTextOrUrl" size=150 value="http://thehindu.com" />&nbsp;<input type=button id="EnterButton" value="Go"  size=50 onclick="OnEnterClick();" onkeypress="OnEnterClick();"/>
</td>
</tr>
</table>    
</body>
</html>
