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
	Dim lCode
	
	lCode = Request.Form("sCodes")
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivCodes.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lCodeDeleted
	
	' Update user details
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lCodeDeleted = lTSObj.DeleteCode(eval(lCode))

	if lCodeDeleted Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Code Deleted</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-codes-start.asp">Click here</A> to go to codes start page.</TD>
		</TR>
		</TABLE>	
	<% else 
		'  Code details not deleted %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Code Not Deleted</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-codes-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
 
 	Set lTSObj = Nothing
 %>
</BODY>
</HTML>