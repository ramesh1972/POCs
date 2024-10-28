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
	
	' Get the list of groups that this user belongs to
	Dim lTSObj
	Dim lUserGroupsRs
	Dim lGroupCount 
	Dim lGrpID()
	Dim lDvlp()
	Dim lTest()
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lUserGroupsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUserGroupsRs = lTSObj.GetUserGroups(eval(lEmployeeID)) 
	lGroupCount = lUserGroupsRs.RecordCount 
	
	if lGroupCount > 0 Then
		ReDim lGrpID(lGroupCount)	
		ReDim lDvlp(lGroupCount)	
		ReDim lTest(lGroupCount)
		Dim lIdx
		
		lIdx = 0		
		lUserGroupsRs.MoveFirst() 
			while not lUserGroupsRs.EOF
				lGrpID(lIdx) = eval(trim(lUserGroupsRs("G_GroupID")))
				lDvlp(lIdx) = Request.Form("hGroupDvlp" & eval(trim(lUserGroupsRs("G_GroupID"))))
				lTest(lIdx) = Request.Form("hGroupTester" & eval(trim(lUserGroupsRs("G_GroupID"))))				
				lIdx = lIdx + 1
				lUserGroupsRs.MoveNext() 
			wend		
	end if
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR><br><br>

<% 'Get all required data from the database
	Dim lUserUpdated
	
	' Update user details
	lUserUpdated = lTSObj.UpdateUserProfile  (eval(lEmployeeID), lEmpName, lAdministrator)
	
	if lUserUpdated Then 
		' Update the User Group Rights
		Dim lUserGroupsUpdated
		lUserGroupsUpdated = true
		for lIdx = 0 To lGroupCount-1
			lUserGroupsUpdated = lTSObj.UpdateUserGroupRights(eval(lEmployeeID), lGrpID(lIdx), lDvlp(lIdx), lTest(lIdx))
			if not lUserGroupsUpdated Then
			' Display User details not updated
%>

				<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
				<TR>
					<TD><font class="whiteboldtext">User details not updated</font></TD>
				</TR>
				</TABLE>

				<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
				<TR>
					<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to try again.</TD>
				</TR>
				</TABLE>	
<%
				exit for
			end if			
		Next
		
		if lUserGroupsUpdated Then
%>
			<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
			<TR>
				<TD><font class="whiteboldtext">User details Updated</font></TD>
			</TR>
			</TABLE>

			<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
			<TR>
				<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to users start page.</TD>
			</TR>
			</TABLE>	
<%
		end if
	else 
		' Display User details not updated %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">User details not updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
  	Set lTSObj = Nothing
 %>
</BODY>
</HTML>
