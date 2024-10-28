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
<%
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies ("BugsGroupID")
%>
<%
	Dim lGroupID
	
	lGroupID = Request.Form("sBugsGroups")
%>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="psdb-bugs-cat-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lProjectID
	Dim lSBObj
	Dim lModulesRs
	
	' Get projects
	lProjectID = Request.Form("sGroups")
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lModulesRs = Server.CreateObject ("ADODB.RecordSet")			
	Set lModulesRs = lSBObj.GetProjectModules (eval(lProjectID),0)

	if lModulesRs.RecordCount > 0 Then
		' Display table 
%>
		<TABLE border=1 width=75% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
			<TD align="center"><font class="whiteboldtext">Modules</font></TD>
		</TR>
		</TABLE>
		
		<TABLE border=1 width=75% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
		<TD width=20% align=center><B>Module ID</B></TD>
		<TD width=40% align=center><B>Module Name</B></TD>
		<TD width=40% align=center><B>Module Description</B></TD>
		</TR>
	<%	
		while Not lModulesRs.EOF
			Response.Write("<TR STYLE='border-bottom:none;border-top:none' class=tdbglight> ")
			Response.Write("<TD valign='top'>")
			If trim(lModulesRs("M_ModuleID")) <> "" Then
				Response.Write("<A href='psdb-groups-modules-detete-confirm.asp?ProjectID=" & lProjectID & "&ModuleID=" & eval(trim(lModulesRs("M_ModuleID"))) & "'>" & trim(lModulesRs("M_ModuleID")) & "</A>")
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lModulesRs("M_ModuleName")) <> "" Then
				Response.Write(trim(lModulesRs("M_ModuleName")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			
			Response.Write("<TD valign='top'>")
			If trim(lModulesRs("M_ModuleDescription")) <> "" Then
				Response.Write(trim(lModulesRs("M_ModuleDescription")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("</TR>")			
			lModulesRs.MoveNext			
		wend
		Response.Write("</TABLE>")
	else
%>
		<TABLE border=1 width=75% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
			<TD align="center"><font class="whiteboldtext">No Modules in this Project</font></TD>
		</TR>
		</TABLE>
<%
	end if
		
 	Set lTSObj = Nothing
	Set lModulesRs = Nothing
 %>
 	<TABLE width=50% align="center">
	<TR>
		<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua' id=button1 name=button1></TD>
	</TR>
	</TABLE>
</BODY>
</HTML>
