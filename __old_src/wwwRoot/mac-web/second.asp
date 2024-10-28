<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%
Set lObj = Server.CreateObject("WebTest.WebTestMgr") 
Call lObj.DisplayString(lMsg)

Response.Write("Message = " & lMsg & "<BR>")
%>
</BODY>
</HTML>
