<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<%
	Dim lObj
	Dim c
	
	Set lObj = Server.CreateObject ("atlserver.TestATL")
	
	c = lObj.Add (20,40)
	Response.Write("Sum of 10 and 20 = " & c & "<br>")
%>
<BODY>

<P>&nbsp;</P>

</BODY>
</HTML>
