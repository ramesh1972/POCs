<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<script language="javascript">
function ValidatefrmModuleAdd() {
	var lGroupName;

	lGroupName = document.frmGroupModulesAdd.ebModule.value;
	if (lGroupName == "") {
		alert("Please enter the Module name");
		document.frmGroupModulesAdd.ebModule.focus();
		return false;
	}
	
	return true;
}
</script>
<TITLE></TITLE>
<LINK rel="stylesheet" href="theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<%  ' Check if the user is logged in
	Dim lEmpAdmin
	Dim lEmpProjectLead
	Dim lTSObj
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lEmpAdmin = lTSObj.CheckIfAdministrator(eval(lEmpID))
	lEmpProjectLead = lTSObj.CheckIfGroupLead(eval(lEmpID), 0)
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

<% 'Get all required data from the database
	Dim lUsersRs
	Dim lUsersRs1
	Dim lUsersIDRs	
	
	' Get projects
	Set lUsersRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUsersRs1 = Server.CreateObject ("ADODB.RecordSet")
	Set lUsersIDRs = Server.CreateObject ("ADODB.RecordSet")
	
	Set lUsersRs = lTSObj.GetUserList()
	Set lUsersRs1 = lTSObj.GetUserDetails ("") 
	Set lUsersIDRs = lTSObj.GetUserIDList() 

	'Create the select strings here
	Dim lUsersSelectStr
	Dim lUsersSelectStr1
	Dim lUsersIDSelectStr			
	
	lUsersSelectStr = "<SELECT name='sUsers'>"
	if lUsersRs.RecordCount > 0 Then
		lUsersRs.MoveFirst 
		while not lUsersRs.EOF 
			lUsersSelectStr = lUsersSelectStr & "<OPTION Value='" & trim(lUsersRs("U_Name")) & "'>" & trim(lUsersRs("U_Name")) & "</OPTION>"
			lUsersRs.MoveNext 
		wend
	End if
	lUsersSelectStr = lUsersSelectStr & "</SELECT>"

		'Create the select strings here
	lUsersSelectStr1 = "<SELECT name='sUsers'>"  
	if lUsersRs1.RecordCount > 0 Then
		lUsersRs1.MoveFirst 
		while not lUsersRs1.EOF 
			lUsersSelectStr1 = lUsersSelectStr1 & "<OPTION Value='" & trim(lUsersRs1("U_Employee_ID")) & "'>" & trim(lUsersRs1("U_Name")) & "</OPTION>"
			lUsersRs1.MoveNext 
		wend
	End if
	lUsersSelectStr1 = lUsersSelectStr1 & "</SELECT>"

	lUsersIDSelectStr = "<SELECT name='sUsers'>"
	If lUsersIDRs.RecordCount > 0 Then
		lUsersIDRs.MoveFirst 
		while not lUsersIDRs.EOF 
			lUsersIDSelectStr = lUsersIDSelectStr & "<OPTION Value='" & trim(lUsersIDRs("U_Employee_ID")) & "'>" & trim(lUsersIDRs("U_Employee_ID")) & "</OPTION>"
			lUsersIDRs.MoveNext 
		wend
	End if
	lUsersIDSelectStr = lUsersIDSelectStr & "</SELECT>"

	Set lUsersRs = Nothing
	Set lUsersIDRs = Nothing	
