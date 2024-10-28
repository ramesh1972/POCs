<% Response.Buffer = true %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
dim lredURL
Dim lWATLObj
Dim lFSO
Dim lTS
Dim lText

lredURL = Request.QueryString("redirectURL") 

Set lWATLObj = Server.CreateObject("www_atl.Class1")
Call lWATLObj.LoadPage(lredURL) 
Response.Write("hello")
'while lWATLObj.GetPageStatus() <> 4 
'wend 

'Set lFSO = CreateObject("Scripting.FileSystemObject")
'Set lTS = CreateObject("Scripting.TextStream")

'Set lTS = lFSO.OpenTextFile("test.htm")
'lText = lTS.Read()

'Response.Write lText
%>

</BODY>
</HTML>
