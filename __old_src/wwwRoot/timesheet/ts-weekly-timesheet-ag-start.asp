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
<% ' Get Default date
	Dim lDefaultDate
	Dim lDayOfWeek	
	Dim lMondayDate
	Dim lTSDate
	Dim lTSNextDate
	Dim lTSPrevDate
	Dim lTSDateGiven
			
	lTSDateGiven = "N"
	lDefaultDate = FormatDateTime(Now(), vbShortDate)
	
	' Find out the day of the week and compute monday and sunday dates
	lDayOfWeek=WeekDay(CDate(lDefaultDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if

	lMondayDate = CDate(lDefaultDate)-(lDayOfWeek-vbMonday)
'	lMondayDate = lMondayDate - 7

	lTSDate = Request.QueryString ("TSDate")
	if lTSDate = "" Then
		lTSDate = lMondayDate
	else
		lTSDateGiven = "Y"
	end if

	lTSNextDate = CDate(lTSDate) + 7
	lTSPrevDate = CDate(lTSDate) - 7
%>

<% ' Check the type of user and redirect
	Dim lUserType
	
	lUserType = Request.Cookies("EmployeeType")
%>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lUsersRs
	Dim lUsersSelectStr
	Dim lUserTSAnchorList	
	
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
		
		if lUsersRs.RecordCount > 0 Then
			lUsersRs.MoveFirst 
			while not lUsersRs.EOF 
				if (lTSObj.CheckIfTSExists (eval(trim(lUsersRs("U_Employee_ID"))), lTSDate)) Then
					lUserTSAnchorList = lUserTSAnchorList & "<A href='ts-weekly-timesheet-view.asp?EmpID=" & trim(lUsersRs("U_Employee_ID")) & "&TSDate=" & lTSDate & "'>" & trim(lUsersRs("U_Name")) & "</A><BR>"
				else
					lUserTSAnchorList = lUserTSAnchorList & trim(lUsersRs("U_Name")) & "<BR>"
				end if
				lUsersRs.MoveNext 
			wend
		End if
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

		if lUsersRs.RecordCount > 0 Then
			lUsersRs.MoveFirst 
			while not lUsersRs.EOF 
				if (lTSObj.CheckIfTSExists (eval(trim(lUsersRs("U_Employee_ID"))), lTSDate) And  eval(trim(lUsersRs("U_Employee_ID"))) <> eval(lEmpID)) Then
					lUserTSAnchorList = lUserTSAnchorList & "<A href='ts-weekly-timesheet-view.asp?EmpID=" & trim(lUsersRs("U_Employee_ID")) & "&TSDate=" & lTSDate & "'>" & (lUsersRs("U_Name")) & "</A><BR>"
				elseif eval(trim(lUsersRs("U_Employee_ID"))) <> eval(lEmpID) Then
					lUserTSAnchorList = lUserTSAnchorList & trim(lUsersRs("U_Name")) & "<BR>"
				end if
				lUsersRs.MoveNext 
			wend
		End if
	End if	
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
	
	lTSDate = document.frmWTSView.ebDateView.value;
	if (lTSDate == "") {
		alert("Please enter the date");
		document.frmWTSView.ebDateView.focus();
		return false;
	}
	
	return true;
}
function ValidateFormDataNew() {
	var lTSDate;
	
	lTSDate = document.frmWTSNew.ebDateNew.value;
	if (lTSDate == "") {
		alert("Please enter the date");
		document.frmWTSNew.ebDateNew.focus();
		return false;
	}
	
	return true;
}

function ValidateFormDataEdit() {
	var lTSDate;
	
	lTSDate = document.frmWTSEdit.ebDateEdit.value;
	if (lTSDate == "") {
		alert("Please enter the date");
		document.frmWTSEdit.ebDateEdit.focus();
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
 
	aLinks[0] = "View Time Sheet";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmWTSView' method='POST' action='ts-weekly-timesheet-view.asp' onsubmit='return ValidateFormDataView()'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD width=150>Enter Date (mm/dd/yy)</TD><TD><INPUT type='text' name='ebDateView' value='<%=lDefaultDate%>' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD colspan=2 align='center'><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR><TR><TD>&nbsp;</TD></TR><TR><TD colspan=2 align=left><A href = 'ts-weekly-timesheet-ag-start.asp?TSDate=<%=lTSPrevDate%>'><font style='font-size:12px;font-family:arial'>Prev Week</font></A>&nbsp;&nbsp;&nbsp;<font style='font-size:12px;font-family:arial'><B>Time Sheets for</B> <%=lTSDate%></font>&nbsp;&nbsp;&nbsp;<A href = 'ts-weekly-timesheet-ag-start.asp?TSDate=<%=lTSNextDate%>'><font style='font-size:12px;font-family:arial'>Next Week</font></A></TD></TR><TR><TD colspan=2 align=left><font class='smalltext'><%=lUserTSAnchorList%></font></TD></TR></TABLE></FORM><HR>";

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

	aLinks[0] = "New Time Sheet";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";
	
	in_html = "<FORM name='frmWTSNew' method='post' action='ts-weekly-timesheet-new.asp' onsubmit='return ValidateFormDataNew()'><TABLE width=300><TR><TD width=150>Enter Date (mm/dd/yy)</TD><TD><INPUT type=text name='ebDateNew' value='<%=lDefaultDate%>' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Create style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD colspan=2 align='center'><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR></TABLE></FORM><HR>";

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
	
	aLinks[0] = "Edit Time Sheet";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmWTSEdit' method='Post' action='ts-weekly-timesheet-update.asp' onsubmit='return ValidateFormDataEdit()'><TABLE width=300><TR><TD width=150>Enter Date (mm/dd/yy)</TD><TD><INPUT type='text' name='ebDateEdit' value='<%=lDefaultDate%>' onkeypress='ValidateInteger();'></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Edit style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD colspan=2 align='center'><font class='tablefooter'>Enter a date and the corresponding monday date is automatically calculated.</font></TD></TR></TABLE></FORM>";
	
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
document.all.oDivTS.style.background = "lightblue";
</script>
<BR>
<TABLE width=300 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Time Sheet Start Page</font></TD>
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

<SCRIPT language="JavaScript">
CreateBody0();
if ("<%=lTSDateGiven%>" == "N") 
	ExpandCollapse0();
CreateBody1();
ExpandCollapse1();
CreateBody2();
ExpandCollapse2();
</SCRIPT>
</BODY>
</HTML>
