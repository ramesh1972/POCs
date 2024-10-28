<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../timesheet/theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies ("BugsGroupID")
	if lBugsGroupID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<%
	Dim lGroupID
	
	lGroupID = Request.Form("sBugsGroups")
%>
<% ' Check the type of user and redirect
	Dim lUserType
	
	lUserType = Request.Cookies("EmployeeType")
%>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="psdb-bugs-cat-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lSBObj
	Dim lModulesRs
	Dim lStatusRs
	Dim lPriorityRs
	Dim lSeverityRs
	
	' Get projects
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lModulesRs = Server.CreateObject ("ADODB.RecordSet")			
	Set lStatusRs = Server.CreateObject ("ADODB.RecordSet")
	Set lPriorityRs = Server.CreateObject ("ADODB.RecordSet")
	Set lSeverityRs = Server.CreateObject ("ADODB.RecordSet")

	Set lModulesRs = lSBObj.GetProjectModules ()
	Set lStatusRs = lSBObj.GetAllBugsStatus ()
	Set lPriorityRs = lSBObj.GetAllBugsPriority()
	Set lSeverityRs = lSBObj.GetAllBugsSeverity()

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
				Response.Write(trim(lModulesRs("M_ModuleID")))
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
	end if
		
	if lStatusRs.RecordCount > 0 Then
		' Display table 
%>
		<BR>
		<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
			<TD align="center"><font class="whiteboldtext">Status</font></TD>
		</TR>
		</TABLE>
		
		<TABLE border=1 width=50% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
		<TD width=25% align=center><B>Status ID</B></TD>
		<TD width=75% align=center><B>Status</B></TD>
		</TR>
	<%	
		while Not lStatusRs.EOF
			Response.Write("<TR STYLE='border-bottom:none;border-top:none' class=tdbglight> ")
			Response.Write("<TD valign='top'>")
			If trim(lStatusRs("S_StatusID")) <> "" Then
				Response.Write(trim(lStatusRs("S_StatusID")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lStatusRs("S_Status")) <> "" Then
				Response.Write(trim(lStatusRs("S_Status")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			
			Response.Write("</TR>")			
			lStatusRs.MoveNext			
		wend
		Response.Write("</TABLE>") 
	end if
		
	if lPriorityRs.RecordCount > 0 Then
		' Display table 
%>
		<BR>
		<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
			<TD align="center"><font class="whiteboldtext">Priority</font></TD>
		</TR>
		</TABLE>
		
		<TABLE border=1 width=50% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
		<TD width=25% align=center><B>Priority ID</B></TD>
		<TD width=75% align=center><B>Priority</B></TD>
		</TR>
	<%	
		while Not lPriorityRs.EOF
			Response.Write("<TR STYLE='border-bottom:none;border-top:none' class=tdbglight> ")
			Response.Write("<TD valign='top'>")
			If trim(lPriorityRs("P_PriorityID")) <> "" Then
				Response.Write(trim(lPriorityRs("P_PriorityID")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lPriorityRs("P_Priority")) <> "" Then
				Response.Write(trim(lPriorityRs("P_Priority")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			
			Response.Write("</TR>")			
			lPriorityRs.MoveNext			
		wend
		Response.Write("</TABLE>") 
	end if
	
	if lSeverityRs.RecordCount > 0 Then
		' Display table 
%>
		<BR>
		<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
			<TD align="center"><font class="whiteboldtext">Severity</font></TD>
		</TR>
		</TABLE>
		
		<TABLE border=1 width=50% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
		<TD width=25% align=center><B>Severity ID</B></TD>
		<TD width=75% align=center><B>Severity</B></TD>
		</TR>
	<%	
		while Not lSeverityRs.EOF
			Response.Write("<TR STYLE='border-bottom:none;border-top:none' class=tdbglight> ")
			Response.Write("<TD valign='top'>")
			If trim(lSeverityRs("S_SeverityID")) <> "" Then
				Response.Write(trim(lSeverityRs("S_SeverityID")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lSeverityRs("S_Severity")) <> "" Then
				Response.Write(trim(lSeverityRs("S_Severity")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			
			Response.Write("</TR>")			
			lSeverityRs.MoveNext			
		wend
		Response.Write("</TABLE>") %>

		<% if lUserType = "A" Then %>
			<BR>
			<TABLE width=50% align="center">
			<TR>
				<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'></TD>
			</TR>
			</TABLE>
		<% end if %>
<%
    end if 
 
 	Set lTSObj = Nothing
	Set lModulesRs = Nothing
	Set lStatusRs = Nothing
	Set lPriorityRs = Nothing
	Set lSeverityRs = Nothing
 %>
</BODY>
</HTML>
