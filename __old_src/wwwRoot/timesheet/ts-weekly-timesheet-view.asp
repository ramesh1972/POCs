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
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivTS.style.background = "lightblue";
</script>
<BR>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lProjectsRs
	Dim lCodesRs

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lProjectsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lProjectsRs = lTSObj.GetProjects()

	' Get Codes
	Set lCodesRs = Server.CreateObject ("ADODB.RecordSet")
	Set lCodesRs = lTSObj.GetCodes ()
%>
<% ' Get the Employee Name
	Dim lEmpName
	Dim lEmpID1
	Dim lEmpRs
	Dim lEmpID2 
	
	lEmpID1 = Request.Form("sUsers")
	if (lEmpID1 = "") Then
		lEmpID1 = lEmpID
	End if
	
	lEmpID2 = Request.QueryString ("EmpID")
	if (lEmpID2 <> "") Then
		lEmpID1 = lEmpID2
	End if
	
	Set lEmpRs = Server.CreateObject ("ADODB.RecordSet")
	Set lEmpRs = lTSObj.GetUserProfile (eval(lEmpID1))
	
	lEmpName = "Unknown"
	if lEmpRs.RecordCount > 0 Then
		lEmpName = trim(lEmpRs("U_Name"))
	End If
%>
<script language="javascript">
function CreateNewFilledRow(piCount, piProjectHtml, piCodeHtml, piMon, piTue, piWed, piThu, piFri, piSat, piSun) {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// Insert rows and cells into the body.
	oRow = oTBody0.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = piProjectHtml;  

	oCell = oRow.insertCell();
	oCell.innerHTML = piCodeHtml;  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' name='ebMonday" + piCount + "' value=" + piMon + " size=5>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' name='ebTuesday" + piCount + "' value=" + piTue + " size=5>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' name='ebWednesday" + piCount + "' value=" + piWed + " size=5>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' name='ebThursday" + piCount + "' value=" + piThu + " size=5>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' name='ebFriday" + piCount + "' value=" + piFri + " size=5>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' name='ebSaturday" + piCount + "' value=" + piSat + " size=5>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' name='ebSunday" + piCount + "' value=" + piSun + " size=5>";  
}
</script>

