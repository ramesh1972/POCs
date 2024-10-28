<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<TITLE></TITLE>
<LINK rel="stylesheet" href="../timesheet/theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies ("BugsGroupID")
	if lBugsGroupID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<%
	Dim lGroupID
	
	lGroupID = Request.Form("sBugsGroups")
%>
<% ' Check the type of user and redirect
	Dim lUserType
	
	lUserType = Request.Cookies("EmployeeType")
	if (lUserType = "U") Then
		Response.Redirect("ts-groups-u-view-all.asp")
	end if
	
	if (lUserType = "G") Then
		Response.Redirect("ts-groups-g-start.asp")
	end if
%>
<% 'Get all required data from the database
	Dim lSBObj
	Dim lStatusRs

	' Get projects
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lStatusRs = Server.CreateObject ("ADODB.RecordSet")
	Set lStatusRs = lSBObj.GetAllBugsStatus() 

	'Create the select strings here
	Dim lStatusSelectStr
	
	lStatusSelectStr = "<SELECT name='sStatus' onchange='ChangeStatus();'>"
	if lStatusRs.RecordCount > 0 Then
		lStatusRs.MoveFirst 
		while not lStatusRs.EOF 
			lStatusSelectStr = lStatusSelectStr & "<OPTION Value='" & trim(lStatusRs("S_StatusID")) & "'>" & trim(lStatusRs("S_Status")) & "</OPTION>"
			lStatusRs.MoveNext 
		wend
	end if
	lStatusSelectStr = lStatusSelectStr & "</SELECT>"

	Dim lPriorityRs

	' Get projects
	Set lPriorityRs = Server.CreateObject ("ADODB.RecordSet")
	Set lPriorityRs = lSBObj.GetAllBugsPriority() 

	'Create the select strings here
	Dim lPrioritySelectStr
	
	lPrioritySelectStr = "<SELECT name='sPriority' onchange='ChangePriority();'>"
	if lPriorityRs.RecordCount > 0 Then
		lPriorityRs.MoveFirst 
		while not lPriorityRs.EOF 
			lPrioritySelectStr = lPrioritySelectStr & "<OPTION Value='" & trim(lPriorityRs("P_PriorityID")) & "'>" & trim(lPriorityRs("P_Priority")) & "</OPTION>"
			lPriorityRs.MoveNext 
		wend
	end if
	lPrioritySelectStr = lPrioritySelectStr & "</SELECT>"

	Dim lSeverityRs

	' Get projects
	Set lSeverityRs = Server.CreateObject ("ADODB.RecordSet")
	Set lSeverityRs = lSBObj.GetAllBugsSeverity() 

	'Create the select strings here
	Dim lSeveritySelectStr
	
	lSeveritySelectStr = "<SELECT name='sSeverity' onchange='ChangeSeverity();'>"
	if lSeverityRs.RecordCount > 0 Then
		lSeverityRs.MoveFirst 
		while not lSeverityRs.EOF 
			lSeveritySelectStr = lSeveritySelectStr & "<OPTION Value='" & trim(lSeverityRs("S_SeverityID")) & "'>" & trim(lSeverityRs("S_Severity")) & "</OPTION>"
			lSeverityRs.MoveNext 
		wend
	end if
	lSeveritySelectStr = lSeveritySelectStr & "</SELECT>"

	Set lSBObj = Nothing
	Set lStatusRs = Nothing
	Set lPriorityRs = Nothing
	Set lSeverityRs = Nothing
%>
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
var bExpanded6;
var bHeaderCreated6;
var bExpanded7;
var bHeaderCreated7;

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
bExpanded6 = false;
bHeaderCreated6 = false;
bExpanded7 = false;
bHeaderCreated7 = false;

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

// Function to expand and collapse listings
function ExpandCollapse6() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded6 == true) {
		iLen = oTBody6.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody6.deleteRow();
		}
		bExpanded6 = false;
	}
	else {
		CreateBody6();
	}
}

// Function to expand and collapse listings
function ExpandCollapse7() {
	var iIdx,iLen;
	
	// If expanding call CreateBody0 else collapse
	if (bExpanded7 == true) {
		iLen = oTBody7.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBody7.deleteRow();
		}
		bExpanded7 = false;
	}
	else {
		CreateBody7();
	}
}

