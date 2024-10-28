<% 
	Dim db_conn
	Dim rst
	
	Dim sql_str2
%>
	
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../Includes/theme.css">
</HEAD>
<BODY>
<!-- #include file="../Includes/header.inc" -->
<BR>
<TABLE align="left">
<TR>
	<TD><A href="psdb-system-start.asp">Start Page</A></TD>
	
</TR>
</TABLE>

<TABLE align=center>
<TR>
	<TD><B>Delete Problems</B></TD>
</TR>
</TABLE>
<%
	Set db_conn = Server.CreateObject("ADODB.Connection")
	db_conn.Open "PSDB", "sa", "bce@testing"
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	
    sql_str2 = "Select * from PS_Reports Order By ReportedDate desc"
	Set rst = db_conn.Execute (sql_str2)
	
	If Not (rst.EOF And rst.BOF) Then
		Response.Write("<TABLE align=center border=1 class=tdbgdark>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Identifier</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Module</FONT></TD>")		
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Short Description</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Status</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Priority</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Estimated Time</FONT></TD>")														
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Reported By</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Reported Date</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Responsibility</FONT></TD>")														
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Fixed By</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Fixed Date</FONT></TD>")						
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Verified By</FONT></TD>")
		Response.Write("<TD align=center><FONT CLASS=whiteboldtext>Verified Date</FONT></TD>")						
		Response.Write("</TR>")		
		
		While Not rst.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD >")
			If rst("Identifier") <> "" Then
				Response.Write("<A href=psdb-delete-confirm.asp?Identifier=" & rst("Identifier") & ">" & rst("Identifier") & "</A>")
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD >")
			If rst("Module") <> "" Then
				Response.Write(rst("Module"))
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
			If rst("Priority") <> "" Then
				Response.Write(rst("Priority"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

 			Response.Write("<TD>")
			If rst("EstimatedTime") <> "" Then
				Response.Write(rst("EstimatedTime"))
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

			Response.Write("<TD>")
			If rst("Responsibility") <> "" Then
				Response.Write(rst("Responsibility"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("FixedBy") <> "" Then
				Response.Write(rst("FixedBy"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("FixedDate") <> "" Then
				Response.Write(rst("FixedDate"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("VerifiedBy") <> "" Then
				Response.Write(rst("VerifiedBy"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("VerifiedDate") <> "" Then
				Response.Write(rst("VerifiedDate"))
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
