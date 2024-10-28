<HTML>
<HEAD>
<TITLE>Uploaded Project Files</TITLE>
<LINK REL=StyleSheet HREF="theme.css">
</HEAD>
<BODY>
<TABLE border=1 align=center width=75% class="tdbgdark" style="border-collapse:collapse">
<TR>
<TD align=left>
<FONT class=whiteboldtext>Browse the following Project Plans</FONT>
</TD>
<TR>
<TD>
<%
	Dim lFSO
	Dim lFolder
	Dim lFile
	Dim lFileName
	Dim lURL
	
	Set lFSO = CreateObject("Scripting.FileSystemObject")
	Set lFolder = lFSO.GetFolder("c:\inetpub\wwwroot\msproj\uploadfiles")
	
	For each lFile in lFolder.Files
		lFileName = Left(lFile.Name, Len(lFile.Name)-4)
		lURL = "tree-frames.asp?MSProject=" & lFileName
		
		Response.Write("<TR><TD class=tdbglight>" & "<A href='" & lURL & "'>" & lFileName & "</A>" & "</TD></TR>")
	Next
%>
</TD>
</TR>
</BODY>
</HTML>