// Function to create the tbody innerHTML content
function CreateBody0() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody0Count;
	
	// Init vars
	bExpanded0 = true;
	iBody0Count = 1;

	// Hrefs and Description
	var aLinks = new Array;
	var aDesc = new Array;
 
	aLinks[0] = "View All Categories";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody0Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreated0 == false) {
				oRow = oTBody0.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href='psdb-bugs-cat-view.asp'><B>" + aLinks[iIdx] + "</B></A>";	
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

	aLinks[0] = "Add Status";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmAddStatus' method='Post' action='psdb-bugs-status-add.asp' onsubmit='return ValidateAddStatus();'><TABLE width=300><TR><TD width=150>Enter Status</TD><TD><INPUT type='text' maxlength=64 name='ebStatus'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Add style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";

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

	// Set the background color of the first body.
//	oTBody1.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBody2() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody2Count;
	
	// Init vars
	bExpanded2 = true;
	iBody2Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Update Status";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUpdateStatus' method='Post' action='psdb-bugs-status-update.asp' onsubmit='return ValidateUpdateStatus();'><input type=hidden name='hStatusID' value=''><TABLE width=300><TR><TD width=150>Select Status</TD><TD><%=lStatusSelectStr%></TD></TR><TR><TD width=150>Update Status</TD><TD><INPUT type='text' maxlength=64 name='ebStatus'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";

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

	ChangeStatus();
	// Set the background color of the first body.
//	oTBody2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBody3() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody3Count;
	
	// Init vars
	bExpanded3 = true;
	iBody3Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Add Priority";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmAddPriority' method='Post' action='psdb-bugs-priority-add.asp' onsubmit='return ValidateAddPriority();'><TABLE width=300><TR><TD width=150>Enter Priority</TD><TD><INPUT type='text' maxlength=64 name='ebPriority'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Add style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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

	// Set the background color of the first body.
//	oTBody2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBody4() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody4Count;
	
	// Init vars
	bExpanded4 = true;
	iBody4Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Update Priority";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUpdatePriority' method='Post' action='psdb-bugs-priority-update.asp' onsubmit='return ValidateUpdatePriority();'><input type=hidden name='hPriorityID' value=''><TABLE width=300><TR><TD width=150>Select Priority</TD><TD><%=lPrioritySelectStr%></TD></TR><TR><TD width=150>Update Priority</TD><TD><INPUT type='text' maxlength=64 name='ebPriority'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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

		ChangePriority();
	// Set the background color of the first body.
//	oTBody2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBody5() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody5Count;
	
	// Init vars
	bExpanded5 = true;
	iBody5Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Add Severity";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmAddSeverity' method='Post' action='psdb-bugs-severity-add.asp' onsubmit='return ValidateAddSeverity();'><TABLE width=300><TR><TD width=150>Enter Severity</TD><TD><INPUT type='text' maxlength=64 name='ebSeverity'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Add style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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

	// Set the background color of the first body.
//	oTBody2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBody6() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody6Count;
	
	// Init vars
	bExpanded6 = true;
	iBody6Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Update Severity";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUpdateSeverity' method='Post' action='psdb-bugs-severity-update.asp' onsubmit='return ValidateUpdateSeverity();'><input type=hidden name='hSeverityID' value=''><TABLE width=300><TR><TD width=150>Select Severity</TD><TD><%=lSeveritySelectStr%></TD></TR><TR><TD width=150>Update Severity</TD><TD><INPUT type='text' maxlength=64 name='ebSeverity'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody6Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreated6 == false) {
				oRow = oTBody6.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse6()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated6 = true;
			}
		}
		else {
			oRow = oTBody6.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	ChangeSeverity();
	// Set the background color of the first body.
//	oTBody2.bgColor = "lemonchiffon";
}

