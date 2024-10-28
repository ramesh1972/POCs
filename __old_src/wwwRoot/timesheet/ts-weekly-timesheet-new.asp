<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<script language=javascript>
// Global variables
var gRowCount;

gRowCount=0;
</script>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<script language="javascript">
function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || window.event.keyCode == 46 || window.event.keyCode == 13)) {
		event.returnValue = 0;
		alert("Please enter a number.");
	}
}

function OnClickStartPage() {
	document.location.href="ts-weekly-timesheet-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0" background="">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivTS.style.background = "lightblue";
</script>
<BR>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lProjectsRs
	Dim lCodesRs

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lProjectsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lProjectsRs = lTSObj.GetProjects()

	' Get Codes
	Set lCodesRs = Server.CreateObject ("ADODB.RecordSet")
	Set lCodesRs = lTSObj.GetCodes ()
%>

<% 'Create the select strings here
	Dim lProjectsSelectStr
	Dim lCodesSelectStr
	Dim lSelectAllStr
		
	' Create the select string for projects	
	if lProjectsRs.RecordCount > 0 Then
		lProjectsRs.MoveFirst 
		while not lProjectsRs.EOF 
			lProjectsSelectStr = lProjectsSelectStr & "<OPTION Value='" & trim(lProjectsRs("P_ProjectName")) & "'>" & trim(lProjectsRs("P_ProjectName")) & "</OPTION>"
			lProjectsRs.MoveNext 
		wend
	end if
		
	lProjectsSelectStr = lProjectsSelectStr & "</SELECT>"
	lSelectAllStr = lProjectsSelectStr
	
	' Create the select string for Codes
	if lCodesRs.RecordCount > 0 THen
		lCodesRs.MoveFirst 
	
		while not lCodesRs.EOF 
			lCodesSelectStr = lCodesSelectStr & "<OPTION Value='" & trim(lCodesRs("AC_Description")) & "'>" & trim(lCodesRs("AC_Description")) & "</OPTION>"
			lCodesRs.MoveNext 
		wend
	end if
	lCodesSelectStr = lCodesSelectStr & "</SELECT>"
	
	lSelectAllStr = lSelectAllStr & lCodesSelectStr
%>
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
function CreateNewRow() {

	//Declare variables and create the header, footer, and caption.
	var oRow, oCell;
	var lProjectHtml;
	var lCodeHtml;
	
	// increment the global variab;e
	gRowCount = gRowCount + 1;
	
	lProjectHtml = "<SELECT name='sProject" + gRowCount + "'>";
	lProjectHtml = lProjectHtml + "<%=lProjectsSelectStr%>";

	lCodeHtml = "<SELECT name='sCode" + gRowCount + "'>";
	lCodeHtml = lCodeHtml + "<%=lCodesSelectStr%>";
	
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
	document.frmNewTimeSheet.hRowCount.value = gRowCount; 	
}
</script>

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
<% 'Check if time sheet exists
	Dim lTSExists

	lTSExists = lTSObj.CheckIfTSExists(lEmpID, lMondayDate)
	if Not lTSExists Then	 
%>
<FORM name="frmNewTimeSheet" method="post" action="ts-weekly-timesheet-add.asp">
<input type="hidden" name="hRowCount" >
<input type="hidden" name="hMonDate" value="<%=lMondayDate%>">
<center><B>Weekly Time Sheet</B></center>
<table border=1 width="60%" align="center" BGCOLOR="white" STYLE="BORDER-BOTTOM: medium none; BORDER-COLLAPSE: collapse">
<TR colspan="4">
	<TD align="left" bgcolor="yellow" width="20%"><B>Name</B></TD>
	<TD align="left" bgcolor="white" width="80%">&nbsp;<%=lEmpName%></TD>
</TR>
</table>
<table border=1 width="60%" align="center" BGCOLOR="white" STYLE="BORDER-COLLAPSE: collapse">
<TR cols="4">
	<TD align="left" bgcolor="yellow" width="20%"><B>From Date</B></TD>
	<TD align="left" bgcolor="white" width="30%">&nbsp;<%=lMondayDate%></TD>
	<TD align="left" bgcolor="yellow" width="20%"><B>To Date</B></TD>
	<TD align="left" bgcolor="white" width="30%">&nbsp;<%=lSundayDate%></TD>
</TR>
</table>
<BR>
<TABLE width="50%" align="center" ID="oTable" BGCOLOR="lightslategray" STYLE="BORDER-COLLAPSE: collapse">
  <TBODY>
<TR>
<TD width=50><font color="white"><B>Project</B></font></TD><TD width=180><font color="white"><B>Activity Code</B></font></TD><TD width=5><font color="blue">Mon</font></TD><TD width=5><font color="blue">Tue</font></TD><TD width=5><font color="blue">Wed</font></TD><TD width=5><font color="blue">Thr</font></TD><TD width=5><font color="blue">Fri</font></TD><TD width=5><font color="orange">Sat</font></TD><TD width=5><font color="orange">Sun</font></TD>
</TR>
<TBODY ID="oTBody0"></TBODY>
</TABLE>

<script language="javascript">
CreateNewRow();
</script>
<TABLE width="50%" align="center">
<TR>
	<TD align="middle">
	<INPUT type="button" Value="New Entry" onclick="CreateNewRow();" style="BACKGROUND-COLOR: aqua">
	<INPUT type="submit" Value="Save Time Sheet" style="BACKGROUND-COLOR: aqua">
	<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style="BACKGROUND-COLOR: aqua"></TD>
</TR>
</TABLE>
<BR>
<TABLE width="50%" align="center">
<TR>
	<TD align="middle"><font class="footernote">To delete an entry set all hours to Zero.</font></TD>
</TR>
</TABLE>
</FORM>
<% else %>
<TABLE align="center" width=400 class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD><font class="whiteboldtext">Timesheet already exists</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="middle"><A href="ts-weekly-timesheet-start.asp">Click here</A> to go to the Timesheet start page</TD>
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
