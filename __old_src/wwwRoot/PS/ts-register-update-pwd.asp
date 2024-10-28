<%@ Language=VBScript %>
<% Response.Buffer=true %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivLogon.style.background = "lightblue";
</script>
<BR>
<%	' Get the employee id and password
	Dim lTSObj 
	Dim lEmpID
	Dim lOldPassword
	Dim lNewPassword
	Dim lValidLogin
	
	lValidLogin = false
				
	lEmpID = Request.Form ("ebEmpID")
	lOldPassword = Request.Form ("ebOldPassword")      
	lNewPassword = Request.Form ("ebNewPassword")      

	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lValidLogin = lTSObj.CheckIfValidLogin (eval(lEmpID), lOldPassword)
	
	if Not lValidLogin Then
%>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Invalid Login Id or Password</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-register-change-pwd.asp">Click here</A> to go to try again</TD>
</TR>
</TABLE>	
<% else 
	Dim lPwdChanged
	lPwdChanged = lTSObj.ChangePwd (eval(lEmpID), lNewPassword)
	if lPwdChanged Then
%>
<br><br><br>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Password changed</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-logon-start.asp">Click here</A> to Logon</TD>
</TR>
</TABLE>	
<% else %>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Failed to change password</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-register-change-pwd.asp">Click here</A> to go to try again</TD>
</TR>
</TABLE>	
<% end if %>
<% end if 
	Set lTSObj = nothing%>
</body>
</html>
