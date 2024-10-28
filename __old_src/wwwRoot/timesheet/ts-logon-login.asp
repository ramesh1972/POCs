<%@ Language=VBScript %>
<% Response.Buffer=true %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>Login</title>
<LINK REL=StyleSheet HREF="theme.css" >
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivLogon.style.background = "lightblue";
</script>
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
	lValidLogin = lTSObj.CheckIfValidLogin(eval(lEmpID), lPassword)
	
	if lValidLogin Then
		Response.Cookies("EmployeeID") = lEmpID
		
		' Check if user is Administrator
		Dim lAdmin 
		lAdmin = lTSObj.CheckIfAdministrator(eval(lEmpID))
		if ( lAdmin = true) Then
			Response.Cookies("EmployeeType") = "A"
			Set lTSObj = nothing
			Response.Redirect("ts-weekly-timesheet-start.asp")
		End if
		
		' Check if user is group leader
		if (lTSObj.CheckIfGroupLead(eval(lEmpID)) = true) Then
			Response.Cookies("EmployeeType") = "G"
			Set lTSObj = nothing
			Response.Redirect("ts-weekly-timesheet-start.asp")
		End if

		' Otherwise normal user
		Response.Cookies("EmployeeType") = "U"
		Set lTSObj = nothing
		Response.Redirect("ts-weekly-timesheet-start.asp")
	else
%>
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
