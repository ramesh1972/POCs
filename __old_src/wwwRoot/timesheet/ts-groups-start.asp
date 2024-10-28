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
		Response.Redirect("ts-groups-u-view-all.asp")
	end if
	
	if (lUserType = "G") Then
		Response.Redirect("ts-groups-g-start.asp")
	end if
%>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lGroupsRs
	Dim lGroupsRs1

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupsRs1 = Server.CreateObject ("ADODB.RecordSet")
	
	Set lGroupsRs = lTSObj.GetGroupNameList ()
	Set lGroupsRs1 = lTSObj.GetGroupDetails("")  

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

	in_html = "<FORM name='frmGroupUsersDelete' method='Post' action='ts-groups-delete-users.asp'><TABLE width=300><TR><TD width=150>Select Group</TD><TD><%=lGroupsSelectStr1%></TD></TR><TR><TD colspan=2 align=center><INPUT type=SUBMIT value='Remove Users' style='BACKGROUND-COLOR: aqua'></TD></TR></TABLE></FORM><HR>";
	
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
<TABLE width=350 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><font class="whiteboldtext">Group Management Start Page</font></TD>
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

<TABLE width=350 align="center" ID="oTable7" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TBODY ID="oTBody7"></TBODY>
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
CreateBody7();
ExpandCollapse7();
</SCRIPT>
</BODY>
</HTML>