%>
<% 'Get all required data from the database
	Dim lGroupsRs
	Dim lGroupsRs1

	' Get projects
	Set lGroupsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupsRs1 = Server.CreateObject ("ADODB.RecordSet")
	
	Set lGroupsRs = lTSObj.GetGroupNameList ()

	If lEmpAdmin = true then
		Set lGroupsRs1 = lTSObj.GetGroupDetails("")  
	else
		' get the projects for which the emp is a lead
		Set lGroupsRs1 = lTSObj.GetGroupIDListForLeader(eval(lEmpID)) 
	end if

	'Create the select strings here
	Dim lGroupsSelectStr
	Dim lGroupsSelectStr1

	lGroupsSelectStr = "<SELECT name='sGroups'>"
	if lGroupsRs.RecordCount > 0 Then
		lGroupsRs.MoveFirst 
		while not lGroupsRs.EOF 
			lGroupsSelectStr = lGroupsSelectStr & "<OPTION Value='" & trim(lGroupsRs("G_GroupName")) & "'>" & trim(lGroupsRs("G_GroupName")) & "</OPTION>"
			lGroupsRs.MoveNext 
		wend
	end if
	lGroupsSelectStr = lGroupsSelectStr & "</SELECT>"
	
	lGroupsSelectStr1 = "<SELECT name='sGroups'>"
	if lGroupsRs1.RecordCount > 0 Then
		lGroupsRs1.MoveFirst 
		while not lGroupsRs1.EOF 
			lGroupsSelectStr1 = lGroupsSelectStr1 & "<OPTION Value='" & trim(lGroupsRs1("G_GroupID")) & "'>" & trim(lGroupsRs1("G_GroupName")) & "</OPTION>"
			lGroupsRs1.MoveNext 
		wend
	end if
	lGroupsSelectStr1 = lGroupsSelectStr1 & "</SELECT>"
%>
<% 'Get all required data from the database
	Dim lBugsGroupsRs
	Dim lBugsGroupsSelectStr
	Dim lAllGroupsSelectStr
	Dim lFound
	Dim lOrgBugsGroupsCount
	
	' Get bugs groups
	Set lBugsGroupsRs = Server.CreateObject ("ADODB.RecordSet")		
	Set lBugsGroupsRs = lTSObj.GetBugsGroups ()
	
	'Create the select strings here
	lOrgBugsGroupsCount = 0
	lBugsGroupsSelectStr = ""
	lAllGroupsSelectStr = ""
	
	if lGroupsRs1.RecordCount > 0 Then
		lGroupsRs1.MoveFirst 
		while not lGroupsRs1.EOF 
			lFound = False
			if lBugsGroupsRs.RecordCount > 0 Then
				lBugsGroupsRs.MoveFirst 
				do while not lBugsGroupsRs.EOF
					if (trim(lBugsGroupsRs("G_GroupID")) = trim(lGroupsRs1("G_GroupID")) And trim(lBugsGroupsRs("G_InBugsDomain")) = "Y") Then	
						lOrgBugsGroupsCount = lOrgBugsGroupsCount + 1
						lFound = True
						lBugsGroupsSelectStr = lBugsGroupsSelectStr & "<OPTION Value='" & trim(lBugsGroupsRs("G_GroupID")) & "'>" & trim(lBugsGroupsRs("G_GroupName")) & "</OPTION>"
						exit do
					End if
					lBugsGroupsRs.MoveNext 
				loop
			End if
			if not lFound Then
				lAllGroupsSelectStr = lAllGroupsSelectStr & "<OPTION Value='" & trim(lGroupsRs1("G_GroupID")) & "'>" & trim(lGroupsRs1("G_GroupName")) & "</OPTION>"
			End if
			lGroupsRs1.MoveNext 
		wend
	end if
	
	Set lTSObj = Nothing
	Set lGroupsRs = Nothing
	Set lGroupsRs1 = Nothing
	Set lBugsGroupsRs = Nothing
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
  		      "<tr><td>Multiple Select Projects to Remove</td></tr>" + 
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

<script language="JScript">
// Global vars
var bExpandedBD0;
var bHeaderCreatedBD0;
var bExpandedBD1;
var bHeaderCreatedBD1;
var bExpandedBD2;
var bHeaderCreatedBD2;
var bExpandedBD3;
var bHeaderCreatedBD3;

// Init vars
bExpandedBD0 = false;
bHeaderCreatedBD0 = false;
bExpandedBD1 = false;
bHeaderCreatedBD1 = false;
bExpandedBD2 = false;
bHeaderCreatedBD2 = false;
bExpandedBD3 = false;
bHeaderCreatedBD3 = false;

