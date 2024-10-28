<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<script language=javascript>
// Global variables
var gRowCount;
gRowCount=0;
</script>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<script language="javascript">
function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || window.event.keyCode == 46 || window.event.keyCode == 13)) {
		event.returnValue = 0;
		alert("Please enter a number.");
	}
}

function OnClickStartPage() {
	document.location.href="ts-weekly-timesheet-start.asp";
}
</script>
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
<% 'Create the select strings here
	Dim lProjectsSelectStr1
	Dim lCodesSelectStr1
		
	' Create the select string for projects	
	lProjectsRs.MoveFirst 
	while not lProjectsRs.EOF 
		lProjectsSelectStr1 = lProjectsSelectStr1 & "<OPTION Value='" & trim(lProjectsRs("P_ProjectName")) & "'>" & trim(lProjectsRs("P_ProjectName")) & "</OPTION>"
		lProjectsRs.MoveNext 
	wend
	
	lProjectsSelectStr1 = lProjectsSelectStr1 & "</SELECT>"
		
	' Create the select string for Codes
	lCodesRs.MoveFirst 
	while not lCodesRs.EOF 
		lCodesSelectStr1 = lCodesSelectStr1 & "<OPTION Value='" & trim(lCodesRs("AC_Description")) & "'>" & trim(lCodesRs("AC_Description")) & "</OPTION>"
		lCodesRs.MoveNext 
	wend
	
	lCodesSelectStr1 = lCodesSelectStr1 & "</SELECT>"
%>

<script language="javascript">
function CreateNewRow() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var lProjectHtml;
	var lCodeHtml;
	
	// increment the global variab;e
	gRowCount = eval(gRowCount) + 1;
	
	lProjectHtml = "<SELECT name='sProject" + gRowCount + "'>";
	lProjectHtml = lProjectHtml + "<%=lProjectsSelectStr1%>";

	lCodeHtml = "<SELECT name='sCode" + gRowCount + "'>";
	lCodeHtml = lCodeHtml + "<%=lCodesSelectStr1%>";
	
	// Insert rows and cells into the body.
	oRow = oTBody0.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = lProjectHtml;  

	oCell = oRow.insertCell();
	oCell.innerHTML = lCodeHtml;  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' name='ebMonday" + gRowCount + "' value='0' size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' name='ebTuesday" + gRowCount + "' value='0' size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' name='ebWednesday" + gRowCount + "' value='0' size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' name='ebThursday" + gRowCount + "' value='0' size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' name='ebFriday" + gRowCount + "' value='0' size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' name='ebSaturday" + gRowCount + "' value='0' size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' name='ebSunday" + gRowCount + "' value='0' size=5 onkeypress='ValidateInteger();'>";  
	
	// Update the hRowCount hidden variable
	document.frmUpdateTimeSheet.hRowCount.value = gRowCount; 	
}

function CreateNewFilledRow(piProjectHtml, piCodeHtml, piMon, piTue, piWed, piThu, piFri, piSat, piSun) {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// Insert rows and cells into the body.
	oRow = oTBody0.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = piProjectHtml;  

	oCell = oRow.insertCell();
	oCell.innerHTML = piCodeHtml;  

	gRowCount = eval(gRowCount) + 1;
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT   type='text' name='ebMonday" + gRowCount + "' value=" + piMon + " size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT   type='text' name='ebTuesday" + gRowCount + "' value=" + piTue + " size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT   type='text' name='ebWednesday" + gRowCount + "' value=" + piWed + " size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT   type='text' name='ebThursday" + gRowCount + "' value=" + piThu + " size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT   type='text' name='ebFriday" + gRowCount + "' value=" + piFri + " size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT   type='text' name='ebSaturday" + gRowCount + "' value=" + piSat + " size=5 onkeypress='ValidateInteger();'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT   type='text' name='ebSunday" + gRowCount + "' value=" + piSun + " size=5 onkeypress='ValidateInteger();'>";  
}
</script>

