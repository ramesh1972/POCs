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
%>
<% ' Get Default date
	Dim lDefaultDate
	lDefaultDate = FormatDateTime(Now(), vbShortDate)
%>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lUsersRs
	Dim lUsersSelectStr
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lUsersRs = Server.CreateObject ("ADODB.RecordSet")
	
	If (lUserType = "A") Then
		Set lUsersRs = lTSObj.GetUserDetails ("") 

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
	Else
		Set lUsersRs = lTSObj.GetGroupUsersForLead (eval(lEmpID)) 

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
	End if	
%>
<% 'Get all required data from the database
	Dim lProjectsRs

	' Get projects
	Set lProjectsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lProjectsRs = lTSObj.GetAllProjects () 

	'Create the select strings here
	Dim lProjectsSelectStr
	
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
	Set lProjectsRs = Nothing
%>
<script language="javascript">
function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || window.event.keyCode == 47 || window.event.keyCode == 13)) {
		event.returnValue = 0;
		alert("Please enter the date in mm/dd/yy format.\n where mm, dd, yy are numbers");
	}
}

function ValidateFormDataView() {
	var lTSDate;
	
	lTSDate = document.frmWPRView.ebDateView.value;
	if (lTSDate == "") {
		alert("Please enter the date");
		document.frmWPRView.ebDateView.focus();
		return false;
	}
	
	return true;
}
function ValidateFormDataNew() {
	var lTSDate;

	lTSDate = document.frmWPRNew.ebDateNew.value;
	if (lTSDate == "") {
		alert("Please enter the date");
		document.frmWPRNew.ebDateNew.focus();
		return false;
	}
	
	return true;
}

function ValidateFormDataEdit() {
	var lTSDate;
	
	lTSDate = document.frmWPREdit.ebDateEdit.value;
	if (lTSDate == "") {
		alert("Please enter the date");
		document.frmWPREdit.ebDateEdit.focus();
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

// Init vars
bExpanded0 = false;
bHeaderCreated0 = false;
bExpanded1 = false;
bHeaderCreated1 = false;
bExpanded2 = false;
bHeaderCreated2 = false;

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
 
	aLinks[0] = "View Progress Report";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmWPRView' method='POST' action='ts-weekly-progress-view.asp' onsubmit='return ValidateFormDataView()'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD width=150>Select Project</TD><TD><%=lProjectsSelectStr%></TD></TR><TR><TD width=150>Enter Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebDateView' value='<%=lDefaultDate%>' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD colspan=2 align='center'><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR></TABLE></FORM><HR>";

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

	aLinks[0] = "New Progress Report";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";
	
	in_html = "<FORM name='frmWPRNew' method='post' action='ts-weekly-progress-new.asp' onsubmit='return ValidateFormDataNew()'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lProjectsSelectStr%></TD></TR><TR><TD width=150>Enter Date (mm/dd/yy)</TD><TD><INPUT size=10 type=text name='ebDateNew' value='<%=lDefaultDate%>' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Create style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD align='center' colspan=2><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR></TABLE></FORM><HR>";

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
	
	aLinks[0] = "Edit Progress Report";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmWPREdit' method='Post' action='ts-weekly-progress-update.asp' onsubmit='return ValidateFormDataEdit()'><TABLE width=300><TR><TD width=150>Select Project</TD><TD><%=lProjectsSelectStr%></TD></TR><TR><TD width=150>Enter Date (mm/dd/yy)</TD><TD><INPUT size=10 type='text' name='ebDateEdit' value='<%=lDefaultDate%>' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Edit style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD align='center' colspan=2><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR></TABLE></FORM>";
	
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

	// Set the background color of the first body.
//	oTBody2.bgColor = "lemonchiffon";
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
document.all.oDivPR.style.background = "lightblue";
</script>
<BR>
<TABLE width=300 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Progress Report Start Page</font></TD>
</TR>
</TABLE>
<TABLE width=300 align="center" ID="oTable" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody0"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable1" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody1"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable2" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody2"></TBODY>
</TABLE>

<SCRIPT language="JScript">
CreateBody0();
ExpandCollapse0();
CreateBody1();
ExpandCollapse1();
CreateBody2();
ExpandCollapse2();
</SCRIPT>
</BODY>
</HTML>