// Function to expand and collapse listings
function ExpandCollapseBD0() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyBD0 else collapse
	if (bExpandedBD0 == true) {
		iLen = oTBodyBD0.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyBD0.deleteRow();
		}
		bExpandedBD0 = false;
	}
	else {
		CreateBodyBD0();
	}
}

// Function to expand and collapse listings
function ExpandCollapseBD1() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyBD0 else collapse
	if (bExpandedBD1 == true) {
		iLen = oTBodyBD1.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyBD1.deleteRow();
		}
		bExpandedBD1 = false;
	}
	else {
		CreateBodyBD1();
	}
}

// Function to expand and collapse listings
function ExpandCollapseBD2() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyBD0 else collapse
	if (bExpandedBD2 == true) {
		iLen = oTBodyBD2.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyBD2.deleteRow();
		}
		bExpandedBD2 = false;
	}
	else {
		CreateBodyBD2();
	}
}

// Function to expand and collapse listings
function ExpandCollapseBD3() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyBD0 else collapse
	if (bExpandedBD3 == true) {
		iLen = oTBodyBD3.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyBD3.deleteRow();
		}
		bExpandedBD3 = false;
	}
	else {
		CreateBodyBD3();
	}
}

// Function to create the tbody innerHTML content
function CreateBodyBD0() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody0Count;
	
	// Init vars
	bExpandedBD0 = true;
	iBody0Count = 2;

	// Hrefs and Description
	var aLinks = new Array;
	var aDesc = new Array;
 
	aLinks[0] = "View Bugs Database";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmDatabaseView' method='POST' action='psdb-bugs-database-view.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD><A href='psdb-bugs-database-view-all.asp'>View All</A></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody0Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedBD0 == false) {
				oRow = oTBodyBD0.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseBD0()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedBD0 = true;
			}
		}
		else {
			oRow = oTBodyBD0.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}

	// Set the background color of the first body.
//	oTBodyBD0.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyBD1() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody1Count;
	var in_html;
	
	// Init vars
	bExpandedBD1 = true;
	iBody1Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Add Database";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmDatabaseAdd' method='Post' action='psdb-bugs-database-add.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Add style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody1Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedBD1 == false) {
				oRow = oTBodyBD1.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseBD1()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedBD1 = true;
			}
		}
		else {
			oRow = oTBodyBD1.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}

	// Set the background color of the first body.
//	oTBodyBD1.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyBD2() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody2Count;
	
	// Init vars
	bExpandedBD2 = true;
	iBody2Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Update Bugs Database Profile";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUserUpdate' method='Post' action='psdb-bugs-database-view.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody2Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedBD2 == false) {
				oRow = oTBodyBD2.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseBD2()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedBD2 = true;
			}
		}
		else {
			oRow = oTBodyBD2.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyBD2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyBD3() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody3Count;
	
	// Init vars
	bExpandedBD3 = true;
	iBody3Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Delete Bugs Database";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

 	in_html = "<FORM name='frmDatabaseDelete' method='Post' action='psdb-bugs-database-delete.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Delete style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody3Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedBD3 == false) {
				oRow = oTBodyBD3.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseBD3()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedBD3 = true;
			}
		}
		else {
			oRow = oTBodyBD3.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyBD2.bgColor = "lemonchiffon";
}
</script>

<script language="JScript">
// Global vars
var bExpandedU0;
var bHeaderCreatedU0;
var bExpandedU1;
var bHeaderCreatedU1;
var bExpandedU2;
var bHeaderCreatedU2;
var bExpandedU3;
var bHeaderCreatedU3;

// Init vars
bExpandedU0 = false;
bHeaderCreatedU0 = false;
bExpandedU1 = false;
bHeaderCreatedU1 = false;
bExpandedU2 = false;
bHeaderCreatedU2 = false;
bExpandedU3 = false;
bHeaderCreatedU3 = false;

