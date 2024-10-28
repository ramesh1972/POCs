<%@ Language=VBScript %>
<% Response.Buffer=true %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>Login</title>
<LINK REL=StyleSheet HREF="theme.css" >
</head>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="psdb-header.asp" -->
<BR>
<%	' Get the employee id and password
	Dim lTSObj 
	Dim lEmpID
	Dim lPassword
	Dim lValidLogin
	Dim lUserType
		
	lValidLogin = false
	lEmpID = Request.Form ("ebEmpID")
	lPassword = Request.Form ("ebPassword")      
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lValidLogin = lTSObj.CheckIfValidLogin (eval(lEmpID), lPassword)
	
	if lValidLogin Then
		Response.Cookies("EmployeeID") = lEmpID
		Set lTSObj = nothing
		Response.Redirect("psdb-bugs-group-select.asp")
	else
%>
<br><br><br><br>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Invalid Employee ID or Password</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-logon-start.asp">Click here</A> to go to Login again</TD>
</TR>
</TABLE>	
<% end if 
Set lTSObj = nothing %>
</body>
</html>
