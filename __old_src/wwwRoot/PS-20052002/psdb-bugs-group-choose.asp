<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title>Login</title>
<LINK REL=StyleSheet HREF="../timesheet/theme.css" >
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%
	Dim lGroupID
	
	lGroupID = Request.Form("sBugsGroups")
%>
<% ' Get the Employee Name
	Dim lValidUser
	Dim lTSObj

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lValidUser = lTSObj.CheckIfUserMemberOfGroup(eval(lEmpID), eval(lGroupID))
	
	Set lTSObj = Nothing
%>
</head>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->

<% 
	if lValidUser Then 
		Response.Cookies ("BugsGroupID") = lGroupID
		Response.Redirect ("psdb-bugs-report-select.asp")
	end if


	Response.Redirect("psdb-bugs-group-select.asp?ValidUser=false")
%>	
</body>
</html>