// Function to expand and collapse listings
function ExpandCollapseU0() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyU0 else collapse
	if (bExpandedU0 == true) {
		iLen = oTBodyU0.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyU0.deleteRow();
		}
		bExpandedU0 = false;
	}
	else {
		CreateBodyU0();
	}
}

// Function to expand and collapse listings
function ExpandCollapseU1() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyU0 else collapse
	if (bExpandedU1 == true) {
		iLen = oTBodyU1.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyU1.deleteRow();
		}
		bExpandedU1 = false;
	}
	else {
		CreateBodyU1();
	}
}

// Function to expand and collapse listings
function ExpandCollapseU2() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyU0 else collapse
	if (bExpandedU2 == true) {
		iLen = oTBodyU2.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyU2.deleteRow();
		}
		bExpandedU2 = false;
	}
	else {
		CreateBodyU2();
	}
}

// Function to expand and collapse listings
function ExpandCollapseU3() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyU0 else collapse
	if (bExpandedU3 == true) {
		iLen = oTBodyU3.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyU3.deleteRow();
		}
		bExpandedU3 = false;
	}
	else {
		CreateBodyU3();
	}
}

// Function to create the tbody innerHTML content
function CreateBodyU0() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody0Count;
	
	// Init vars
	bExpandedU0 = true;
	iBody0Count = 2;

	// Hrefs and Description
	var aLinks = new Array;
	var aDesc = new Array;
 
	aLinks[0] = "View Users";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUserView' method='POST' action='ts-users-view.asp'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD><A href='ts-users-view-all.asp'>View All</A></TD></TR></TABLE></FORM><HR>";
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody0Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedU0 == false) {
				oRow = oTBodyU0.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseU0()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedU0 = true;
			}
		}
		else {
			oRow = oTBodyU0.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}

	// Set the background color of the first body.
//	oTBodyU0.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyU1() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody1Count;
	var in_html;
	
	// Init vars
	bExpandedU1 = true;
	iBody1Count = 1;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Add User";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "";


	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody1Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedU1 == false) {
				oRow = oTBodyU1.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href='ts-register-start.asp?FromAddUser=Y'><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedU1 = true;
			}
		}
		else {
			oRow = oTBodyU1.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}

	// Set the background color of the first body.
//	oTBodyU1.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyU2() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody2Count;
	
	// Init vars
	bExpandedU2 = true;
	iBody2Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Update User Profile";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUserUpdate' method='Post' action='ts-users-update.asp'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody2Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedU2 == false) {
				oRow = oTBodyU2.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseU2()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedU2 = true;
			}
		}
		else {
			oRow = oTBodyU2.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyU2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyU3() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody3Count;
	
	// Init vars
	bExpandedU3 = true;
	iBody3Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Delete User";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUserDelete' method='Post' action='ts-users-delete-confirm.asp'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Delete style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody3Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedU3 == false) {
				oRow = oTBodyU3.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseU3()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedU3 = true;
			}
		}
		else {
			oRow = oTBodyU3.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyU2.bgColor = "lemonchiffon";
}
</script>

<script language="JScript">
var bExpandedG0;
var bHeaderCreatedG0;
var bExpandedG1;
var bHeaderCreatedG1;
var bExpandedG2;
var bHeaderCreatedG2;
var bExpandedG3;
var bHeaderCreatedG3;
var bExpandedG4;
var bHeaderCreatedG4;
var bExpandedG5;
var bHeaderCreatedG5;
var bExpandedG6;
var bHeaderCreatedG6;
var bExpandedG7;
var bHeaderCreatedG7;
var bExpandedG8;
var bHeaderCreatedG8;
var bExpandedG9;
var bHeaderCreatedG9;
var bExpandedG10;
var bHeaderCreatedG10;
var bExpandedG11;
var bHeaderCreatedG11;

