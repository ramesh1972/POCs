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
	Dim lRegistered
	Dim lFromAddUser
			
	lValidLogin = false
	lEmpID = Request.Form ("ebEmpID")
	lEmpName = Request.Form("ebEmpName")
	lPassword = Request.Form ("ebPassword")      
	lFromAddUser = Request.Form ("hFromAddUser")
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lRegistered = lTSObj.RegisterUser (eval(lEmpID), lEmpName, lPassword)
	
	Set lTSObj = nothing
	if lRegistered Then
		If lFromAddUser = "Y" Then
			Response.Redirect("psdb-bugs-cat-start.asp")
		End if
%>
		<br><br><br>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Registration Successful</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center">Contact your administrator to add yourself to a project.</TD>
		</TR>
		</TABLE>	
<%
	else
%>
		<br><br><br>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Registration Failed</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-register-start.asp">Click here</A> to go to try again</TD>
		</TR>
		</TABLE>	
<% end if %>
</body>
</html>
