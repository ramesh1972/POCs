<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<script language=javascript>
function HighlightDatabase(piDatabaseID) {
	var oDiv = document.all("oDivDB" + piDatabaseID);
	oDiv.style.color ="green";
}
</script>
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
</HEAD>
<script language="javascript">
function LoadReportPage(piProjectID, piDatabaseID) {
	parent.location.href = "psdb-bugs-group-choose.asp?ProjectID=" + piProjectID + "&BugsDatabaseID=" + piDatabaseID;
}

function here() {
}
</script>
<BODY align="center" topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<%
	Dim lDatabaseID
	Dim lProjectIDFromCookie	
	
	lDatabaseID = Request.Cookies("BugsDatabaseID")
	if lDatabaseID = "" Then
		lDatabaseID = 0
	end if

	lProjectIDFromCookie = Request.Cookies("BugsProjectID")
	if lProjectIDFromCookie = "" Then
		lProjectIDFromCookie = 0
	end if
%>

<% 'Get all required data from the database
	Dim lBugsObj
	Dim lProjectID
	Dim lDatabaseRs
				
	' Get projects
	Set lBugsObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lDatabaseRs = Server.CreateObject ("ADODB.RecordSet")
	lProjectID = ""
	lProjectID = Request.Form("sGroups")
	
	if lProjectID = "" Then
		lProjectID = Request.QueryString("ProjectID")
	end if
		
	if lProjectID = "" Then
		lProjectID = 0
	end if
	
	Set lDatabaseRs = 	lBugsObj.GetBugsDatabase(eval(lProjectID), 0)
	 
	if lDatabaseRs.RecordCount > 0 Then
		Response.Write("<BR><TABLE valign='top' align=center border=0 class=tdbgdark STYLE='BORDER-COLLAPSE: collapse'>")
%>
		<TR>
			<TD><font class="whiteboldtext">Select Bugs Database for this project</font></TD>
		</TR>
<%				
		while Not lDatabaseRs.EOF
			Response.Write("<TR bgcolor=white> ")
			Response.Write("<TD valign='top'>")
			If trim(lDatabaseRs("G_GroupID")) <> "" Then
				Response.Write("<A href='javascript:here();' onclick='LoadReportPage(" & lProjectID & "," & eval(trim(lDatabaseRs("BD_DatabaseID"))) & ");'>" & "<div id='oDivDB" & eval(trim(lDatabaseRs("BD_DatabaseID"))) & "' name='oDivDB" & eval(trim(lDatabaseRs("BD_DatabaseID"))) & "'>" & trim(lDatabaseRs("DB_Name")) & "</div></A>")
				if trim(lDatabaseRs("DB_Description")) <> "" Then
					Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;<font color=red size=4><B>.</B></font>&nbsp;" & trim(lDatabaseRs("DB_Description")))
				end if
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			Response.Write("</TR>")
			lDatabaseRs.MoveNext 
		wend
		Response.Write("</TABLE>") 
	else 
		' Display Group details not available %>
		<br><br> 
		<TABLE valign='top' align=center border=0 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align=center><font class="whiteboldtext">There are no Bugs Database for this project.</font></TD>
		</tr>
		<tr>
			<TD align=center><font class="whiteboldtext">Select a different project.</font></TD>
		</TR>
		</TABLE>
 <% end if 
 
 	Set lTSObj = Nothing
	Set lDatabaseRs = Nothing
 %>
</BODY>
<script language=javascript> 
	var lDBID = <%=lDatabaseID%>;
	var lCProjID = <%=lProjectIDFromCookie%>;
	var lProjID = <%=lProjectID%>;
		
	if (lProjID == lCProjID) {
		if (lDBID != 0) {
			HighlightDatabase(lDBID);
		}
	}
</script>

</HTML>