// Init vars
bExpandedG0 = false;
bHeaderCreatedG0 = false;
bExpandedG1 = false;
bHeaderCreatedG1 = false;
bExpandedG2 = false;
bHeaderCreatedG2 = false;
bExpandedG3 = false;
bHeaderCreatedG3 = false;
bExpandedG4 = false;
bHeaderCreatedG4 = false;
bExpandedG5 = false;
bHeaderCreatedG5 = false;
bExpandedG6 = false;
bHeaderCreatedG6 = false;
bExpandedG7 = false;
bHeaderCreatedG7 = false;
bExpandedG8 = false;
bHeaderCreatedG8 = false;
bExpandedG9 = false;
bHeaderCreatedG9 = false;
bExpandedG10 = false;
bHeaderCreatedG10 = false;
bExpandedG11 = false;
bHeaderCreatedG11 = false;


// Function to expand and collapse listings
function ExpandCollapseG0() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG0 == true) {
		iLen = oTBodyG0.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG0.deleteRow();
		}
		bExpandedG0 = false;
	}
	else {
		CreateBodyG0();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG1() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG1 == true) {
		iLen = oTBodyG1.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG1.deleteRow();
		}
		bExpandedG1 = false;
	}
	else {
		CreateBodyG1();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG2() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG2 == true) {
		iLen = oTBodyG2.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG2.deleteRow();
		}
		bExpandedG2 = false;
	}
	else {
		CreateBodyG2();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG3() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG3 == true) {
		iLen = oTBodyG3.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG3.deleteRow();
		}
		bExpandedG3 = false;
	}
	else {
		CreateBodyG3();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG4() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG4 == true) {
		iLen = oTBodyG4.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG4.deleteRow();
		}
		bExpandedG4 = false;
	}
	else {
		CreateBodyG4();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG5() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG5 == true) {
		iLen = oTBodyG5.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG5.deleteRow();
		}
		bExpandedG5 = false;
	}
	else {
		CreateBodyG5();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG6() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG6 == true) {
		iLen = oTBodyG6.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG6.deleteRow();
		}
		bExpandedG6 = false;
	}
	else {
		CreateBodyG6();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG7() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG7 == true) {
		iLen = oTBodyG7.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG7.deleteRow();
		}
		bExpandedG7 = false;
	}
	else {
		CreateBodyG7();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG8() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG8 == true) {
		iLen = oTBodyG8.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG8.deleteRow();
		}
		bExpandedG8 = false;
	}
	else {
		CreateBodyG8();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG9() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG9 == true) {
		iLen = oTBodyG9.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG9.deleteRow();
		}
		bExpandedG9 = false;
	}
	else {
		CreateBodyG9();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG10() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG10 == true) {
		iLen = oTBodyG10.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG10.deleteRow();
		}
		bExpandedG10 = false;
	}
	else {
		CreateBodyG10();
	}
}

// Function to expand and collapse listings
function ExpandCollapseG11() {
	var iIdx,iLen;
	
	// If expanding call CreateBodyG0 else collapse
	if (bExpandedG11 == true) {
		iLen = oTBodyG11.rows.length;
		for (iIdx=1; iIdx<iLen ; iIdx++) {
			oTBodyG11.deleteRow();
		}
		bExpandedG11 = false;
	}
	else {
		CreateBodyG11();
	}
}

// Function to create the tbody innerHTML content
function CreateBodyG0() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody0Count;
	
	// Init vars
	bExpandedG0 = true;
	iBody0Count = 2;

	// Hrefs and Description
	var aLinks = new Array;
	var aDesc = new Array;
 
	aLinks[0] = "View Projects";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupView' method='POST' action='ts-groups-view.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD><A href='ts-groups-view-all.asp'>View All</A></TD></TR></TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody0Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG0 == false) {
				oRow = oTBodyG0.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG0()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG0 = true;
			}
		}
		else {
			oRow = oTBodyG0.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}

	// Set the background color of the first body.
//	oTBodyG0.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG1() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody1Count;
	var in_html;
	
	// Init vars
	bExpandedG1 = true;
	iBody1Count = 1;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;

	aLinks[0] = "Add Project";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "";


	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody1Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG1 == false) {
				oRow = oTBodyG1.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href='ts-groups-add.asp'><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG1 = true;
			}
		}
		else {
			oRow = oTBodyG1.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;  
		}
	}

	// Set the background color of the first body.
