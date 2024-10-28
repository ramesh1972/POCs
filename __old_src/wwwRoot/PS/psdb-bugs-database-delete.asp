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
	Dim lGroupName
	
	lGroupName = Request.Form("sGroups")
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
	Dim lBugsObj
	Dim lProjectID
	Dim lDatabaseRs
				
	' Get projects
	Set lBugsObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lDatabaseRs = Server.CreateObject ("ADODB.RecordSet")
	lProjectID = Request.Form("sGroups")
	Set lDatabaseRs = 	lBugsObj.GetBugsDatabase(eval(lProjectID), 0)
	 
	if lDatabaseRs.RecordCount > 0 Then
		' Display table 
		Response.Write("<TABLE align=center>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><B>Bugs Database Details</B></TD>")
		Response.Write("</TR>")			
		Response.Write("</TABLE>")
		
		Response.Write("<TABLE valign='top' align=center border=1 class=tdbgdark STYLE='BORDER-COLLAPSE: collapse'>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><font class=whiteboldtext>Bugs Database ID</TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Bugs Database Name</font></TD>")		
		Response.Write("<TD align=center><font class=whiteboldtext>Bugs Database Description</font></TD>")
		Response.Write("</TR>")			
				
		while Not lDatabaseRs.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD valign='top'>")
			If trim(lDatabaseRs("G_GroupID")) <> "" Then
				Response.Write("<A href=psdb-bugs-database-delete-confirm.asp?ProjectID=" & lProjectID & "&BugsDatabaseID=" & trim(lDatabaseRs("BD_DatabaseID")) & ">" & trim(lDatabaseRs("BD_DatabaseID")) & "</A>")
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lDatabaseRs("DB_Name")) <> "" Then
				Response.Write(trim(lDatabaseRs("DB_Name")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lDatabaseRs("DB_Description")) <> "" Then
				Response.Write(trim(lDatabaseRs("DB_Description")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			Response.Write("</TR>")
			lDatabaseRs.MoveNext 
		wend
		Response.Write("</TABLE>") %>
		<TABLE width=50% align="center">
		<TR>
			<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'></TD>
		</TR>
		</TABLE>
		<%
	else 
		' Display Group details not available %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Database details not available</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
 
 	Set lTSObj = Nothing
	Set lDatabaseRs = Nothing
 %>
</BODY>
</HTML>
