<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<script language=javascript>
// Global variables
var gSect1RowCount;
var gSect2RowCount;
var gSect3RowCount;
var gSect4RowCount;
var gSect5RowCount;
var gSect6NotesRowCount;
var gSect6FlagsRowCount;

gSect1RowCount=0;
gSect2RowCount=0;
gSect3RowCount=0;
gSect4RowCount=0;
gSect5RowCount=0;
gSect6NotesRowCount=0;
gSect6FlagsRowCount=0;
</script>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<%
	Dim lViewDate
	Dim lDayOfWeek	
	Dim lMondayDate
	Dim lSundayDate

	' Get request parameters
	lViewDate=Request.Form("ebDateView")
	
	' Find out the day of the week and compute monday and sunday dates
	lDayOfWeek=WeekDay(CDate(lViewDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if
	
	lMondayDate = CDate(lViewDate)-(lDayOfWeek-vbMonday)
	lSundayDate = lMondayDate + 6
%>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lProjectID 
	Dim lProjectName

	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")

	' Get the project
	lProjectID = Request.Form("sProjects")
	lProjectName = lTSObj.GetProjectName (eval(lProjectID))
%>
<script language="javascript">
function CreateNewFilledSectDatesRow(piSectNo, piTaskDesc, piTaskBaseStart, piTaskBaseEnd, piTaskActStart, piTaskActEnd) {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var lCount;
	
	// increment the global variable
	if (piSectNo == 1) lCount = gSect1RowCount;
	if (piSectNo == 2) lCount = gSect2RowCount;
	if (piSectNo == 3) lCount = gSect3RowCount;
	
	// Insert rows and cells into the body.
	if (piSectNo == 1) oRow = oTBody0.insertRow();
	if (piSectNo == 2) oRow = oTBody1.insertRow();
	if (piSectNo == 3) oRow = oTBody2.insertRow();
	
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='30' maxlength=256 name='ebSect" + piSectNo + "TaskDesc" + lCount + "' value='" + piTaskDesc + "'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='10' maxlength=10 name='ebSect" + piSectNo + "TaskBaseStart" + lCount + "' value='" + piTaskBaseStart + "'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='10' maxlength=10 name='ebSect" + piSectNo + "TaskBaseEnd" + lCount + "' value='" + piTaskBaseEnd + "'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='10' maxlength=10 name='ebSect" + piSectNo + "TaskActStart" + lCount + "' value='" + piTaskActStart + "'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='10' maxlength=10 name='ebSect" + piSectNo + "TaskActEnd" + lCount + "' value='" + piTaskActEnd + "'>";    
}

function CreateNewFilledSect45Row(piSect, piTaskDesc, piStatus, piRemarks) {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var lCount;
	
	if (piSect == 4) lCount = gSect4RowCount;
	if (piSect == 5) lCount = gSect5RowCount;
	
	// Insert rows and cells into the body.
	if (piSect == 4) oRow = oTBody3.insertRow();
	if (piSect == 5) oRow = oTBody4.insertRow();
	
	// Insert rows and cells into the body.
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='33' maxlength=256 name='ebSect" + piSect + "Issue" + lCount + "' value='" + piTaskDesc + "'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = piStatus;    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='33' maxlength=256 name='ebSect" + piSect + "IssueRemarks" + lCount + "' value='" + piRemarks + "'>";  
}

function CreateNewFilledSectNotesRow(piSect, piNote) {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var lCount;
	
	if (piSect == 6) lCount = "Notes" + gSect6NotesRowCount;
	if (piSect == 7) lCount = "Flags" + gSect6FlagsRowCount;
	
	// Insert rows and cells into the body.
	if (piSect == 6) oRow = oTBody5.insertRow();
	if (piSect == 7) oRow = oTBody6.insertRow();

	// Insert rows and cells into the body.
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT disabled type='text' size='64' maxlength=256 name='ebSect" + piSect + lCount + "' value='" + piNote + "'>";  
}

function CreateSection1NewRow() {

	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// increment the global variab;e
	gSect1RowCount = gSect1RowCount + 1;
	
	// Insert rows and cells into the body.
	oRow = oTBody0.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='30' maxlength=256 name='ebSect1TaskDesc" + gSect1RowCount + "' value='Enter Task'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskBaseStart" + gSect1RowCount + "' value='<%=lMondayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskBaseEnd" + gSect1RowCount + "' value='<%=lSundayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskActStart" + gSect1RowCount + "' value='<%=lMondayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskActEnd" + gSect1RowCount + "' value='<%=lSundayDate%>'>";    

	// Update the hRowCount hidden variable
	document.frmNewProgressReport.hSect1RowCount.value = gSect1RowCount; 	
}

function CreateSection2NewRow() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// increment the global variab;e
	gSect2RowCount = gSect2RowCount + 1;
	
	// Insert rows and cells into the body.
	oRow = oTBody1.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='30' maxlength=256 name='ebSect2TaskDesc" + gSect2RowCount + "' value='Enter Task'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskBaseStart" + gSect2RowCount + "' value='<%=lMondayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskBaseEnd" + gSect2RowCount + "' value='<%=lSundayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskActStart" + gSect2RowCount + "' value='<%=lMondayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskActEnd" + gSect2RowCount + "' value='<%=lSundayDate%>'>";    

	// Update the hRowCount hidden variable
	document.frmNewProgressReport.hSect2RowCount.value = gSect2RowCount; 	
}

function CreateSection3NewRow() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// increment the global variab;e
	gSect3RowCount = gSect3RowCount + 1;
	
	// Insert rows and cells into the body.
	oRow = oTBody2.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='30' maxlength=256 name='ebSect3TaskDesc" + gSect3RowCount + "' value='Enter Task'>";  

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskBaseStart" + gSect3RowCount + "' value='<%=lMondayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskBaseEnd" + gSect3RowCount + "' value='<%=lSundayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskActStart" + gSect3RowCount + "' value='<%=lMondayDate%>'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskActEnd" + gSect3RowCount + "' value='<%=lSundayDate%>'>";    

	// Update the hRowCount hidden variable
	document.frmNewProgressReport.hSect3RowCount.value = gSect3RowCount; 	
}

