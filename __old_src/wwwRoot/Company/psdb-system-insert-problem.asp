<%@ Language=VBScript %>
<% Option Explicit
	Dim lname 
	Dim ltitle
	Dim ldesc
	Dim ldate
	
	Dim server_obj
	Dim sql_str
	dim x
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%	lname = Request.Form("ebName") 
	ltitle = Request.Form("ebTitle")
	ldesc = Request.Form("taDescription")
	ldate = FormatDateTime(Now(), vbGeneralDate)
	
	Set server_obj = Server.CreateObject("ADODB.Connection")
	server_obj.Open "PSDB", "sa", "bce@testing"
	
	sql_str = "Insert into PS_Reports (ReportedBy, ShortDescription, LongDescription, Status, ReportedDate, System) VALUES" _
				& "( '" & lname & "','" & ltitle & "','" & ldesc & "','" & "New" & "','" & ldate & "','" & "BCE" & "')"			
	
	server_obj.Execute sql_str
	
%>

<!-- #include File="psdb-system-start.asp" --> 


</BODY>
</HTML>
