<% 
	Dim db_conn
	Dim rst
	
	Dim sql_str1
%>
	
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../Includes/theme.css">
</HEAD>
<BODY>
<!-- #include file="../Includes/header.inc" -->
<BR>
<TABLE align="center" width=650>
<TR>
	<TD align=left><A href="psdb-user-start.asp">Start Page</A></TD>
</TR>
</TABLE>
<TABLE align="center">
<TR>
	<TD><B>List of Problems</B></TD>
</TR>
</TABLE>
<%
	Set objUser = Server.CreateObject ("User.clsUser")

	Set rst = Server.CreateObject("ADODB.Recordset")
	Set rst = objUser.ViewProblems()
	
	If Not (rst.EOF And rst.BOF) Then
		Response.Write("<TABLE align=center border=1 class=tdbgdark>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><font class=whiteboldtext>Identifier</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Short Description</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Status</font></TD>")		
		Response.Write("<TD align=center><font class=whiteboldtext>Reported By</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Reported Date</font></TD>")						
		Response.Write("</TR>")		
		
		While Not rst.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD >")
			If rst("Identifier") <> "" Then
				Response.Write("<A href=psdb-problem-longdesc.asp?Identifier=" & rst("Identifier") & ">" & rst("Identifier") & "</A>")
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("ShortDescription") <> "" Then
				Response.Write(rst("ShortDescription"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

 			Response.Write("<TD>")
			If rst("Status") <> "" Then
				Response.Write(rst("Status"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("ReportedBy") <> "" Then
				Response.Write(rst("ReportedBy"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("ReportedDate") <> "" Then
				Response.Write(rst("ReportedDate"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("</TR>")
			rst.MoveNext
		Wend
		Response.Write("</TABLE>")
	Else
		Response.Write("No data in the database")
	End If
%>
<BR>
<!-- #include file="../Includes/footer.inc" -->
</BODY>
</HTML>
