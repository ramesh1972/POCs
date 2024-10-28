<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<% 'Get the required data from the form
	Dim lEmployeeID
	Dim lEmpName
	Dim lAdministrator

	lEmployeeID = Request.Form("hEmpID")
	lEmpName = Request.Form("ebEmpName")
	lAdministrator = Request.Form("cbAdministrator")
	if lAdministrator = "on" Then
		lAdministrator = "Y"
	else
		lAdministrator ="N"
	end if
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivUsers.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lUserUpdated
	
	' Update user details
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lUserUpdated = lTSObj.UpdateUserProfile  (lEmployeeID, lEmpName, lAdministrator)

	if lUserUpdated Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">User details Updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-users-start.asp">Click here</A> to go to users start page.</TD>
		</TR>
		</TABLE>	
	<% else 
		' Display User details not updated %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">User details not updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-users-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
  	Set lTSObj = Nothing
 %>
</BODY>
</HTML>