//	oTBodyG1.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG2() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody2Count;
	
	// Init vars
	bExpandedG2 = true;
	iBody2Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Update Project Profile";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupUpdate' method='Post' action='ts-groups-update.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody2Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG2 == false) {
				oRow = oTBodyG2.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG2()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG2 = true;
			}
		}
		else {
			oRow = oTBodyG2.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG3() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody3Count;
	
	// Init vars
	bExpandedG3 = true;
	iBody3Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Delete Project";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupDelete' method='Post' action='ts-groups-delete-confirm.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Delete style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody3Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG3 == false) {
				oRow = oTBodyG3.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG3()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG3 = true;
			}
		}
		else {
			oRow = oTBodyG3.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG4() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody4Count;
	
	// Init vars
	bExpandedG4 = true;
	iBody4Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Add users to Project";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmSelectGroup' method='Post' action='ts-groups-add-users.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Add Users' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody4Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG4 == false) {
				oRow = oTBodyG4.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG4()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG4 = true;
			}
		}
		else {
			oRow = oTBodyG4.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG5() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody5Count;
	
	// Init vars
	bExpandedG5 = true;
	iBody5Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Remove users from Project";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupUsersDelete' method='Post' action='ts-groups-delete-users.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Remove Users' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody5Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG5 == false) {
				oRow = oTBodyG5.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG5()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG5 = true;
			}
		}
		else {
			oRow = oTBodyG5.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG6() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody6Count;
	
	// Init vars
	bExpandedG6 = true;
	iBody6Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Add Groups to Software Bugs Domain";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmAddGroupsToBugsDomain' method='Post' action='ts-groups-insert-bugs-groups.asp' onsubmit='return onClickBugsGroupsUpdate();'>" + 
			  "<TABLE align='center' width=300><input type='hidden' name='hOrgBugsGroupsCount' value='<%=lOrgBugsGroupsCount%>'>" +
							    "<input type='hidden' name='hAddedGroups' value=''>" + 
  		      "<tr colspan=3><td height='16' align=middle class='tdbglight' width='43%'><div align='center' class='blacktext'><B>All Groups</B></div></td><td>&nbsp;</td><td  align='middle' height='16' valign='top' width='43%' class='tdbglight'><B>Bugs Domain Groups</B></td></tr>" + 
  		      "<tr colspan=3><td align='middle' height='16' class='tdbglight'><SELECT size=5 name='sAllGroups' style='HEIGHT: 86px; WIDTH: 150px'><%=lAllGroupsSelectStr%></select></td>" + 
  						    "<td align='middle'  height='16'class='tdbglight'><INPUT type='button' value='>' onclick='MoveGroup();'></td>" + 
						    "<TD align='middle' height='16' class='tdbglight'><SELECT size=5 name='sBugsGroups' style='HEIGHT: 86px; WIDTH: 150px'><%=lBugsGroupsSelectStr%></SELECT></TD>" + 
	  	      "</tr>" + 
	  	      "<tr><td colspan=3 valign='center' align=middle><input type='submit' name='sAddGroups' value='Add Groups' style='BACKGROUND-COLOR: aqua'></td></tr>" + 
	  	      "</TABLE></FORM><HR>";

	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody6Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG6 == false) {
				oRow = oTBodyG6.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG6()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG6 = true;
			}
		}
		else {
			oRow = oTBodyG6.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

function CreateBodyG7() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody7Count;
	
	// Init vars
	bExpandedG7 = true;
	iBody7Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Remove Groups from Software Bugs Domain";
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
			if (bHeaderCreatedG7 == false) {
				oRow = oTBodyG7.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG7()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG7 = true;
			}
		}
		else {
			oRow = oTBodyG7.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG8() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody4Count;
	
	// Init vars
	bExpandedG8 = true;
	iBody4Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "View Project Modules";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmSelectModules' method='Post' action='psdb-groups-modules-view.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='View' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody4Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG8 == false) {
				oRow = oTBodyG8.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG8()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG8 = true;
			}
		}
		else {
			oRow = oTBodyG8.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG9() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody5Count;
	
	// Init vars
	bExpandedG9 = true;
	iBody5Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Add Modules to Project";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupModulesAdd' method='Post' action='psdb-groups-modules-add.asp' onsubmit='return ValidatefrmModuleAdd();'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD width=150>Enter Module</TD><TD><Input type=text size=40 name=ebModule></TD></TR><TR><TD width=150>Enter Module Description</TD><TD><Textarea name=ebModuleDesc cols=30 rows=5></textarea></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Add' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody5Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG9 == false) {
				oRow = oTBodyG9.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG9()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG9 = true;
			}
		}
		else {
			oRow = oTBodyG9.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

// Function to create the tbody innerHTML content
function CreateBodyG10() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody6Count;
	
	// Init vars
	bExpandedG10 = true;
	iBody6Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Update Project Module";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUpdateModules' method='Post' action='psdb-groups-modules-view.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Update' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody6Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG10 == false) {
				oRow = oTBodyG10.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG10()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG10 = true;
			}
		}
		else {
			oRow = oTBodyG10.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

function CreateBodyG11() {
	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var iIdx, iBody7Count;
	
	// Init vars
	bExpandedG11 = true;
	iBody7Count = 2;

	// hrefs and desc
	var aLinks = new Array;
	var aDesc = new Array;
	
	aLinks[0] = "Delete Modules from Project";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmDeleteModules' method='Post' action='psdb-groups-modules-delete.asp'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Delete' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
	// Insert rows and cells into the first body.
	for (iIdx=0; iIdx<iBody7Count; iIdx++)
	{
		if (iIdx == 0) {
			if (bHeaderCreatedG11 == false) {
				oRow = oTBodyG11.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href=javascript:ExpandCollapseG11()><B>" + aLinks[iIdx] + "</B></A>";	
				bHeaderCreatedG11 = true;
			}
		}
		else {
			oRow = oTBodyG11.insertRow();
			oCell = oRow.insertCell();
			oCell.innerHTML = in_html;
		}
	}

	// Set the background color of the first body.
//	oTBodyG2.bgColor = "lemonchiffon";
}

function MoveGroup() {
	var lUserName;
	var lUserValue;
	var lUserText;
	var oOption = document.createElement("OPTION");

	// Move user
	lUserValue = document.frmAddGroupsToBugsDomain.sAllGroups.value;
	if (lUserValue == "") return;
	
	lUserText = document.frmAddGroupsToBugsDomain.sAllGroups.options[document.frmAddGroupsToBugsDomain.sAllGroups.selectedIndex].text;
	lUserIndex = document.frmAddGroupsToBugsDomain.sAllGroups.selectedIndex;

	// now move the user
	oOption.text=lUserText;
	oOption.value=lUserValue;
	
	document.frmAddGroupsToBugsDomain.sBugsGroups.add(oOption);
	document.frmAddGroupsToBugsDomain.sAllGroups.remove (lUserIndex);
}

function onClickBugsGroupsUpdate() {
	var lAddedGroupsIDStr;
	var lNoOfOpts;
	var lIdx;
	lNoOfOpts = document.frmAddGroupsToBugsDomain.sBugsGroups.options.length;

	lAddedGroupsIDStr = "";
	for (lIdx = <%=lOrgBugsGroupsCount%>; lIdx < lNoOfOpts; lIdx++) {
		if (lIdx == lNoOfOpts-1) 
			lAddedGroupsIDStr = lAddedGroupsIDStr + document.frmAddGroupsToBugsDomain.sBugsGroups.options[lIdx].value;		
		else
			lAddedGroupsIDStr = lAddedGroupsIDStr + document.frmAddGroupsToBugsDomain.sBugsGroups.options[lIdx].value + ",";
	}

	document.frmAddGroupsToBugsDomain.hAddedGroups.value = lAddedGroupsIDStr;
	return true;
}

function onClickBugsGroupsRemove() {
	var lRemovedGroupsStr;
	var lNoOfOpts;
	var lIdx;
	lNoOfOpts = document.frmRemoveGroupsFromBugsDomain.sBugsGroups.options.length;

	lRemovedGroupsStr = "";
	for (lIdx = 0; lIdx < lNoOfOpts; lIdx++) {
		if (document.frmRemoveGroupsFromBugsDomain.sBugsGroups.options[lIdx].selected == true) {
			lRemovedGroupsStr = lRemovedGroupsStr + document.frmRemoveGroupsFromBugsDomain.sBugsGroups.options[lIdx].value + ",";		
		}
	}

	document.frmRemoveGroupsFromBugsDomain.hRemovedGroups.value = lRemovedGroupsStr;
	return true;
}
</script>
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>
<TABLE width=350 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Project Management Start Page</font></TD>
</TR>
</TABLE>
<% if lEmpAdmin = true Then %>
<TABLE width=350 align="center" ID="oTableG" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG0"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG1" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG1"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG2" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG2"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG3" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG3"></TBody>
</TABLE>
<% end if %>

<TABLE width=350 align="center" ID="oTableG4" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG4"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG5" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG5"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG6" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG6"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG7" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG7"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG8" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG8"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG9" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG9"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG10" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG10"></TBody>
</TABLE>

<TABLE width=350 align="center" ID="oTableG11" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBody ID="oTBodyG11"></TBody>
</TABLE>


<BR>
<TABLE width=350 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Bugs Database Management Start Page</font></TD>
</TR>
</TABLE>

<TABLE width=350 align="center" ID="oTableBD" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyBD0"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTableBD1" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyBD1"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTableBD2" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyBD2"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTableBD3" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyBD3"></TBODY>
</TABLE>
<BR>

<% if lEmpAdmin = true Then %>
<TABLE width=350 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">User Management Start Page</font></TD>
</TR>
</TABLE>

<TABLE width=350 align="center" ID="oTableU" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyU0"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTableU1" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyU1"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTableU2" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyU2"></TBODY>
</TABLE>

<TABLE width=350 align="center" ID="oTableU3" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBodyU3"></TBODY>
</TABLE>
<% end if %>
<br>

<% if lEmpAdmin = true Then %>
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
<% end if %>
<br><br>


<SCRIPT language="JScript">
if ("<%=lEmpAdmin%>" == "True") { 
CreateBodyG0();
ExpandCollapseG0();
CreateBodyG1();
ExpandCollapseG1();
CreateBodyG2();
ExpandCollapseG2();
CreateBodyG3();
ExpandCollapseG3();
}
CreateBodyG4();
ExpandCollapseG4();
CreateBodyG5();
ExpandCollapseG5();
//CreateBodyG6();
//ExpandCollapseG6();
//CreateBodyG7();
//ExpandCollapseG7();
CreateBodyG8();
ExpandCollapseG8();
CreateBodyG9();
ExpandCollapseG9();
CreateBodyG10();
ExpandCollapseG10();
CreateBodyG11();
ExpandCollapseG11();
</SCRIPT>

<SCRIPT language="JScript">
CreateBodyBD0();
ExpandCollapseBD0();
CreateBodyBD1();
ExpandCollapseBD1();
CreateBodyBD2();
ExpandCollapseBD2();
CreateBodyBD3();
ExpandCollapseBD3();
</SCRIPT>

<% if lEmpAdmin = true Then %>
<SCRIPT language="JScript">
CreateBodyU0();
ExpandCollapseU0();
CreateBodyU1();
ExpandCollapseU1();
CreateBodyU2();
ExpandCollapseU2();
CreateBodyU3();
ExpandCollapseU3();
</SCRIPT>
<% end if %>

<% if lEmpAdmin = true Then %>
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
<% end if %>
</BODY>
</HTML>