function CreateBody7() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody7Count;
	
	// Init vars
	bExpanded7 = true;
	iBody7Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Update Severity";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmRemoveGroupsFromBugsDomain' method='Post' action='ts-groups-remove-bugs-groups.asp' onsubmit='return onClickBugsGroupsRemove();'>" + 
			  "<TABLE width=300><input type='hidden' name='hRemovedGroups' value=''>" + 
  		      "<tr><td>Multiple Select Groups to Remove</td></tr>" + 
  		      "<tr><td align='left' height='16' class='tdbglight'><SELECT multiple size=5 name='sBugsGroups' style='HEIGHT: 86px; WIDTH: 150px'><%=lBugsGroupsSelectStr%></select></td></tr>" + 
	  	      "<tr><td colspan=3 valign='center' align=middle><input type='submit' name='sRemoveGroups' value='Remove Groups' style='BACKGROUND-COLOR: aqua'></td></tr>" + 
	  	      "</TABLE></FORM>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody7Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreated7 == false) {
				oRow = oTBody7.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapse7()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreated7 = true;
			}
		}
		else {
			oRow = oTBody7.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBody2.bgColor = "lemonchiffon";
}

function ValidateAddStatus() {
	var lStatus;

	lStatus = document.frmAddStatus.ebStatus.value;
	if (lStatus == "") {
		alert("Please enter the Status");
		document.frmAddStatus.ebStatus.focus();
		return false;
	}
	
	return true;
}

function ValidateUpdateStatus() {
	var lStatus;

	lStatus = document.frmUpdateStatus.ebStatus.value;
	if (lStatus == "") {
		alert("Please enter the Status");
		document.frmUpdateStatus.ebStatus.focus();
		return false;
	}
	
	return true;
}

function ChangeStatus() {
	var lStatus;

	lStatus = document.frmUpdateStatus.sStatus.options[document.frmUpdateStatus.sStatus.selectedIndex].text;
	document.frmUpdateStatus.ebStatus.value = lStatus;

	document.frmUpdateStatus.hStatusID.value=document.frmUpdateStatus.sStatus.value;
}

function ValidateAddPriority() {
	var lPriority;

	lPriority = document.frmAddPriority.ebPriority.value;
	if (lPriority == "") {
		alert("Please enter the Priority");
		document.frmAddPriority.ebPriority.focus();
		return false;
	}
	
	return true;
}

function ValidateUpdatePriority() {
	var lPriority;

	lPriority = document.frmUpdatePriority.ebPriority.value;
	if (lPriority == "") {
		alert("Please enter the Priority");
		document.frmUpdatePriority.ebPriority.focus();
		return false;
	}
	
	return true;
}

function ChangePriority() {
	var lPriority;

	lPriority = document.frmUpdatePriority.sPriority.options[document.frmUpdatePriority.sPriority.selectedIndex].text;
	document.frmUpdatePriority.ebPriority.value = lPriority;

	document.frmUpdatePriority.hPriorityID.value=document.frmUpdatePriority.sPriority.value;
}

function ValidateAddSeverity() {
	var lSeverity;

	lSeverity = document.frmAddSeverity.ebSeverity.value;
	if (lSeverity == "") {
		alert("Please enter the Severity");
		document.frmAddSeverity.ebSeverity.focus();
		return false;
	}
	
	return true;
}

function ValidateUpdateSeverity() {
	var lSeverity;

	lSeverity = document.frmUpdateSeverity.ebSeverity.value;
	if (lSeverity == "") {
		alert("Please enter the Severity");
		document.frmUpdateSeverity.ebSeverity.focus();
		return false;
	}
	
	return true;
}

function ChangeSeverity() {
	var lSeverity;

	lSeverity = document.frmUpdateSeverity.sSeverity.options[document.frmUpdateSeverity.sSeverity.selectedIndex].text;
	document.frmUpdateSeverity.ebSeverity.value = lSeverity;

	document.frmUpdateSeverity.hSeverityID.value=document.frmUpdateSeverity.sSeverity.value;
}
</SCRIPT>
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>
<TABLE width=350 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Categories Management Start Page</font></TD>
</TR>
</TABLE>
<TABLE width=350 align="center" ID="oTable" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody0"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTable1" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody1"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTable2" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody2"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTable3" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody3"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTable4" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody4"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTable5" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody5"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTable6" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody6"></TBODY>
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
CreateBody6();
ExpandCollapse6();
</SCRIPT>
</BODY>
</HTML>
