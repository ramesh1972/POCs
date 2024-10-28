<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<TITLE></TITLE>
<LINK rel="stylesheet" href="theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<% ' Check the type of user and redirect
	Dim lUserType
	
	lUserType = Request.Cookies("EmployeeType")
	if (lUserType = "U") Then
		Response.Redirect("ts-reports-u-start.asp")
	end if
	
	if (lUserType = "G") Then
		Response.Redirect("ts-reports-g-start.asp")
	end if
%>
<% ' Get Default date
	Dim lDefaultDate
	lDefaultDate = FormatDateTime(Now(), vbShortDate)
%>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lGroupsRs
	Dim lUsersRs
	Dim lProjectsRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUsersRs = Server.CreateObject ("ADODB.RecordSet")
	Set lProjectsRs = Server.CreateObject ("ADODB.RecordSet")

	Set lGroupsRs = lTSObj.GetGroupDetails("") 
	Set lUsersRs = lTSObj.GetUserDetails ("") 
	Set lProjectsRs = lTSObj.GetProjects()
		
	'Create the select strings here
	Dim lGroupsSelectStr
	Dim lUsersSelectStr
	Dim lProjectsSelectStr
			
	lGroupsSelectStr = "<SELECT name='sGroups'>"
	lGroupsRs.MoveFirst 
	while not lGroupsRs.EOF 
		lGroupsSelectStr = lGroupsSelectStr & "<OPTION Value='" & trim(lGroupsRs("G_GroupID")) & "'>" & trim(lGroupsRs("G_GroupName")) & "</OPTION>"
		lGroupsRs.MoveNext 
	wend
	lGroupsSelectStr = lGroupsSelectStr & "</SELECT>"

	'Create the select strings here
	lUsersSelectStr = "<SELECT name='sUsers'><OPTION Value='" & lEmpID & "'>Self</OPTION>"  
	if lUsersRs.RecordCount > 0 Then
		lUsersRs.MoveFirst 
		while not lUsersRs.EOF 
			lUsersSelectStr = lUsersSelectStr & "<OPTION Value='" & trim(lUsersRs("U_Employee_ID")) & "'>" & trim(lUsersRs("U_Name")) & "</OPTION>"
			lUsersRs.MoveNext 
		wend
	End if
	lUsersSelectStr = lUsersSelectStr & "</SELECT>"

	' Create the select string for projects	
	lProjectsSelectStr = "<SELECT name='sProjects'>"
	if lProjectsRs.RecordCount > 0 Then
		lProjectsRs.MoveFirst 
		while not lProjectsRs.EOF 
			lProjectsSelectStr = lProjectsSelectStr & "<OPTION Value='" & trim(lProjectsRs("P_ProjectID")) & "'>" & trim(lProjectsRs("P_ProjectName")) & "</OPTION>"
			lProjectsRs.MoveNext 
		wend
	end if

	lProjectsSelectStr = lProjectsSelectStr & "</SELECT>"
	Set lTSObj = Nothing
	Set lGroupsRs = Nothing
	Set lProjectsRs = Nothing
%>
<script language="javascript">
function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || window.event.keyCode == 47 || window.event.keyCode == 13)) {
		event.returnValue = 0;
		alert("Please enter the date in mm/dd/yy format.\n where mm, dd, yy are numbers");
	}
}

function ValidatefrmReportsUserView() {
	var lTSDate = document.frmReportsUserView.ebReportDate.value;
	
	if (lTSDate == "") {
		alert("Please enter a date");
		document.frmReportsUserView.ebReportDate.focus();
		return false;
	}
	
	return true;
}

function ValidatefrmReportsGroupView() {
	var lTSDate = document.frmReportsGroupView.ebReportDate.value;
	
	if (lTSDate == "") {
		alert("Please enter a date");
		document.frmReportsGroupView.ebReportDate.focus();
		return false;
	}
	
	return true;
}

function ValidateReportsConsEmpView() {
	var lTSFromDate = document.frmReportsConsEmpView.ebReportFromDate.value;
	var lTSToDate = document.frmReportsConsEmpView.ebReportToDate.value;
	
	if (lTSFromDate == "") {
		alert("Please enter a From date");
		document.frmReportsConsEmpView.ebReportFromDate.focus();
		return false;
	}
	
	if (lTSToDate == "") {
		alert("Please enter a To date");
		document.frmReportsConsEmpView.ebReportToDate.focus();
		return false;
	}

	return true;
}

function ValidatefrmReportsConsGroupView() {
	var lTSFromDate = document.frmReportsConsGroupView.ebReportFromDate.value;
	var lTSToDate = document.frmReportsConsGroupView.ebReportToDate.value;
	
	if (lTSFromDate == "") {
		alert("Please enter a From date");
		document.frmReportsConsGroupView.ebReportFromDate.focus();
		return false;
	}
	
	if (lTSToDate == "") {
		alert("Please enter a To date");
		document.frmReportsConsGroupView.ebReportToDate.focus();
		return false;
	}

	return true;
}