function CreateSection4NewRow() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// increment the global variab;e
	gSect4RowCount = gSect4RowCount + 1;
	
	// Insert rows and cells into the body.
	oRow = oTBody3.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='33' maxlength=256 name='ebSect4Issue" + gSect4RowCount + "' value='Enter Issue'>";  

	var lStatusSelectStr = "<SELECT name='sSect4IssueStatus" + gSect4RowCount + "'><OPTION value='Open'>Open</OPTION><OPTION value='Closed'>Closed</OPTION></SELECT>";
	
	oCell = oRow.insertCell();
	oCell.innerHTML = lStatusSelectStr;    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='33' maxlength=256 name='ebSect4IssueRemarks" + gSect4RowCount + "' value=''>";  

	// Update the hRowCount hidden variable
	document.frmNewProgressReport.hSect4RowCount.value = gSect4RowCount; 	
}
function CreateSection5NewRow() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// increment the global variab;e
	gSect5RowCount = gSect5RowCount + 1;
	
	// Insert rows and cells into the body.
	oRow = oTBody4.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='33' maxlength=256 name='ebSect5Issue" + gSect5RowCount + "' value='Enter Issue'>";  

	var lStatusSelectStr = "<SELECT name='sSect5IssueStatus" + gSect5RowCount + "'><OPTION value='Open'>Open</OPTION><OPTION value='Closed'>Closed</OPTION></SELECT>";
	
	oCell = oRow.insertCell();
	oCell.innerHTML = lStatusSelectStr;    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='33' maxlength=256 name='ebSect5IssueRemarks" + gSect5RowCount + "' value=''>";  

	// Update the hRowCount hidden variable
	document.frmNewProgressReport.hSect5RowCount.value = gSect5RowCount; 	
}

function CreateSection6NotesNewRow() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// increment the global variab;e
	gSect6NotesRowCount = gSect6NotesRowCount + 1;
	
	// Insert rows and cells into the body.
	oRow = oTBody5.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='64' maxlength=256 name='ebSect6Notes" + gSect6NotesRowCount + "' value='Enter Note'>";  

	// Update the hRowCount hidden variable
	document.frmNewProgressReport.hSect6NotesRowCount.value = gSect6NotesRowCount; 	
}

