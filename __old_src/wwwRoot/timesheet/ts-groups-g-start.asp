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
<% 'Get all required data from the database
	Dim lTSObj
	Dim lGroupsRs
	Dim lGroupsIDRs	

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupsIDRs = Server.CreateObject ("ADODB.RecordSet")
		
	Set lGroupsRs = lTSObj.GetGroupNameList () 
	Set lGroupsIDRs = lTSObj.GetGroupIDListForLeader(eval(lEmpId))
	
	'Create the select strings here
	Dim lGroupsSelectStr
	Dim lGroupsSelectStr1
	Dim lGroupsIDSelectStr			
	
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
	if lGroupsIDRs.RecordCount > 0 Then
		lGroupsIDRs.MoveFirst 
		while not lGroupsIDRs.EOF 
			lGroupsSelectStr1 = lGroupsSelectStr1 & "<OPTION Value='" & trim(lGroupsIDRs("G_GroupID")) & "'>" & trim(lGroupsIDRs("G_GroupName")) & "</OPTION>"
			lGroupsIDRs.MoveNext 
		wend
	end if
	lGroupsSelectStr1 = lGroupsSelectStr1 & "</SELECT>"

	lGroupsIDSelectStr = "<SELECT name='sGroups'>"
	if lGroupsIDRs.RecordCount > 0 then
		lGroupsIDRs.MoveFirst 
		while not lGroupsIDRs.EOF 
			lGroupsIDSelectStr = lGroupsIDSelectStr & "<OPTION Value='" & trim(lGroupsIDRs("G_GroupID")) & "'>" & trim(lGroupsIDRs("G_GroupID")) & "</OPTION>"
			lGroupsIDRs.MoveNext 
		wend
	end if
	lGroupsIDSelectStr = lGroupsIDSelectStr & "</SELECT>"

	Set lTSObj = Nothing
	Set lGroupsRs = Nothing
	Set lGroupsIDRs	= Nothing
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
 
	aLinks[0] = "View Groups";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupView' method='POST' action='ts-groups-view.asp'><TABLE width=300><TR><TD width=150>Select Group</TD><TD><%=lGroupsSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=View style='BACKGROUND-COLOR: aqua'></TD></TR><TR><TD><A href='ts-groups-view-all.asp'>View All</A></TD></TR></TABLE></FORM><HR>";

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

	aLinks[0] = "Add Group";
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
				oCell.innerHTML = "<A class=linkstyle_head href='ts-groups-add.asp'><B>" + aLinks[iIdx] + "</B></A>";	
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
	
	aLinks[0] = "Update Group Profile";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupUpdate' method='Post' action='ts-groups-update.asp'><TABLE width=300><TR><TD width=150>Select Group</TD><TD><%=lGroupsSelectStr%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Update style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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
	
	aLinks[0] = "Delete Group";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupDelete' method='Post' action='ts-groups-delete-confirm.asp'><TABLE width=300><TR><TD width=150>Select Group</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value=Delete style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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
	
	aLinks[0] = "Add users to group";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmSelectGroup' method='Post' action='ts-groups-add-users.asp'><TABLE width=300><TR><TD width=150>Select Group</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Add Users' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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
	
	aLinks[0] = "Remove users from Group";
	aDesc[0] = "";
	aLinks[1] = "";
	aDesc[1] = "";

	in_html = "<FORM name='frmGroupUsersDelete' method='Post' action='ts-groups-delete-users.asp'><TABLE width=300><TR><TD width=150>Select Group</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Remove Users' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM>";
	
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
document.all.oDivGroups.style.background = "lightblue";
</script>
<BR>
<TABLE width=300 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Group Management Start Page</font></TD>
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

<TABLE width=300 align="center" ID="oTable4" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody4"></TBODY>
</TABLE>

<TABLE width=300 align="center" ID="oTable5" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody5"></TBODY>
</TABLE>

<SCRIPT language="JScript">
CreateBody0();
ExpandCollapse0();
//CreateBody1();
//ExpandCollapse1();
//CreateBody2();
//ExpandCollapse2();
//CreateBody3();
//ExpandCollapse3();
CreateBody4();
ExpandCollapse4();
CreateBody5();
ExpandCollapse5();
</SCRIPT>
</BODY>
</HTML>
