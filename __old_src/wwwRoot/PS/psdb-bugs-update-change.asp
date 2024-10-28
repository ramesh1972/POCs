<%@ Language=VBScript %>
<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-edit-problem.asp								  *
	'* Purpose		:	On this form you can edit a bug						  *
	'* Prepared by	:	Ramesh Viswanathan								      *	
	'* Date			:	20.10.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	   	  *
	'*	1		   20.10.2001		Ramesh Viswanathan    First Baseline	  *
	'*																		  *
	'**************************************************************************
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<TITLE></TITLE>

<script language="javascript">
var currentTab = -1;

function DisplayImages() {
	var lCellLeft = lTabLeft;
	
	oDivTab.style.position = "relative";
	oDivTabBody.style.position = "relative";
	oDivTabBody.style.left = lTabLeft;
	oDivTabBody.style.top=-2;
	
	var lBodyWidth = 0;
	for (var lIdx1 = 0;lIdx1 < lTabCount; lIdx1++) {
		lBodyWidth += lTabWidth[lIdx1];
	}
	oDivTabBody.style.width=lBodyWidth + 7;
	oDivTabBody.style.height=100;
	oDivTabBody.style.backgroundColor = "#DADAC5";
	document.all.taTabBody.style.width = lBodyWidth + 7;
	document.all.taTabBody.style.height=100;
	document.all.taTabBody.style.border = "none";
		
	for (var lIdx = 0;lIdx < lTabCount; lIdx++) {
		var oImg = document.all("oImgColHeadCell" + lIdx);
		var oSpan = document.all("oSpanColHeadCell" + lIdx);
		
		oImg.src = lTabImage[lIdx];
		oSpan.innerText = lTabText[lIdx];
		oSpan.style.align ="center";
		
		oImg.style.position = "absolute";
		oImg.style.left = lCellLeft;
		oImg.style.top = lTabTop;
		oImg.style.width = lTabWidth[lIdx] + (lTabWidth[lIdx]/6);
		oImg.style.height = lTabHeight;
		oImg.style.zIndex = (lTabCount-lIdx);
		
		oSpan.style.position = "absolute";
		oSpan.style.left = lCellLeft + (lTabWidth[lIdx]/8);
		oSpan.style.top = lTabTop+2;
		oSpan.style.width = lTabWidth[lIdx];
		oSpan.style.height = lTabHeight;
		oSpan.style.zIndex = (lTabCount+1);
		oSpan.className = "smallredtext";

		document.all("hTab" + lIdx).value = lTabContent[lIdx]; 
		lCellLeft += lTabWidth[lIdx];
	}
}

function SelectTab(tabNo) {
	if (tabNo == currentTab)
		return;
		
	var oImg = document.all("oImgColHeadCell" + tabNo);
	var oSpan = document.all("oSpanColHeadCell" + tabNo);	
	var oImgCurrent
	var oSpanCurrent;

	if (currentTab != -1) {
		oImgCurrent = document.all("oImgColHeadCell" + currentTab);	
		oSpanCurrent = document.all("oSpanColHeadCell" + currentTab);
	}
	
	oImg.src = lTabImageSel[tabNo];
	oSpan.className = "smallblacktextbold";
	
	if (currentTab != -1) {	
		oImgCurrent.src = lTabImage[currentTab];
		oImgCurrent.style.zIndex = currentTab+1;

		oSpanCurrent.className = "smallredtext";
	}
		
	oImg.style.zIndex = lTabCount;
	for (var lIdx=0; lIdx < tabNo;lIdx++) {
		var oImg1 = document.all("oImgColHeadCell" + lIdx);
		oImg1.style.zIndex = lTabCount-(1+lIdx);
	}
	
	var currentzIndex = lTabCount-lIdx;
	for (var lIdx1=tabNo+1; lIdx1 < lTabCount;lIdx1++) {
		var oImg1 = document.all("oImgColHeadCell" + lIdx1);
		oImg1.style.zIndex = currentzIndex - 1;
		currentzIndex--;
	}

	if (currentTab != -1) 
		document.all("hTab" + currentTab).value = document.all.taTabBody.value;
		
	document.all.taTabBody.innerText = document.all("hTab" + tabNo).value;
	currentTab = tabNo;
	
	document.all.taTabBody.focus();
}

