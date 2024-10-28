<% 
	Dim db_conn
	Dim rst
	
	Dim sql_str2
	Dim where_clause 
	
	Dim lmodule1
	Dim lstatus1
	Dim lpriority1
	Dim lrepby1
	Dim lresp1
	Dim lfixedby1
	Dim lverby1
	
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
	<TD><A href="psdb-system-start.asp">Start Page</A>&nbsp&nbsp&nbsp<A href="psdb-problem-query.asp">Query Page</A></TD>
	
</TR>
</TABLE>

<TABLE align=center>
<TR>
	<TD><B>List of Problems</B></TD>
</TR>
</TABLE>
<%
	lmodule1 = Request.Form("cbModule")
	lstatus1 = Request.Form("cbStatus")
	lpriority1 = Request.Form("cbPriority")
	lrepby1 = Request.Form("cbReportedBy")
	lresp1 = Request.Form("cbResponsibility")
	lfixedby1 = Request.Form("cbFixedBy")
	lverby1 = Request.Form("cbVerifiedBy")

	Set db_conn = Server.CreateObject("ADODB.Connection")
	db_conn.Open "PSDB", "sa", "bce@testing"
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	
    sql_str2 = "Select * from PS_Reports"
	where_clause = ""
	If (lmodule1 <> "All") Then
		where_clause = "Module = '" & lmodule1 & "'"
	End if
	
	If (lstatus1 <> "All") Then
		If where_clause  <> "" Then
			where_clause = where_clause & " AND Status = '" & lstatus1 & "'"
		Else
			where_clause = " Status = '" & lstatus1 & "'"
		End if
	End if 

	If (lpriority1 <> "All") Then
		If where_clause  <> "" Then
			where_clause = where_clause & " AND Priority = '" & lpriority1 & "'"
		Else
			where_clause = " Priority = '" & lpriority1 & "'"
		End if
	End if 

	If (lrepby1 <> "All") Then
		If where_clause  <> "" Then
			where_clause = where_clause & " AND ReportedBy = '" & lrepby1 & "'"
		Else
			where_clause = " ReportedBy = '" & lrepby1 & "'"
		End if
	End if 

	If (lresp1 <> "All") Then
		If where_clause  <> "" Then
			where_clause = where_clause & " AND Responsibility = '" & lresp1 & "'"
		Else
			where_clause = " Responsibility = '" & lresp1 & "'"
		End if
	End if 

	If (lfixedby1 <> "All") Then
		If where_clause  <> "" Then
			where_clause = where_clause & " AND FixedBy = '" & lfixedby1 & "'"
		Else
			where_clause = " FixedBy = '" & lfixedby1 & "'"
		End if
	End if 

	If (lverby1 <> "All") Then
		If where_clause  <> "" Then
			where_clause = where_clause & " AND VerifiedBy = '" & lverby1 & "'"
		Else
			where_clause = " VerifiedBy = '" & lverby1 & "'"
		End if
	End if 

	if (where_clause <> "") Then
		sql_str2 = sql_str2 & " Where " & where_clause
	End if
		
	sql_str2 = sql_str2 & " Order By ReportedDate desc"
	
	Set rst = db_conn.Execute (sql_str2)
	
	If Not (rst.EOF And rst.BOF) Then
		Response.Write("<TABLE align=center border=1 class=tdbgdark>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><font class=whiteboldtext>Identifier</TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Module</font></TD>")		
		Response.Write("<TD align=center><font class=whiteboldtext>Short Description</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Status</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Priority</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Reported By</font></TD>")
		Response.Write("<TD width=50 align=center><font class=whiteboldtext>Reported Date</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Responsibility</font></TD>")														
		Response.Write("<TD align=center><font class=whiteboldtext>Fixed By</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Fixed Date</font></TD>")						
		Response.Write("<TD align=center><font class=whiteboldtext>Verified By</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Verified Date</font></TD>")						
		Response.Write("</TR>")		
		
		While Not rst.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD >")
			If rst("Identifier") <> "" Then
				Response.Write("<A href=psdb-edit-problem.asp?Identifier=" & rst("Identifier") & ">" & rst("Identifier") & "</A>")
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