<%
	Dim lViewDate
	Dim lDayOfWeek	
	Dim lMondayDate
	Dim lSundayDate
	Dim lViewDateQS
	Dim lTSDate
		
	' Get request parameters
	lViewDate=Request.Form("ebDateView")
	lTSDate = Request.QueryString ("TSDate")
	
	if lEmpID2 <> "" Then
		lViewDate = FormatDateTime(Now()-7,vbShortDate)
	end if
	
	' Find out the day of the week and compute monday and sunday dates
	lDayOfWeek=WeekDay(CDate(lViewDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if
	
	lMondayDate = CDate(lViewDate)-(lDayOfWeek-vbMonday)
	if lTSDate <> "" Then
		lMondayDate = CDate(lTSDate)
	end if
	lSundayDate = lMondayDate + 6
	
	
%>

<% ' Get the record set for the timesheet
	Dim lTimeSheetRs 
	Dim lProjectProfileRs
	Dim lCodeProfileRs
		
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")	
	Set lTimeSheetRs = Server.CreateObject("ADODB.Recordset")
	Set lProjectProfileRs = Server.CreateObject("ADODB.Recordset")
	Set lCodeProfileRs = Server.CreateObject("ADODB.Recordset")
		
	Set lTimeSheetRs = lTSObj.GetTS (eval(lEmpID1), lMondayDate)
%>	
<% 
	If not lTimeSheetRs.EOF Then
%>
<Form name="frmViewTimeSheet" method="post" action="ts-weekly-timesheet-start.asp">
<center><B>Weekly Time Sheet</B></center>
<table border=1 width=60% align="center" BGCOLOR="white" STYLE="BORDER-BOTTOM: none; BORDER-COLLAPSE: collapse">
<TR colspan=4>
	<TD align="left" bgcolor="yellow" width=20%><B>Name</B></TD>
	<TD align="left" bgcolor="white" width=80%>&nbsp;<%=lEmpName%></TD>
</TR>
</TABLE>
<table border=1 width=60% align="center" BGCOLOR="white" STYLE="border-collapse:collapse">
<TR cols=4>
	<TD align="left" bgcolor="yellow" width=20%><B>From Date</B></TD>
	<TD align="left" bgcolor="white" width=30%>&nbsp;<%=lMondayDate%></TD>
	<TD align="left" bgcolor="yellow" width=20%><B>To Date</B></TD>
	<TD align="left" bgcolor="white" width=30%>&nbsp;<%=lSundayDate%></TD>
</TR>
</TABLE>
<BR>
<TABLE  width=50% align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="border-collapse:collapse">
<TR>
<TD width=50><font color="white"><B>Project</B></font></TD><TD width=180><font color="white"><B>Activity Code</B></font></TD><TD width=5><font color="blue">Mon</font></TD><TD width=5><font color="blue">Tue</font></TD><TD width=5><font color="blue">Wed</font></TD><TD width=5><font color="blue">Thr</font></TD><TD width=5><font color="blue">Fri</FONT></TD><TD width=5><font color="orange">Sat</font></TD><TD width=5><font color="orange">Sun</font></TD>
</TR>
<TBODY ID="oTBody0"></TBODY>
</TABLE>

<TABLE width=50% align="center">
<TR>
	<TD align="center"><INPUT type="submit" Value="Start Page" style="BACKGROUND-COLOR: aqua"></TD>
</TR>
</TABLE>
</Form>
<% 
	end if
%>
<% 'Create the select strings here and call CreateNewFilledRow
	Dim lProjectsSelectStr
	Dim lCodesSelectStr
	Dim lSelectAllStr
	Dim lCount 
	Dim lProjectID
	Dim lCodeID
	
	lCount = 1
	
	if not lTimeSheetRs.EOF Then
		lTimeSheetRs.MoveFirst 
	
		' Loop through timesheet recordset and create the html strings
		while not lTimeSheetRs.EOF
	    	' Get the project and code name from id
			lProjectID = trim(lTimeSheetRs("P_ProjectID"))
			Set lProjectProfileRs = lTSObj.GetProjectProfile(eval(lProjectID))
			
			lCodeID = trim(lTimeSheetRs("AC_Code"))
			Set lCodeProfileRs = lTSObj.GetCodeProfile(eval(lCodeID))
			
			' Create the select string for projects	
			lProjectsRs.MoveFirst 
		
			lProjectsSelectStr = "<SELECT disabled name='sProject" & lCount & "'>"
			if lProjectProfileRs.RecordCount > 0 Then			
				while not lProjectsRs.EOF 
						if (trim(lProjectsRs("P_ProjectName")) = trim(lProjectProfileRs("P_ProjectName"))) Then
							lProjectsSelectStr = lProjectsSelectStr & "<OPTION Value='" & trim(lProjectsRs("P_ProjectName")) & "' selected>" & trim(lProjectsRs("P_ProjectName")) & "</OPTION>"			
						Else
							lProjectsSelectStr = lProjectsSelectStr & "<OPTION Value='" & trim(lProjectsRs("P_ProjectName")) & "'>" & trim(lProjectsRs("P_ProjectName")) & "</OPTION>"
						End if
					lProjectsRs.MoveNext 
				wend
			end if
			lProjectsSelectStr = lProjectsSelectStr & "</SELECT>"		
				
			' Create the select string for projects	
			lCodesRs.MoveFirst 

			lCodesSelectStr = "<SELECT disabled name='sCode" & lCount & "'>"
			if lCodeProfileRs.RecordCount > 0 Then						
				while not lCodesRs.EOF 
					if (trim(lCodesRs("AC_Description")) = trim(lCodeProfileRs("AC_Description"))) Then
						lCodesSelectStr = lCodesSelectStr & "<OPTION Value='" & trim(lCodesRs("AC_Description")) & "' selected>" & trim(lCodesRs("AC_Description")) & "</OPTION>"
					Else
						lCodesSelectStr = lCodesSelectStr & "<OPTION Value='" & trim(lCodesRs("AC_Description")) & "'>" & trim(lCodesRs("AC_Description")) & "</OPTION>"
					End if
					lCodesRs.MoveNext 
				wend
			end if
			lCodesSelectStr = lCodesSelectStr & "</SELECT>"
%>
<script language="javascript">
		CreateNewFilledRow(<%=lCount%>, "<%=lProjectsSelectStr%>", "<%=lCodesSelectStr%>", <%=trim(lTimeSheetRs("WTS_MonHrs"))%>, <%=trim(lTimeSheetRs("WTS_TueHrs"))%>, <%=trim(lTimeSheetRs("WTS_WedHrs"))%>, <%=trim(lTimeSheetRs("WTS_ThuHrs"))%>, <%=trim(lTimeSheetRs("WTS_FriHrs"))%>, <%=trim(lTimeSheetRs("WTS_SatHrs"))%>, <%=trim(lTimeSheetRs("WTS_SunHrs"))%>)
</script>
<%
			lCount=lCount+1
			lTimeSheetRs.MoveNext
		wend
	else
%>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Timesheet not available</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-weekly-timesheet-start.asp">Click here</A> to go to the Timesheet start page</TD>
</TR>
</TABLE>	
<%		
	end if
	Set lTSObj = Nothing
	Set lProjectsRs = Nothing
	Set lCodesRs = Nothing
	Set lEmpRs = Nothing
	Set lTimeSheetRs = Nothing 
	Set lProjectProfileRs = Nothing
	Set lCodeProfileRs = Nothing
%>	
</BODY>
</HTML>
