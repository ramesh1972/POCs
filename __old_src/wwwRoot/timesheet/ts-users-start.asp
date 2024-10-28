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
	if (lUserType = "U" Or lUserType = "G") Then
		Response.Redirect("ts-users-ug-view-all.asp")
	end if
%>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lUsersRs
	Dim lUsersRs1
	Dim lUsersIDRs	
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
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

	Set lTSObj = Nothing
	Set lUsersRs = Nothing
	Set lUsersIDRs = Nothing	
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
// Global vars
var bExpanded0;
var bHeaderCreated0;
var bExpanded1;
var bHeaderCreated1;
var bExpanded2;
var bHeaderCreated2;
var bExpanded3;
var bHeaderCreated3;

// Init vars
bExpanded0 = false;
bHeaderCreated0 = false;
bExpanded1 = false;
bHeaderCreated1 = false;
bExpanded2 = false;
bHeaderCreated2 = false;
bExpanded3 = false;
bHeaderCreated3 = false;

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
 
	aLinks[0] = "View Users";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUserView' method='POST' action='ts-users-view.asp'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD><A href='ts-users-view-all.asp'>View All</A></TD></TR></TABLE></FORM><HR>";
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
			if (bHeaderCreated1 == false) {
				oRow = oTBody1.insertRow();
				oCell = oRow.insertCell();
				oCell.innerHTML = "<A class=linkstyle_head href='ts-register-start.asp?FromAddUser=Y'><B>" + aLinks[iIdx] + "</B></A>";	
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
	
	aLinks[0] = "Update User Profile";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUserUpdate' method='Post' action='ts-users-update.asp'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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
	
	aLinks[0] = "Delete User";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmUserDelete' method='Post' action='ts-users-delete-confirm.asp'><TABLE width=300><TR><TD width=150>Select Employee</TD><TD><%=lUsersSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Delete style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM>";
	
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
document.all.oDivUsers.style.background = "lightblue";
</script>
<BR>
<TABLE width=300 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">User Management Start Page</font></TD>
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

<TABLE width=300 align="center" ID="oTable3" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody3"></TBODY>
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
</SCRIPT>
</BODY>
</HTML>