<%
	Dim lEditDate
	Dim lDayOfWeek	
	Dim lMondayDate
	Dim lSundayDate
	
	' Get request parameters
	lEditDate=Request.Form("ebDateEdit")
	
	' Find out the day of the week and compute monday and sunday dates
	lDayOfWeek=WeekDay(CDate(lEditDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if
	
	lMondayDate = CDate(lEditDate)-(lDayOfWeek-vbMonday)
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

	Set lTimeSheetRs = lTSObj.GetTS (lEmpID, lMondayDate)
%>	
<% 
	If not lTimeSheetRs.EOF Then
		' Get the Employee Name
		Dim lEmpName
		Dim lEmpRs
	
		Set lEmpRs = Server.CreateObject ("ADODB.RecordSet")
		Set lEmpRs = lTSObj.GetUserProfile (lEmpID)
	
		lEmpName = "Unknown"
		if lEmpRs.RecordCount > 0 Then
			lEmpName = trim(lEmpRs("U_Name"))
		End If
		Set lEmpRs = Nothing
%>
<Form name="frmUpdateTimeSheet" method="post" action="ts-weekly-timesheet-edit.asp">
<input type="hidden" name="hMonDate" value="<%=lMondayDate%>">

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
<TABLE width=50% align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="border-collapse:collapse">
<TR>
<TD width=50><font color="white"><B>Project</B></font></TD><TD width=180><font color="white"><B>Activity Code</B></font></TD><TD width=5><font color="blue">Mon</font></TD><TD width=5><font color="blue">Tue</font></TD><TD width=5><font color="blue">Wed</font></TD><TD width=5><font color="blue">Thr</font></TD><TD width=5><font color="blue">Fri</FONT></TD><TD width=5><font color="orange">Sat</font></TD><TD width=5><font color="orange">Sun</font></TD>
</TR>
<TBODY ID="oTBody0"></TBODY>
</TABLE>

<TABLE width=50% align="center">
<TR>
		<TD align="center">
		<INPUT type="button" Value="New Entry" onclick="CreateNewRow();" style='BACKGROUND-COLOR: aqua'>
		<INPUT type="submit" Value="Save Time Sheet" style='BACKGROUND-COLOR: aqua'>
		<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'></TD>
</TR>
</TABLE>
<BR>
<TABLE width="50%" align="center">
<TR>
	<TD align="middle"><font class="footernote">To delete an entry set all hours to Zero.</font></TD>
</TR>
</TABLE>
<% 
	end if
%>
<% 'Create the select strings here and call CreateNewFilledRow
	Dim lProjectsSelectStr
	Dim lCodesSelectStr
	Dim lSelectAllStr
	Dim lhCode
	Dim lhProject
	Dim lProjectID
	Dim lCodeID
	
	if not lTimeSheetRs.EOF Then
		lTimeSheetRs.MoveFirst 

		' Loop through timesheet recordset and create the html strings
		while not lTimeSheetRs.EOF
			gRowCount = gRowCount + 1	
		
			lProjectID = trim(lTimeSheetRs("P_ProjectID"))
			Set lProjectProfileRs = lTSObj.GetProjectProfile(eval(lProjectID))
			
			lCodeID = trim(lTimeSheetRs("AC_Code"))
			Set lCodeProfileRs = lTSObj.GetCodeProfile(eval(lCodeID))

			' Create the select string for projects	
			lProjectsRs.MoveFirst 
		
			lProjectsSelectStr = "<SELECT   name='sProject" & gRowCount & "'>"
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

			lCodesSelectStr = "<SELECT   name='sCode" & gRowCount & "'>"
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
			
			' Create the hidden fields for code and project that has to be 
			' carried over to ts-weekly-timesheet-edit.asp
			lhCode = "hCode" & gRowCount
			lhProject = "hProject" & gRowCount
%>
			<input type="hidden" name="<%=lhCode%>"  value="<%=trim(lCodeProfileRs("AC_Description"))%>">
			<input type="hidden" name="<%=lhProject%>"  value="<%=trim(lProjectProfileRs("P_ProjectName"))%>">
<script language="javascript">
		CreateNewFilledRow("<%=lProjectsSelectStr%>", "<%=lCodesSelectStr%>", <%=trim(lTimeSheetRs("WTS_MonHrs"))%>, <%=trim(lTimeSheetRs("WTS_TueHrs"))%>, <%=trim(lTimeSheetRs("WTS_WedHrs"))%>, <%=trim(lTimeSheetRs("WTS_ThuHrs"))%>, <%=trim(lTimeSheetRs("WTS_FriHrs"))%>, <%=trim(lTimeSheetRs("WTS_SatHrs"))%>, <%=trim(lTimeSheetRs("WTS_SunHrs"))%>)
</script>
<%
			lTimeSheetRs.MoveNext
		wend
%>
<input type="hidden" name="hRowCount" value="<%=gRowCount%>">
<input type="hidden" name="hOriginalRowCount" value="<%=gRowCount%>">
</Form>
<script language="javascript">
gRowCount=document.frmUpdateTimeSheet.hRowCount.value
</script>
<%	 
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
	Set lTimeSheetRs = Nothing 
	Set lProjectProfileRs = Nothing
	Set lCodeProfileRs = Nothing
%>	
</BODY>
</HTML>