function ValidateReportsConsProjectView() {
	var lTSFromDate = document.frmReportsConsProjectView.ebReportFromDate.value;
	var lTSToDate = document.frmReportsConsProjectView.ebReportToDate.value;
	
	if (lTSFromDate == "") {
		alert("Please enter a From date");
		document.frmReportsConsProjectView.ebReportFromDate.focus();
		return false;
	}
	
	if (lTSToDate == "") {
		alert("Please enter a To date");
		document.frmReportsConsProjectView.ebReportToDate.focus();
		return false;
	}

	return true;
}

function ValidateReportsProgressView() {
	var lTSFromDate = document.frmReportsProgressView.ebReportDate.value;
	
	if (lTSFromDate == "") {
		alert("Please enter a date");
		document.frmReportsProgressView.ebReportDate.focus();
		return false;
	}
	
	return true;
}


</script>
<style>

A:hover
{
	color: red; 
	text-decoration: underline; 
	font-weigth:bold;
}
.linkstyle_head
{
	color: #000080; 
	font-size: 11pt; 
	text-decoration: none; 
}

.linkstyle_row
{
	color: #000080; 
	font-size: 8pt; 
	text-decoration: none; 
}
</style>

<script language="JScript">
// Global vars
var bExpanded0;
var bHeaderCreated0;
var bExpanded1;
var bHeaderCreated1;
var bExpanded2;
var bHeaderCreated2;
var bExpanded3;
var bHeaderCreated3;
var bExpanded4;
var bHeaderCreated4;
var bExpanded5;
var bHeaderCreated5;

// Init vars
bExpanded0 = false;
bHeaderCreated0 = false;
bExpanded1 = false;
bHeaderCreated1 = false;
bExpanded2 = false;
bHeaderCreated2 = false;
bExpanded3 = false;
bHeaderCreated3 = false;
bExpanded4 = false;
bHeaderCreated4 = false;
bExpanded5 = false;
bHeaderCreated5 = false;

function OnClickReportDate() {
	window.status = "Generating Report...";
}

// Function to expand and collapse listings
function ExpandCollapse0() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded0 == true) {
		iLen = oTBody0.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody0.deleteRow();
		}
		bExpanded0 = false;
	}
	else {
		CreateBody0();
	}
}

// Function to expand and collapse listings
function ExpandCollapse1() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded1 == true) {
		iLen = oTBody1.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody1.deleteRow();
		}
		bExpanded1 = false;
	}
	else {
		CreateBody1();
	}
}

// Function to expand and collapse listings
function ExpandCollapse2() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded2 == true) {
		iLen = oTBody2.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody2.deleteRow();
		}
		bExpanded2 = false;
	}
	else {
		CreateBody2();
	}
}

// Function to expand and collapse listings
function ExpandCollapse3() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded3 == true) {
		iLen = oTBody3.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody3.deleteRow();
		}
		bExpanded3 = false;
	}
	else {
		CreateBody3();
	}
}

// Function to expand and collapse listings
function ExpandCollapse4() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded4 == true) {
		iLen = oTBody4.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody4.deleteRow();
		}
		bExpanded4 = false;
	}
	else {
		CreateBody4();
	}
}

// Function to expand and collapse listings
function ExpandCollapse5() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded5 == true) {
		iLen = oTBody5.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody5.deleteRow();
		}
		bExpanded5 = false;
	}
	else {
		CreateBody5();
	}
}

// Function to create the tbody innerHTML content
function CreateBody0() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody0Count;
	
	// Init vars
	bExpanded0 = true;
	iBody0Count = 2;

	// Hrefs and Description
	var aLinks = new Array;
	var aDesc = new Array;
 
	aLinks[0] = "Generate Employee Weekly TimeSheet";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmReportsUserView' method='POST' action='ts-reports-gen-user.asp' onsubmit='return ValidatefrmReportsUserView();'><TABLE><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD>Enter Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportDate' value='<%=lDefaultDate%>' onclick=OnClickReportDate(); onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD colspan=2 align='center'><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody0Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreated0 == false) {
				oRow = oTBody0.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse0()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated0 = true;
			}
		}
		else {
			oRow = oTBody0.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}

	// Set the background color of the first body.
