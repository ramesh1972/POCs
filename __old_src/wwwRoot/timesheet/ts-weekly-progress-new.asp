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
	Dim lNewDate
	Dim lDayOfWeek	
	Dim lMondayDate
	Dim lSundayDate
	
	' Get request parameters
	lNewDate=Request.Form("ebDateNew")
	
	' Find out the day of the week and compute monday and sunday dates
	lDayOfWeek=WeekDay(CDate(lNewDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if
	
	lMondayDate = CDate(lNewDate)-(lDayOfWeek-vbMonday)
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
function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || window.event.keyCode == 47 || window.event.keyCode == 13)) {
		event.returnValue = 0;
		alert("Please enter the date in mm/dd/yy format.\n where mm, dd, yy are numbers");
	}
}

function OnClickStartPage() {
	document.location.href="ts-weekly-progress-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0" background="">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivPR.style.background = "lightblue";
</script>
<BR>
<% ' Get the Employee Name
	Dim lEmpName
	Dim lEmpRs
	
	Set lEmpRs = Server.CreateObject ("ADODB.RecordSet")
	Set lEmpRs = lTSObj.GetUserProfile (lEmpID)
	
	lEmpName = "Unknown"
	if lEmpRs.RecordCount > 0 Then
		lEmpName = trim(lEmpRs("U_Name"))
	End If
%>
<script language="javascript">
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
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskBaseStart" + gSect1RowCount + "' value='<%=lMondayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskBaseEnd" + gSect1RowCount + "' value='<%=lSundayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskActStart" + gSect1RowCount + "' value='<%=lMondayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect1TaskActEnd" + gSect1RowCount + "' value='<%=lSundayDate%>' onkeypress='ValidateInteger();'>";    

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
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskBaseStart" + gSect2RowCount + "' value='<%=lMondayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskBaseEnd" + gSect2RowCount + "' value='<%=lSundayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskActStart" + gSect2RowCount + "' value='<%=lMondayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect2TaskActEnd" + gSect2RowCount + "' value='<%=lSundayDate%>' onkeypress='ValidateInteger();'>";    

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
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskBaseStart" + gSect3RowCount + "' value='<%=lMondayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskBaseEnd" + gSect3RowCount + "' value='<%=lSundayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskActStart" + gSect3RowCount + "' value='<%=lMondayDate%>' onkeypress='ValidateInteger();'>";    

	oCell = oRow.insertCell();
	oCell.innerHTML = "<INPUT type='text' size='10' maxlength=10 name='ebSect3TaskActEnd" + gSect3RowCount + "' value='<%=lSundayDate%>' onkeypress='ValidateInteger();'>";    

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
</script>

<% 'Check if time sheet exists
	Dim lTSExists

	lTSExists = False
	lTSExists = lTSObj.CheckIfPRExists (eval(lEmpID), lMondayDate, eval(lProjectID))
	if Not lTSExists Then	 
%>
<FORM name="frmNewProgressReport" method="post" action="ts-weekly-progress-add.asp">
<input type="hidden" name="hSect1RowCount">
<input type="hidden" name="hSect2RowCount">
<input type="hidden" name="hSect3RowCount">
<input type="hidden" name="hSect4RowCount">
<input type="hidden" name="hSect5RowCount">
<input type="hidden" name="hSect6NotesRowCount">
<input type="hidden" name="hSect6FlagsRowCount">
<input type="hidden" name="hProjectID" value="<%=lProjectID%>">
<input type="hidden" name="hMonDate" value="<%=lMondayDate%>">
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
<script language="javascript">
CreateSection1NewRow();
</script>

<TABLE width="75%" align="center">
<TR>
	<TD align="center"><INPUT type="button" Value="New Entry" onclick="CreateSection1NewRow();" style="BACKGROUND-COLOR: aqua"></TD>
</TR>
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
<script language="javascript">
CreateSection2NewRow();
</script>

<TABLE width="75%" align="center">
<TR>
	<TD align="center"><INPUT type="button" Value="New Entry" onclick="CreateSection2NewRow();" style="BACKGROUND-COLOR: aqua" id=button1 name=button1></TD>
</TR>
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
<script language="javascript">
CreateSection3NewRow();
</script>

<TABLE width="75%" align="center">
<TR>
	<TD align="center"><INPUT type="button" Value="New Entry" onclick="CreateSection3NewRow();" style="BACKGROUND-COLOR: aqua"></TD>
</TR>
</TABLE>

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
<script language="javascript">
CreateSection4NewRow();
</script>

<TABLE width="75%" align="center">
<TR>
	<TD align="center"><INPUT type="button" Value="New Entry" onclick="CreateSection4NewRow();" style="BACKGROUND-COLOR: aqua" id=button2 name=button2></TD>
</TR>
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
<script language="javascript">
CreateSection5NewRow();
</script>

<TABLE width="75%" align="center">
<TR>
	<TD align="center"><INPUT type="button" Value="New Entry" onclick="CreateSection5NewRow();" style="BACKGROUND-COLOR: aqua" id=button2 name=button2></TD>
</TR>
</TABLE>

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
<script language="javascript">
CreateSection6NotesNewRow();
</script>

<TABLE width="75%" align="center">
<TR>
	<TD align="center"><INPUT type="button" Value="New Entry" onclick="CreateSection6NotesNewRow();" style="BACKGROUND-COLOR: aqua" id=button2 name=button2></TD>
</TR>
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
<script language="javascript">
CreateSection6FlagsNewRow();
</script>

<TABLE width="75%" align="center">
<TR>
	<TD align="center"><INPUT type="button" Value="New Entry" onclick="CreateSection6FlagsNewRow();" style="BACKGROUND-COLOR: aqua" id=button2 name=button2></TD>
</TR>
</TABLE>

<TABLE width="50%" align="center">
<TR>
	<TD align="middle">
	<INPUT type="submit" Value="Save Progress Report" style="BACKGROUND-COLOR: aqua">
	<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style="BACKGROUND-COLOR: aqua"></TD>
</TR>
</TABLE>
<BR>
<TABLE width="50%" align="center">
<TR>
	<TD align="middle"><font class="footernote">To delete an entry leave the Task or Issue or Note or Red Flag empty.</font></TD>
</TR>
</TABLE>
</FORM>
<% else %>
<TABLE align="center" width=400 class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD><font class="whiteboldtext">Progress Report already exists</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="middle"><A href="ts-weekly-progress-start.asp">Click here</A> to go to the Progrss Report start page</TD>
</TR>
</TABLE>	
<% end if 
	Set lTSObj = Nothing
	Set lProjectsRs = Nothing
	Set lCodesRs = Nothing
	Set lEmpRs = Nothing
%>
</BODY>
</HTML>
