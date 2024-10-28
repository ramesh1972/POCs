<%@ Language=VBScript %>
<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-problem-longdesc.asp						      *
	'* Purpose		:	Gives a long description of the problem 			  *
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
	
	lProjectID = Request.Cookies("BugsProjectID")
	lDatabaseID = Request.Cookies("BugsDatabaseID")
	
	if lProjectID = "" Or lDatabaseID = ""  Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<HTML>
<HEAD>
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

	oDivTabBody.innerText = lTabContent[tabNo];
	currentTab = tabNo;
}
</script>
<LINK rel="stylesheet" href="theme.css">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<!-- #include file="psdb-title.asp" -->
<script language="javascript">
document.all.oDivReportSel.style.background = "lightblue";
</script>
<% Call DisplayTitle() %>
<BR>
<%	
	Dim lid 
	Dim lsdesc
	Dim lldesc
	Dim lSteps
	Dim lWorkAround
	Dim lResolution
	Dim lFilesAffected
	Dim srv
	Dim rec

	lid = Request.QueryString ("Identifier") 

	Set srv = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set rec = Server.CreateObject("ADODB.Recordset")
	Set rec = srv.ViewDescriptions(eval(lProjectID), eval(lDatabaseID), cint(lid))
	
	lsdesc = trim(rec("BR_ShortDescription"))
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
var lTabLeft = 25;
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

<TABLE align="center" border=1 width=85% class="tdbgdark" style='border-collapse:collapse'>
  <TR>
    <TD align=left><font class="whiteboldtext">Bug Details</font></TD>
  </TR>
</TABLE>
<TABLE align="center" border=1 width=85% class="tdbglight" style='border-collapse:collapse'>
  <TR>
    <TD align="right"><B>Identifier</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lid%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Bug Short Description</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% If lsdesc <> "" Then Response.Write(lsdesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
 </TABLE>
 <BR>
 <BR>
 <TABLE align="center" width=85% style='border-collapse:collapse'>
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
	<div style="border-collapse:collapse;border-width:1px;border-style:solid;border-color:black;border-top:none" id=oDivTabBody align=left></Div>
  </td>
 </tr>
  </TABLE>
<TABLE style="position:absolute;left:65;top:440" align="center" width=85%>
  <TR>
    <TD align="center"><input type="button" value="View Bugs" onclick="history.back();" style='BACKGROUND-COLOR: aqua'></TD>
  </TR>
</TABLE>
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
