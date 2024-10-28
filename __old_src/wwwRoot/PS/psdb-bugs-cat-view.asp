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
		Response.Redirect("ts-logon-start.asp")
	end if
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
	Dim lSBObj
	Dim lStatusRs
	Dim lPriorityRs
	Dim lSeverityRs
	
	' Get projects
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lStatusRs = Server.CreateObject ("ADODB.RecordSet")
	Set lPriorityRs = Server.CreateObject ("ADODB.RecordSet")
	Set lSeverityRs = Server.CreateObject ("ADODB.RecordSet")

	Set lStatusRs = lSBObj.GetAllBugsStatus ()
	Set lPriorityRs = lSBObj.GetAllBugsPriority()
	Set lSeverityRs = lSBObj.GetAllBugsSeverity()

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
	Set lStatusRs = Nothing
	Set lPriorityRs = Nothing
	Set lSeverityRs = Nothing
 %>
</BODY>
</HTML>
