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
<% ' Get Code
	Dim lProjectID
	
	lProjectID = Request.Form("sProjects")
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivProjects.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lProjectDeleted
	
	' Update user details
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lProjectDeleted = lTSObj.DeleteProject (eval(lProjectID))

	if lProjectDeleted Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Project Deleted</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-projects-start.asp">Click here</A> to go to Projects start page.</TD>
		</TR>
		</TABLE>	
	<% else 
		'  Code details not deleted %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Project Not Deleted</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-projects-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
 
 	Set lTSOb = nothing
 %>
</BODY>
</HTML>
