<%@ Language=VBScript %>
<% Option Explicit
	Dim lid 
	Dim ltitle
	Dim ldesc
	Dim lmodule
	Dim lstatus
	Dim lpriority
	Dim lrepby
	Dim lresp
	Dim lfixby
	Dim lfixed_date
	Dim lverified_date
	Dim lverby
	Dim llast_mod	
	Dim lprev_status
	
	Dim server_obj
	Dim sql_str
	Dim sql_str1	
	Dim sql_str2
	Dim rec
	Dim rst
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../Includes/theme.css">
</HEAD>
<BODY>
<!-- #include file="../Includes/header.inc" -->
<BR>
<%	lid = Request.Form("hIdentifier") 
	ltitle = Request.Form("ebTitle")
	ldesc = Request.Form("taDescription")
	lmodule = Request.Form("cbModule")
	lstatus = Request.Form("cbStatus")
	lpriority = Request.Form("cbPriority")	
	lrepby = Request.Form("cbReportedBy")
	lresp = Request.Form("cbResponsibility")
	lfixby = Request.Form("cbFixedBy")
	lverby = Request.Form("cbVerifiedBy")
	
	if lmodule = "All" Then
		lmodule = ""
	End if
	if lstatus = "All" Then
		lstatus = ""
	End if
	if lpriority = "All" Then
		lpriority = ""
	End if
	if lrepby = "All" Then
		lrepby = ""
	End if
	if lresp = "All" Then
		lresp = ""
	End if
	if lfixby = "All" Then
		lfixby = ""
	End if
	if lverby = "All" Then
		lverby = ""
	End if
	if lmodule = "All" Then
		lmodule = ""
	End if

	Set server_obj = Server.CreateObject("ADODB.Connection")
	server_obj.Open "PSDB", "sa", "bce@testing"
	
	Set rec = Server.CreateObject ("ADODB.RecordSet")
	sql_str = "Select Status, FixedDate, VerifiedDate From PS_Reports Where Identifier = " & lid
	
	Set rec = server_obj.Execute (sql_str)
	lprev_status = trim(rec("Status"))

	lfixed_date = trim(rec("FixedDate"))
	lverified_date = trim(rec("VerifiedDate"))
	
	If lprev_status = "New" Or lprev_status = "In Process" Then
		if lstatus = "Fixed" Then
			lfixed_date = FormatDateTime(Now(), vbGeneralDate)
		Elseif lstatus = "Verified" Then
			lverified_date = FormatDateTime(Now(), vbGeneralDate)
		End if
	Elseif lprev_status = "Fixed" Then
		If lstatus = "Verified" Then
			lverified_date = FormatDateTime(Now(), vbGeneralDate)
		End If
	End If

	llast_mod = FormatDateTime(Now(), vbGeneralDate)		
	sql_str1 = "Update PS_Reports Set " & _ 
				"ShortDescription = '" & ltitle & "'," & _
				"LongDescription = '" & ldesc & "'," & _
				"Module = '" & lmodule & "'," & _
				"Status = '" & lstatus & "'," & _	
				"Priority = '" & lpriority & "'," & _
				"ReportedBy = '" & lrepby & "'," & _
				"Responsibility = '" & lresp & "'," & _
				"FixedBy = '" & lfixby & "'," & _
				"VerifiedBy = '" & lverby & "'," & _
				"LastModified = '" & llast_mod & "'"
	
	If (lfixed_date <> "") Then
		sql_str1 = sql_str1 & ",FixedDate = '" & lfixed_date & "'" 
	End If
				
	If (lverified_date <> "") Then
		sql_str1 = sql_str1 & ",VerifiedDate = '" & lverified_date & "'" 
	End If
								
	sql_str1 = sql_str1 & " Where Identifier = " & lid	
		
	server_obj.Execute sql_str1
%>
<TABLE align="left">
<TR>
	<TD><A href="psdb-system-start.asp">Start Page</A>&nbsp&nbsp&nbsp<A href="psdb-problem-query.asp">Query Page</A></TD>
	
</TR>
</TABLE>
<TABLE align="center">
<TR>
	<TD><B>List of Problems</B></TD>
</TR>
</TABLE>
<%
	Set rst = Server.CreateObject("ADODB.Recordset")
    sql_str2 = "Select * from PS_Reports Order By ReportedDate desc"

	Set rst = server_obj.Execute (sql_str2)
	
	If Not (rst.EOF And rst.BOF) Then
		Response.Write("<TABLE align=center border=1 class=tdbgdark>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><font class=whiteboldtext>Identifier</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Module</font></TD>")		
		Response.Write("<TD align=center><font class=whiteboldtext>Short Description</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Status</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Priority</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Estimated Time</font></TD>")														
		Response.Write("<TD align=center><font class=whiteboldtext>Reported By</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Reported Date</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Responsibility</font></TD>")														
		Response.Write("<TD align=center><font class=whiteboldtext>Fixed By</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Fixed Date</font></TD>")						
		Response.Write("<TD align=center><font class=Whiteboldtext>Verified By</font></TD>")
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