function SetTabBody() {
	document.all("hTab" + currentTab).value = document.all.taTabBody.value;
	
	return true;
}
</script>
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<!-- #include file="psdb-title.asp" -->
<script language="javascript">
document.all.oDivUpdateSel.style.background = "lightblue";
</script>
<% Call DisplayTitle() %>
<BR>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<%
	Dim lProjectID
	Dim lDatabaseID
	
	lProjectID = Request.Cookies ("BugsProjectID")
	if lProjectID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if

	lDatabaseID = Request.Cookies ("BugsDatabaseID")
	if lDatabaseID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<%
	Dim rst
	Dim lRs
	Dim id
	Dim rec
	Dim lSBObj
	Dim lTSObj
	Dim lldesc
	Dim lSteps
	Dim lWorkAround
	Dim lResolution
	Dim lFilesAffected

	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	Set lTSObj = Server.CreateObject("TimeSheet.clsTimeSheet")	
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	Set rec = Server.CreateObject("ADODB.Recordset") 
	
	id = Request("Identifier")
	Set rst = lTSObj.GetUserDetails("") 
 	Set rec = lSBObj.ViewProblem (eval(lProjectID), eval(lDatabaseID), eval(id))

	lldesc = trim(rec("BR_LongDescription"))
	lSteps = trim(rec("BR_StepsToRecreate"))
	lWorkAround = trim(rec("BR_WorkAround"))
	lResolution = trim(rec("BR_Resolution"))
	lFilesAffected = trim(rec("BR_FilesAffected"))
%>
<script language="javascript">
// Tab Related Code
var lTabCount = 5;
var lTabHeight = 20;
var lTabLeft = 8;
var lTabTop = 0;

var lTabImage = new Array(lTabCount);
lTabImage[0] = "images/image001.gif";
lTabImage[1] = "images/image001.gif";
lTabImage[2] = "images/image001.gif";
lTabImage[3] = "images/image001.gif";
lTabImage[4] = "images/image001.gif";

var lTabImageSel = new Array(lTabCount);
lTabImageSel[0] = "images/image002.gif";
lTabImageSel[1] = "images/image002.gif";
lTabImageSel[2] = "images/image002.gif";
lTabImageSel[3] = "images/image002.gif";
lTabImageSel[4] = "images/image002.gif";

var lTabText = new Array(lTabCount);
lTabText[0] = "Description";
lTabText[1] = "Steps to Recreate";
lTabText[2] = "Work Around";
lTabText[3] = "Resolution";
lTabText[4] = "Files";

var lTabContent = new Array(lTabCount);
lTabContent[0] = "<%=lldesc%>";
lTabContent[1] = "<%=lSteps%>";
lTabContent[2] = "<%=lWorkAround%>";
lTabContent[3] = "<%=lResolution%>";
lTabContent[4] = "<%=lFilesAffected%>";

var lTabWidth = new Array(lTabCount);
lTabWidth[0] = 110;
lTabWidth[1] = 175;
lTabWidth[2] = 155;
lTabWidth[3] = 105;
lTabWidth[4] = 55;
</script>

<FORM name="frmUpdateBug" ACTION = "psdb-bugs-update-edit.asp" method="post" onsubmit="return SetTabBody();">
<input type="hidden" id="hTab0" name="hTab0">
<input type="hidden" id="hTab1" name="hTab1">
<input type="hidden" id="hTab2" name="hTab2">
<input type="hidden" id="hTab3" name="hTab3">
<input type="hidden" id="hTab4" name="hTab4">
<TABLE border=1 width=80% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="10%" align="left"><B>Step</B> 4</TD>
	<TD width="90%" align="left"><font class="whiteboldtext">Edit Bug Details</font></TD>
</TR>
</TABLE>
<TABLE align="center" border=1 width=80% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD align="right"><B>Identifier</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=id%></TD>
  </TR>

  <TR>
    <TD align="right"><B>Bug Title</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=trim(rec("BR_ShortDescription"))%></TD>
  </TR>

  <TR>