//	oTBody0.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBody1() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody1Count;
	var in_html;
	
	// Init vars
	bExpanded1 = true;
	iBody1Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Consolidate Group Weekly TimeSheet";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";
	
	in_html = "<FORM name='frmReportsGroupView' method='POST' action='ts-reports-gen-group.asp' onsubmit='return ValidatefrmReportsGroupView();'><TABLE><TR><TD>Enter Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD>Select Group<TD><%=lGroupsSelectStr%></TD><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD colspan=2 align='center'><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody1Count; iIdx++)
  	{
		if (iIdx == 0) {
			if (bHeaderCreated1 == false) {
				oRow = oTBody1.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse1()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated1 = true;
			}
		}
		else {
			oRow = oTBody1.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}
}

// Function to create the tbody innerHTML content
function CreateBody2() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody2Count;
	var in_html;
	
	// Init vars
	bExpanded2 = true;
	iBody2Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Consolidate TimeSheets for an Employee";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";
	
	in_html = "<FORM name='frmReportsConsEmpView' method='POST' action='ts-reports-gen-cons-user.asp' onsubmit='return ValidateReportsConsEmpView();'><TABLE><TR><TD>Select Employee<TD><%=lUsersSelectStr%></TD></TR><TR><TD>Enter From Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportFromDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD>Enter To Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportToDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody2Count; iIdx++)
  	{
		if (iIdx == 0) {
			if (bHeaderCreated2 == false) {
				oRow = oTBody2.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse2()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated2 = true;
			}
		}
		else {
			oRow = oTBody2.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}
}

// Function to create the tbody innerHTML content
function CreateBody3() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody3Count;
	var in_html;
	
	// Init vars
	bExpanded3 = true;
	iBody3Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Consolidate TimeSheets for a Group";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";
	
	in_html = "<FORM name='frmReportsConsGroupView' method='POST' action='ts-reports-gen-cons-group.asp' onsubmit='return ValidatefrmReportsConsGroupView();'><TABLE><TR><TD>Select Group<TD><%=lGroupsSelectStr%></TD></TR><TR><TD>Enter From Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportFromDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD>Enter To Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportToDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody3Count; iIdx++)
  	{
		if (iIdx == 0) {
			if (bHeaderCreated3 == false) {
				oRow = oTBody3.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse3()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated3 = true;
			}
		}
		else {
			oRow = oTBody3.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}
}

// Function to create the tbody innerHTML content
function CreateBody4() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody4Count;
	var in_html;
	
	// Init vars
	bExpanded4 = true;
	iBody4Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Consolidate TimeSheets for a Project";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";
	
	in_html = "<FORM name='frmReportsConsProjectView' method='POST' action='ts-reports-gen-cons-project.asp' onsubmit='return ValidateReportsConsProjectView();'><TABLE><TR><TD>Select Project<TD><%=lProjectsSelectStr%></TD></TR><TR><TD>Enter From Date<BR>(mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportFromDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD>Enter To Date <BR>(mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportToDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody4Count; iIdx++)
  	{
		if (iIdx == 0) {
			if (bHeaderCreated4 == false) {
				oRow = oTBody4.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse4()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated4 = true;
			}
		}
		else {
			oRow = oTBody4.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}
}

// Function to create the tbody innerHTML content
function CreateBody5() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody5Count;
	var in_html;
	
	// Init vars
	bExpanded5 = true;
	iBody5Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Generate Employee Weekly Progress Report";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";
	
	in_html = "<FORM name='frmReportsProgressView' method='POST' action='ts-reports-gen-user-progress.asp' onsubmit='return ValidateReportsProgressView();'><TABLE><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD>Select Project<TD><%=lProjectsSelectStr%></TD></TR><TR><TD>Enter Date<BR>(mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebReportDate' value='<%=lDefaultDate%>' onclick='OnClickReportDate();' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody5Count; iIdx++)
  	{
		if (iIdx == 0) {
			if (bHeaderCreated5 == false) {
				oRow = oTBody5.insertRow();
				oCell = oRow.insertCell();
					oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse5()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated5 = true;
			}
		}
		else {
			oRow = oTBody5.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}
}
function CheckIfDefaultDate(str) {
	if (str == "dd/mm/yyyy") {
		return true;
	}
	return false;
}
</SCRIPT>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivReports.style.background = "lightblue";
</script>
<BR>
<TABLE width=300 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Reports Start Page</font></TD>
</TR>
</TABLE>
<TABLE width=300 align="center" ID="oTable0" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody0"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable1" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody1"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable2" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody2"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable3" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody3"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable4" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody4"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable5" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody5"></TBODY>
</TABLE>

<SCRIPT language="JScript">
CreateBody0();
ExpandCollapse0();
CreateBody1();
ExpandCollapse1();
CreateBody2();
ExpandCollapse2();
CreateBody3();
ExpandCollapse3();
CreateBody4();
ExpandCollapse4();
CreateBody5();
ExpandCollapse5();
</SCRIPT>
</BODY>
</HTML>