function CreateSection6FlagsNewRow() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	
	// increment the global variab;e
	gSect6FlagsRowCount = gSect6FlagsRowCount + 1;
	
	// Insert rows and cells into the body.
	oRow = oTBody6.insertRow();
	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='64' maxlength=256 name='ebSect6Flags" + gSect6FlagsRowCount + "' value='Enter Red Flag'>";  

	// Update the hRowCount hidden variable
	document.frmNewProgressReport.hSect6FlagsRowCount.value = gSect6FlagsRowCount; 	
}

function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || window.event.keyCode == 46 || window.event.keyCode == 13)) {
		event.returnValue = 0;
		alert("Please enter a number.");
	}
}

function OnClickStartPage() {
	document.location.href="ts-weekly-progress-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivPR.style.background = "lightblue";
</script>
<BR>

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
<% ' Get the Employee Name
	Dim lEmpID1

	lEmpID1 = Request.Form("sUsers")
	if (lEmpID1 = "") Then
		lEmpID1 = lEmpID
	End if

	' Get the Employee Name
	Dim lEmpName
	Dim lEmpRs
	
	Set lEmpRs = Server.CreateObject ("ADODB.RecordSet")
	Set lEmpRs = lTSObj.GetUserProfile(eval(lEmpID1))
	
	lEmpName = "Unknown"
	if lEmpRs.RecordCount > 0 Then
		lEmpName = trim(lEmpRs("U_Name"))
	End If
	Set lEmpRs = Nothing
%>
<Form name="frmUpdateProgressReport" method="post" action="ts-weekly-progress-edit.asp">
<input type="hidden" name="hMonDate" value="<%=lMondayDate%>">
<%  ' Get the record set for the progress report
	Dim lProgressReportRs 
	Dim lhSect1Task
	Dim lhSect2Task
	Dim lhSect3Task
	Dim lSectNo
			
	Dim lSect1DataExists
	Dim lSect2DataExists
	Dim lSect3DataExists
	Dim lSect4DataExists
	Dim lSect5DataExists
	Dim lSect6NotesDataExists
	Dim lSect6FlagsDataExists
	
	' Section arrays
	Dim lSectDatesNo()
	Dim lSectTaskDesc()
	Dim lSectTaskBaseStart()
	Dim lSectTaskBaseEnd()
	Dim lSectTaskActStart()
	Dim lSectTaskActEnd()
	Dim lSectDatesCount
		
	Dim lSectIssueNo()
	Dim lSectIssue()
	Dim lSectIssueStatus()
	Dim lSectIssueRemarks()
	Dim lSectIssuesCount
	
	Dim lSectNotesNo()
	Dim lSectNotes()
	Dim lSectNotesCount
	


	lSectDatesCount = 0
	lSectIssuesCount = 0
	lSectNotesCount = 0
	
	lSect1DataExists = false
	lSect2DataExists = false
	lSect3DataExists = false
	lSect4DataExists = false
	lSect5DataExists = false
	lSect6NotesDataExists = false
	lSect6FlagsDataExists = false

	Set lProgressReportRs = Server.CreateObject("ADODB.Recordset")

	' Create the existing rows for sections 1,2 and 3
	Set lProgressReportRs = lTSObj.GetPRSectionDates(eval(lEmpID1), eval(lProjectID), lMondayDate)
	if lProgressReportRs.RecordCount > 0 Then
		lProgressReportRs.MoveFirst 

		' Loop through timesheet recordset and create the html strings
		while not lProgressReportRs.EOF
			if (eval(trim(lProgressReportRs("WPR_SectionNo"))) = 1) Then
				lSectDatesCount = lSectDatesCount + 1
				lSect1DataExists = true
				gSect1RowCount = gSect1RowCount + 1	
				lhSect1Task = "hSect1Task" & gSect1RowCount
				lSectNo = 1
%>
				<input type="hidden" name="<%=lhSect1Task%>"  value="<%=trim(lProgressReportRs("WPR_TaskDescription"))%>">				
<%
			end if

			if (eval(trim(lProgressReportRs("WPR_SectionNo"))) = 2) Then
				lSectDatesCount = lSectDatesCount + 1
				lSect2DataExists = true
				gSect2RowCount = gSect2RowCount + 1	
				lhSect2Task = "hSect2Task" & gSect2RowCount
				lSectNo = 2
%>
   				<input type="hidden" name="<%=lhSect2Task%>"  value="<%=trim(lProgressReportRs("WPR_TaskDescription"))%>">
<%
			end if	

			if (eval(trim(lProgressReportRs("WPR_SectionNo"))) = 3) Then
				lSectDatesCount = lSectDatesCount + 1
				lSect3DataExists = true
				gSect3RowCount = gSect3RowCount + 1	
				lhSect3Task = "hSect3Task" & gSect3RowCount
				lSectNo = 3				
%>
				<input type="hidden" name="<%=lhSect3Task%>"  value="<%=trim(lProgressReportRs("WPR_TaskDescription"))%>">
<%
			end if

			Redim Preserve lSecDatesNo(lSectDatesCount-1)
			ReDim Preserve lSect1TaskDesc(lSectDatesCount-1)
			ReDim Preserve lSect1TaskBaseStart(lSectDatesCount-1)
			ReDim Preserve lSect1TaskBaseEnd(lSectDatesCount-1)
			ReDim Preserve lSect1TaskActStart(lSectDatesCount-1)
			ReDim Preserve lSect1TaskActEnd(lSectDatesCount-1)

			lSecDatesNo(lSectDatesCount-1) = lSectNo
			lSect1TaskDesc(lSectDatesCount-1) = trim(lProgressReportRs("WPR_TaskDescription"))
			lSect1TaskBaseStart(lSectDatesCount-1) = trim(lProgressReportRs("WPR_BaseStartDate"))
			lSect1TaskBaseEnd(lSectDatesCount-1) = trim(lProgressReportRs("WPR_BaseEndDate"))
			lSect1TaskActStart(lSectDatesCount-1) = trim(lProgressReportRs("WPR_ActStartDate"))
			lSect1TaskActEnd(lSectDatesCount-1) = trim(lProgressReportRs("WPR_ActEndDate"))

			lProgressReportRs.MoveNext
		wend
	end if
	
	Dim lStatusSelectStr
	
	Set lProgressReportRs = lTSObj.GetPRSection45 (eval(lEmpID1), eval(lProjectID), lMondayDate)
	if lProgressReportRs.RecordCount > 0 Then
		lProgressReportRs.MoveFirst 

		' Loop through timesheet recordset and create the html strings
		while not lProgressReportRs.EOF
			if (eval(trim(lProgressReportRs("WPR_SectionNo"))) = 4) Then
				lSectIssuesCount = lSectIssuesCount + 1
				lSect4DataExists = true
				gSect4RowCount = gSect4RowCount + 1	
				lhSect4Task = "hSect4Task" & gSect4RowCount
				lSectNo = 4
				
				lStatusSelectStr = "<Select disabled name='sSect4IssueStatus" & gSect4RowCount & "'>" 
				if trim(lProgressReportRs("WPR_TaskStatus")) = "Open" Then
					lStatusSelectStr = lStatusSelectStr & "<OPTION Value='Open' selected>Open</OPTION>" & "<OPTION Value='Closed'>Closed</OPTION>"
				else 
					lStatusSelectStr = lStatusSelectStr & "<OPTION Value='Open'>Open</OPTION>" & "<OPTION Value='Closed' selected>Closed</OPTION>"
				end if				   
				lStatusSelectStr = lStatusSelectStr & "</SELECT>"
%>
				<input type="hidden" name="<%=lhSect4Task%>"  value="<%=trim(lProgressReportRs("WPR_SectionTask"))%>">				
<%
			end if

			if (eval(trim(lProgressReportRs("WPR_SectionNo"))) = 5) Then
				lSectIssuesCount = lSectIssuesCount + 1
				lSect5DataExists = true
				gSect5RowCount = gSect5RowCount + 1	
				lhSect5Task = "hSect5Task" & gSect5RowCount
				lSectNo = 5

				lStatusSelectStr = "<Select disabled name='sSect5IssueStatus" & gSect5RowCount & "'>" 
				if trim(lProgressReportRs("WPR_TaskStatus")) = "Open" Then
					lStatusSelectStr = lStatusSelectStr & "<OPTION Value='Open' selected>Open</OPTION>" & "<OPTION Value='Closed'>Closed</OPTION>"
				else 
					lStatusSelectStr = lStatusSelectStr & "<OPTION Value='Open'>Open</OPTION>" & "<OPTION Value='Closed' selected>Closed</OPTION>"
				end if				   
				lStatusSelectStr = lStatusSelectStr & "</SELECT>"
%>
   				<input type="hidden" name="<%=lhSect5Task%>"  value="<%=trim(lProgressReportRs("WPR_SectionTask"))%>">
<%
			end if
			
			ReDim Preserve lSectIssueNo(lSectIssuesCount-1)
			ReDim Preserve lSectIssue(lSectIssuesCount-1)
			ReDim Preserve lSectIssueStatus(lSectIssuesCount-1)
			ReDim Preserve lSectIssueRemarks(lSectIssuesCount-1)

			lSectIssueNo(lSectIssuesCount-1) = lSectNo
			lSectIssue(lSectIssuesCount-1) = trim(lProgressReportRs("WPR_SectionTask"))
			lSectIssueStatus(lSectIssuesCount-1) = lStatusSelectStr
			lSectIssueRemarks(lSectIssuesCount-1) = trim(lProgressReportRs("WPR_TaskRemarks"))

			lProgressReportRs.MoveNext
		wend
	end if
	
	Set lProgressReportRs = lTSObj.GetPRSectionNotes (eval(lEmpID1), eval(lProjectID), lMondayDate)
	if lProgressReportRs.RecordCount > 0 Then
		lProgressReportRs.MoveFirst 

		' Loop through timesheet recordset and create the html strings
		while not lProgressReportRs.EOF
			if (eval(trim(lProgressReportRs("WPR_SectionNo"))) = 6) Then		
				lSectNotesCount = lSectNotesCount + 1
				lSect6NotesDataExists = true
				gSect6NotesRowCount = gSect6NotesRowCount + 1	
				lhSect6NotesTask = "hSect6NotesTask" & gSect6NotesRowCount
				lSectNo = 6
%>
				<input type="hidden" name="<%=lhSect6NotesTask%>"  value="<%=trim(lProgressReportRs("WPR_TaskDescription"))%>">				
<%
			end if

			if (eval(trim(lProgressReportRs("WPR_SectionNo"))) = 7) Then		
				lSectNotesCount = lSectNotesCount + 1
				lSect6FlagsDataExists = true
				gSect6FlagsRowCount = gSect6FlagsRowCount + 1	
				lhSect6FlagsTask = "hSect6FlagsTask" & gSect6FlagsRowCount
				lSectNo = 7
%>
				<input type="hidden" name="<%=lhSect6FlagsTask%>"  value="<%=trim(lProgressReportRs("WPR_TaskDescription"))%>">				
<%
			end if
			
			ReDim Preserve lSectNotesNo(lSectNotesCount-1)
			ReDim Preserve lSectNotes(lSectNotesCount-1)
			
			lSectNotesNo(lSectNotesCount-1) =  lSectNo
			lSectNotes(lSectNotesCount-1) = trim(lProgressReportRs("WPR_TaskDescription"))

			lProgressReportRs.MoveNext
		wend
	end if

	if (lSect1DataExists Or lSect2DataExists Or lSect3DataExists Or lSect4DataExists Or lSect5DataExists Or lSect6NotesDataExists Or lSect6FlagsDataExists) Then
%>			
<center><B>Weekly Progress Report</B></center>
<table border=1 width="60%" align="center" BGCOLOR="white" STYLE="BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse">
<TR colspan="4">
	<TD align="left" bgcolor="yellow" width="20%"><B>Name</B></TD>
	<TD align="left" bgcolor="white" width="40%">&nbsp;<%=lEmpName%></TD>
	<TD align="left" bgcolor="yellow" width="20%"><B>Project</B></TD>
	<TD align="left" bgcolor="white" width="20%">&nbsp;<%=lProjectName%></TD>
</TR>
</table>
<table border=1 width="60%" align="center" BGCOLOR="white" STYLE="BORDER-COLLAPSE: collapse">
<TR cols="4">
	<TD align="left" bgcolor="yellow" width="20%"><B>From Date</B></TD>
	<TD align="left" bgcolor="white" width="40%">&nbsp;<%=lMondayDate%></TD>
	<TD align="left" bgcolor="yellow" width="20%"><B>To Date</B></TD>
	<TD align="left" bgcolor="white" width="20%">&nbsp;<%=lSundayDate%></TD>
</TR>
</table>
<BR>
<TABLE width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR colspan=1>
<TD width=100%><B>Section 1 : </B><font color="white">Achievements</font></TD>
</TR>
</TABLE>
<TABLE border=1 width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<TD width=40%><font color="white"><B>Task Description</B></font></TD>
<TD width=15%><font color="blue">Base Start</font></TD>
<TD width=15%><font color="blue">Base End</font></TD>
<TD width=15%><font color="orange">Actual Start</font></TD>
<TD width=15%><font color="orange">Actual End</font></TD>
</TR>
<TBODY ID="oTBody0"></TBODY>
</TABLE>

<TABLE width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR colspan=1>
<TD width=100%><B>Section 2 : </B><font color="white">Tasks in progress</font></TD>
</TR>
</TABLE>
<TABLE border=1 width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<TD width=40%><font color="white"><B>Task Description</B></font></TD>
<TD width=15%><font color="blue">Base Start</font></TD>
<TD width=15%><font color="blue">Base End</font></TD>
<TD width=15%><font color="orange">Actual Start</font></TD>
<TD width=15%><font color="orange">Actual End</font></TD>
</TR>
<TBODY ID="oTBody1"></TBODY>
</TABLE>

<TABLE width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR colspan=1>
<TD width=100%><B>Section 3 : </B><font color="white">Objectives for next two reporting periods</font></TD>
</TR>
</TABLE>
<TABLE border=1 width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<TD width=40%><font color="white"><B>Task Description</B></font></TD>
<TD width=15%><font color="blue">Base Start</font></TD>
<TD width=15%><font color="blue">Base End</font></TD>
<TD width=15%><font color="orange">Actual Start</font></TD>
<TD width=15%><font color="orange">Actual End</font></TD>
</TR>
<TBODY ID="oTBody2"></TBODY>
</TABLE>
<% 
	Dim lIdx1
	for lIdx1 = 0 To lSectDatesCount-1
%>
<script language="javascript">
		var lSect = <%=lSecDatesNo(lIdx1)%>;
		var lTaskDesc = "<%=lSect1TaskDesc(lIdx1)%>";
		var lBaseStart = "<%=lSect1TaskBaseStart(lIdx1)%>";
		var lBaseEnd = "<%=lSect1TaskBaseEnd(lIdx1)%>";
		var lActStart = "<%=lSect1TaskActStart(lIdx1)%>";
		var lActEnd = "<%=lSect1TaskActEnd(lIdx1)%>";
				
		CreateNewFilledSectDatesRow(lSect, lTaskDesc, lBaseStart,lBaseEnd ,lActStart, lActEnd);
</script>
<%
	next
%>
<TABLE width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR colspan=1>
<TD width=100%><B>Section 4 : </B><font color="white">Quality Assurance issues</font></TD>
</TR>
</TABLE>
<TABLE border=1 width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<TD width=50%><font color="white">Issues</font></TD>
<TD width=10%><font color="blue">Status</font></TD>
<TD width=40%><font color="white">Remarks</font></TD>
</TR>
<TBODY ID="oTBody3"></TBODY>
</TABLE>

<TABLE width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR colspan=1>
<TD width=100%><B>Section 5 : </B><font color="white">Process improvements</font></TD>
</TR>
</TABLE>
<TABLE border=1 width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<TD width=50%><font color="white">Improvements identified for implementation</font></TD>
<TD width=10%><font color="blue">Status</font></TD>
<TD width=40%><font color="white">Remarks</font></TD>
</TR>
<TBODY ID="oTBody4"></TBODY>
</TABLE>
<%
	for lIdx1 = 0 To lSectIssuesCount-1 
%>
		<script language="javascript">
			var lSect = <%=lSectIssueNo(lIdx1)%>;
			var lTaskDesc = "<%=lSectIssue(lIdx1)%>";
			var lStatus = "<%=lSectIssueStatus(lIdx1)%>";
			var lRemarks = "<%=lSectIssueRemarks(lIdx1)%>";
				
			CreateNewFilledSect45Row(lSect, lTaskDesc, lStatus, lRemarks);
		</script>
<%
	next
%>
<TABLE width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR colspan=1>
<TD width=100%><B>Section 6 : </B><font color="white">Notes</font></TD>
</TR>
</TABLE>
<TABLE border=1 width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR>
</TR>
<TBODY ID="oTBody5"></TBODY>
</TABLE>

<TABLE width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR colspan=1>
<TD width=100%><B>Section 6 : </B><font color="white">Red Flags</font></TD>
</TR>
</TABLE>
<TABLE border=1 width="75%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
<TR>
</TR>
<TBODY ID="oTBody6"></TBODY>
</TABLE>
<%
	for lIdx1 = 0 To lSectNotesCount-1 
%>
		<script language="javascript">
			var lSect = <%=lSectNotesNo(lIdx1)%>;
			var lTaskDesc = "<%=lSectNotes(lIdx1)%>";
				
			CreateNewFilledSectNotesRow(lSect, lTaskDesc);
		</script>
<%
	next
%>

<TABLE width="50%" align="center">
<TR>
	<TD align="middle">
	<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style="BACKGROUND-COLOR: aqua" id=button4 name=button4></TD>
</TR>
</TABLE>
<BR>
<TABLE width="50%" align="center">
<TR>
	<TD align="middle"><font class="footernote">To delete an entry set all hours to Zero.</font></TD>
</TR>
</TABLE>
<input type="hidden" name="hSect1RowCount" value="<%=gSect1RowCount%>">
<input type="hidden" name="hOriginalSect1RowCount" value="<%=gSect1RowCount%>">
<input type="hidden" name="hSect2RowCount" value="<%=gSect2RowCount%>">
<input type="hidden" name="hOriginalSect2RowCount" value="<%=gSect2RowCount%>">
<input type="hidden" name="hSect3RowCount" value="<%=gSect3RowCount%>">
<input type="hidden" name="hOriginalSect3RowCount" value="<%=gSect3RowCount%>">
<input type="hidden" name="hSect4RowCount" value="<%=gSect4RowCount%>">
<input type="hidden" name="hOriginalSect4RowCount" value="<%=gSect4RowCount%>">
<input type="hidden" name="hSect5RowCount" value="<%=gSect5RowCount%>">
<input type="hidden" name="hOriginalSect5RowCount" value="<%=gSect5RowCount%>">
<input type="hidden" name="hSect6NotesRowCount" value="<%=gSect6NotesRowCount%>">
<input type="hidden" name="hOriginalSect6NotesRowCount" value="<%=gSect6NotesRowCount%>">
<input type="hidden" name="hSect6FlagsRowCount" value="<%=gSect6FlagsRowCount%>">
<input type="hidden" name="hOriginalSect6FlagsRowCount" value="<%=gSect6FlagsRowCount%>">
</Form>
<script language="javascript">
gSect1RowCount=document.frmUpdateProgressReport.hSect1RowCount.value;
gSect2RowCount=document.frmUpdateProgressReport.hSect2RowCount.value;
gSect3RowCount=document.frmUpdateProgressReport.hSect3RowCount.value;
gSect4RowCount=document.frmUpdateProgressReport.hSect4RowCount.value;
gSect5RowCount=document.frmUpdateProgressReport.hSect5RowCount.value;
gSect6NotesRowCount=document.frmUpdateProgressReport.hSect6NotesRowCount.value;
gSect6FlagsRowCount=document.frmUpdateProgressReport.hSect6FlagsRowCount.value;
</script>
<%	 
	else
%>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Progress Report not available</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-weekly-progress-start.asp">Click here</A> to go to the Progress Report start page</TD>
</TR>
</TABLE>	
<%		
	end if

	Set lTSObj = Nothing
%>	
</BODY>
</HTML>
