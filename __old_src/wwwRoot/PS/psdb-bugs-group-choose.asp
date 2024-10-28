<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
<%
	Dim lProjectID
	Dim lDatabaseID
			
	lProjectID = Request.QueryString("ProjectID")
	lDatabaseID = Request.QueryString("BugsDatabaseID")
	
	if lProjectID = "" Or lDatabaseID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")	
	end if
%>

<%  ' Check if the user is logged in
	Dim lEmpID
	Dim lEmpAdmin
	Dim lEmpProjectLead
	Dim lEmpDeveloper
	Dim lEmpTester
	Dim lTSObj
		
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lEmpAdmin = lTSObj.CheckIfAdministrator(eval(lEmpID))
	lEmpProjectLead = lTSObj.CheckIfGroupLead(eval(lEmpID), eval(lProjectID))
	lEmpDeveloper = lTSObj.CheckIfDeveloper(eval(lEmpID), eval(lProjectID))
	lEmpTester = lTSObj.CheckIfTester(eval(lEmpID), eval(lProjectID))
%>
<% ' Get the Employee Name
	Dim lValidUser

	' Get projects
	if lEmpAdmin = false Then
		lValidUser = lTSObj.CheckIfUserMemberOfGroup(eval(lEmpID), eval(lProjectID))
	else
		lValidUser = true
	end if
%>
</head>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<% 
	if lValidUser Then 
		Response.Cookies ("BugsProjectID") = lProjectID
		Response.Cookies ("BugsDatabaseID") = lDatabaseID
		Response.Redirect ("psdb-bugs-report-select.asp?ProjectID=" + lProjectID + "&BugsDatabaseID=" + lDatabaseID + "&EmployeeID=" + lEmpID)
	end if

	Response.Redirect("psdb-bugs-group-select.asp?ValidUser=false")
%>	
</body>
</html>
