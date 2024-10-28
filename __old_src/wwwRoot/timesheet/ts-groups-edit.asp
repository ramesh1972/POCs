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
	Dim lGroupID
	Dim lGroupName
	Dim lGroupDescription
	Dim lGroupLeader

	lGroupID = Request.Form("hGroupID")
	lGroupName = Request.Form("ebGroupName")
	lGroupDescription = Request.Form("taGroupDesc")
	lGroupLeader = Request.Form("sUsers")
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivGroups.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lGroupUpdated
	
	' Update user details
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lGroupUpdated = lTSObj.UpdateGroupProfile (eval(lGroupID), lGroupName, lGroupDescription, lGroupLeader)

	if lGroupUpdated Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Group details Updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-groups-start.asp">Click here</A> to go to groups start page.</TD>
		</TR>
		</TABLE>	
	<% else 
		' Display User details not updated %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Group details not updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-groups-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
 	Set lTSObj = Nothing
 %>
</BODY>
</HTML>