<%
	Dim lSelectStr
	
	lSelectStr = "<SELECT name='sModules'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetProjectModules(eval(lProjectID), 0)
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("M_ModuleID")) = trim(rec("M_ModuleID")) Then
				lSelectStr = lSelectStr & "<Option Value='" & lRs("M_ModuleID") & "' selected>" & lRs("M_ModuleName") & "</Option>"		
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("M_ModuleID") & "'>" & lRs("M_ModuleName") & "</Option>"
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Module</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsStatus'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetAllBugsStatus ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("S_StatusID")) = trim(rec("S_StatusID")) Then
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_StatusID") & "' selected>" & lRs("S_Status") & "</Option>"
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_StatusID") & "'>" & lRs("S_Status") & "</Option>"
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Status</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>
<TR>
<%
	lSelectStr = "<SELECT name='sBugsPriority'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetAllBugsPriority  ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("P_PriorityID")) = trim(rec("P_PriorityID")) Then		
				lSelectStr = lSelectStr & "<Option Value='" & lRs("P_PriorityID") & "' selected>" & lRs("P_Priority") & "</Option>"
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("P_PriorityID") & "'>" & lRs("P_Priority") & "</Option>"				
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Priority</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsSeverity'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetAllBugsSeverity   ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("S_SeverityID")) = trim(rec("S_SeverityID")) Then				
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_SeverityID") & "' selected>" & lRs("S_Severity") & "</Option>"
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_SeverityID") & "'>" & lRs("S_Severity") & "</Option>"			
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Severity</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
 </TABLE>
 <BR>
 <TABLE align="center" width=80% style='border-collapse:collapse'>
  <TR>
  <TD align=center colspan=2>
  	<Div id=oDivTab>
<% Call DisplayColHeader(5) %>
	</Div>
</TD>
</TR>
<tr>
  <TD align=center colspan=2>
	&nbsp;
  </td>
 </tr>
 <tr>
  <TD align=left colspan=2 valign=top>
	<div style="border-collapse:collapse;border-width:1px;border-style:solid;border-color:black;border-top:none" id=oDivTabBody align=left><textarea id="taTabBody"></textarea></Div>
  </td>
 </tr>
  </TABLE>
<BR>
<TABLE align="center" border=1 width=80% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD align=right><B>Test Case ID</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><INPUT size=40 MAXLENGTH=1024 type="text" name="ebTestCaseID" Value="<%=trim(rec("BR_TestCaseID"))%>"></TD>
  </TR>

  <TR>
    <TD align=right><B>Affected Program</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><INPUT size=40 MAXLENGTH=1024 type="text" name="ebAffectedProgram" Value="<%=trim(rec("BR_AffectedProgram"))%>"></TD>
  </TR>

  <TR>
    <TD align=right><B>Version Before Fix</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><INPUT size=20 MAXLENGTH=1024 type="text" name="ebVersionBeforeFix" Value="<%=trim(rec("BR_VersionBeforeFix"))%>"></TD>
  </TR>

  <TR>
    <TD align=right><B>Version After Fix</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><INPUT size=20 MAXLENGTH=1024 type="text" name="ebVersionAfterFix" Value="<%=trim(rec("BR_VersionAfterFix"))%>"></TD>
  </TR>

<TR>
    <TD colspan=2 align=right>&nbsp;</TD>
</TR>

  <TR>
    <% 
		lSelectStr = "<SELECT name='sReportedBy'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_ReportedBy")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
  
    <TD align="right"><B>Reported By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  
  <TR>
    <TD align="right"><B>Reported Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% =rec("BR_ReportedDate")%></TD>
  </TR>

  <TR>
    <% 
		lSelectStr = "<SELECT name='sResponsibility'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_Responsibility")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
  
    <TD align="right"><B>Responsibility</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  <TR>
    <% 
		lSelectStr = "<SELECT name='sFixedBy'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_FixedBy")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
    <TD align="right"><B>Fixed By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  
  <TR>
    <TD align="right"><B>Fixed Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% =rec("BR_FixedDate")%></TD>
  </TR>

  <TR>
    <% 
		lSelectStr = "<SELECT name='sVerifiedBy'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_VerifiedBy")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
    <TD align="right"><B>Verified By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  <TR>
    <TD align="right"><B>Verified Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% =rec("BR_VerifiedDate")%></TD>
  </TR>

  <INPUT type="hidden" name="hIdentifier" value = <%=id%>>
  </TABLE>
<BR>
	<TABLE style="position:absolute;left:75;top:840" width=80% align="center" STYLE="BORDER-COLLAPSE: collapse">
	<TR>
		<TD align="center"><INPUT type="submit" Value="Update Bug" style='BACKGROUND-COLOR: aqua'>
		<INPUT type="button" Value="View Bugs" style='BACKGROUND-COLOR: aqua' onclick="history.back();"></TD>		
	</TR>
	</TABLE>
</FORM>
<BR>
</BODY>
<script language="javascript">
DisplayImages();
SelectTab(0);
</script>

<% 
Function DisplayColHeader(piNumCols)
	Dim lIdx
%>
<%
	For lIdx = 0 To piNumCols-1
	%>
		<Img id="oImgColHeadCell<%=lIdx%>">
		<Span onclick="SelectTab(<%=lIdx%>);" id="oSpanColHeadCell<%=lIdx%>"></Span>
	<%
	Next
%>
<%
End Function
%>
</HTML>
