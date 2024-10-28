<%@ Language=VBScript %>
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
<% ' Global varables
	Dim gRowCount
	Dim gOrgRowCount
	Dim gTSObj
	Dim gMonDate
	
	Dim lProject()
	Dim lCode()
	Dim lMonday()
	Dim lTuesday()
	Dim lWednesday()
	Dim lThursday()
	Dim lFriday()
	Dim lSaturday()
	Dim lSunday()

	Dim lOrgProject()
	Dim lOrgCode()

	' Intialisations
	gRowCount = Request.Form("hRowCount")
	gOrgRowCount = Request.Form("hOriginalRowCount")
	gMonDate = Request.Form("hMonDate")
	Set gTSObj = Server.CreateObject ("TimeSheet.clsTimesheet")
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivTS.style.background = "lightblue";
</script>
<BR>
<% 
	Dim lIdx
	
	' Redefine the size of arrays
	Redim lProject(gRowCount)
	Redim lCode(gRowCount)
	ReDim lMonday(gRowCount)
	ReDim lTuesday(gRowCount)
	ReDim lWednesday(gRowCount)
	ReDim lThursday(gRowCount)
	ReDim lFriday(gRowCount)
	ReDim lSaturday(gRowCount)
	ReDim lSunday(gRowCount)
	
	ReDim lOrgProject(gOrgRowCount)
	ReDim lOrgCode(gOrgRowCount)

	' Get the values from the forms into the arrays
	for lIdx = 1 to gRowCount
		lProject(lIdx) = Request.Form("sProject" & lIdx)
		lCode(lIdx) = Request.Form("sCode" & lIdx)
		lMonday(lIdx) = Request.Form("ebMonday" & lIdx)
		lTuesday(lIdx) = Request.Form("ebTuesday" & lIdx)
		lWednesday(lIdx) = Request.Form("ebWednesday" & lIdx)
		lThursday(lIdx) = Request.Form("ebThursday" & lIdx)
		lFriday(lIdx) = Request.Form("ebFriday" & lIdx)
		lSaturday(lIdx) = Request.Form("ebSaturday" & lIdx)
		lSunday(lIdx) = Request.Form("ebSunday" & lIdx)
	next

	for lIdx = 1 to gOrgRowCount
		lOrgCode(lIdx) = Request.Form("hCode" & lIdx)
		lOrgProject(lIdx) = Request.Form("hProject" & lIdx)
	next
%>

<% ' Insert the values into the TS_WeeklyTimeSheet table
	Dim lInserted
	Dim lDate
	
	lDate = Cdate(gMonDate)

	for lIdx = 1 to gRowCount
		if lIdx <= eval(gOrgRowCount) Then
			lInserted = gTSObj.UpdateWTSDay( lEmpID,lDate,lProject(lIdx),lCode(lIdx),lMonday(lIdx),lTuesday(lIdx),lWednesday(lIdx),lThursday(lIdx),lFriday(lIdx),lSaturday(lIdx),lSunday(lIdx), lOrgCode(lIdx), lOrgProject(lIdx))
		Else
			lInserted = gTSObj.UpdateWTSDay( lEmpID,lDate,lProject(lIdx),lCode(lIdx),lMonday(lIdx),lTuesday(lIdx),lWednesday(lIdx),lThursday(lIdx),lFriday(lIdx),lSaturday(lIdx),lSunday(lIdx), "", "")
		End if
		
		if not lInserted then
			exit for
		end if
	next

	If lInserted Then
%>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Successfully Timesheet Updated</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-weekly-timesheet-start.asp">Click here</A> to go to the Timesheet start page</TD>
</TR>
</TABLE>	
<%else%>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Error while updating Timesheet</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-weekly-timesheet-start.asp">Click here</A> to go to the Timesheet start page</TD>
</TR>
</TABLE>	

<%end if

Set gTSObj = Nothing
%>	
</BODY>
</HTML>
