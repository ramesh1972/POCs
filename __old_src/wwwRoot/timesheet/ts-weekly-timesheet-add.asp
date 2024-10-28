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

	' Intialisations
	gRowCount = Request.Form("hRowCount")
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
%>

<% ' Insert the values into the TS_WeeklyTimeSheet table
	Dim lInserted
	
	for lIdx = 1 to gRowCount
		lInserted = gTSObj.InsertWTSDay (lEmpID,gMonDate,lProject(lIdx),lCode(lIdx),lMonday(lIdx),lTuesday(lIdx),lWednesday(lIdx),lThursday(lIdx),lFriday(lIdx),lSaturday(lIdx),lSunday(lIdx))
		if not lInserted then
			exit for
		end if
	next
	
	If lInserted Then
%>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Successfully Timesheet Created</font></TD>
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
	<TD><font class="whiteboldtext">Error while creating Timesheet</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-weekly-timesheet-start.asp">Click here</A> to go to the Timesheet start page</TD>
</TR>
</TABLE>	

<%end if
Set gTSObj = Nothing %>	
</BODY>
</HTML>
