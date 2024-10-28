<%
Function DisplayTitle()
	Dim lEmpID
	Dim lEmpName
	Dim lEmpRs
	Dim lProjectID
	Dim lProjectRs
	Dim lProjectName
	Dim lDatabaseID
	Dim lDatabaseRs
	Dim lDatabaseName
	Dim lEmpAdmin
	Dim lEmpProjectLead
	Dim lEmpDeveloper
	Dim lEmpTester
	Dim lEmpRole
	Dim lTSObj
	Dim lSBObj
	
	lEmpID = Request.Cookies("EmployeeID")
	lProjectID = Request.Cookies("BugsProjectID")
	lDatabaseID = Request.Cookies("BugsDatabaseID")
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lEmpRs = Server.CreateObject ("ADODB.RecordSet")
	Set lProjectRs = Server.CreateObject ("ADODB.RecordSet")
	Set lDatabaseRs = Server.CreateObject ("ADODB.RecordSet")
	
	Set lEmpRs = lTSObj.GetUserProfile(eval(lEmpID))
	if lEmpRs.RecordCount > 0 Then
		lEmpName = trim(lEmpRs("U_Name"))
	else
		lEmpName = "Unknown"
	end if
	
	Set lProjectRs = lTSObj.GetGroupProfile(eval(lProjectID))
	if lProjectRs.RecordCount > 0 Then
		lProjectName = trim(lProjectRs("G_GroupName"))
	else
		lProjectName = "Unknown"
	end if	
	
	Set lDatabaseRs = lSBObj.GetBugsDatabase(eval(lProjectID), eval(lDatabaseID))
	if lDatabaseRs.RecordCount > 0 Then
		lDatabaseName = trim(lDatabaseRs("DB_Name"))
	else
		lDatabaseName = "Unknown"
	end if	
	
	lEmpAdmin = lTSObj.CheckIfAdministrator(eval(lEmpID))
	lEmpProjectLead = lTSObj.CheckIfGroupLead(eval(lEmpID), eval(lProjectID))
	lEmpDeveloper = lTSObj.CheckIfDeveloper(eval(lEmpID), eval(lProjectID))
	lEmpTester = lTSObj.CheckIfTester(eval(lEmpID), eval(lProjectID))
	
	lEmpRole = ""
	if lEmpAdmin Then
		lEmpRole = lEmpRole & "Admin"
	end if
	
	if lEmpProjectLead Then
		If lEmpRole = "" Then
			lEmpRole = lEmpRole & "Project Lead"
		else
			lEmpRole = lEmpRole & ", Project Lead"
		end if
	end if
	
	if lEmpDeveloper = "Y" Then
		If lEmpRole = "" Then
			lEmpRole = lEmpRole & "Developer"
		else
			lEmpRole = lEmpRole & ", Developer"
		end if
	end if

	if lEmpTester = "Y" Then
		If lEmpRole = "" Then
			lEmpRole = lEmpRole & "Tester"
		else
			lEmpRole = lEmpRole & ", Tester"
		end if
	end if
%>
<BR>
<TABLE valign="top" align="center" border=1 width=60% bgcolor="lemonchiffon" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD valign="top" width=15%><font class="smallblacktext"><B>Project</B></font></TD><TD valign="top" width=35% bgcolor=white><font class="smallblacktext"><%=lProjectName%></font></TD><TD valign="top" width=25%><font class="smallblacktext"><B>Bugs Database</B></font></TD><TD valign="top" width=35% bgcolor=white><font class="smallblacktext"><%=lDatabaseName%></font></TD>
  </TR>
  <TR>
    <TD valign="top" width=15%><font class="smallblacktext"><B>Employee</B></font></TD><TD valign="top" width=35% bgcolor=white><font class="smallblacktext"><%=lEmpName%></font></TD>
    <TD valign="top" width=20%><font class="smallblacktext"><B>Role</B></font></TD><TD valign="top" width=35% bgcolor=white><font class="smallblacktext"><%=lEmpRole%></font></TD>
  </TR>
 </TABLE>
<%
End Function
%>

