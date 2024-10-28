<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<%
Dim lURL 
Dim lOutLook

lURL = Request.QueryString("Subject")
if lURL = "" Then
	lURL = Request.Form("ebURL")
end if

Response.Write(lURL)

Set lOutLook = Server.CreateObject("SendLink.Class1")
Call lOutLook.GetPage(lURL) 
%>
<BODY>
<!-- #include file="www.asp" -->
</BODY>
</HTML>
