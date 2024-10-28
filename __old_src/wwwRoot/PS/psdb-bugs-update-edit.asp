<%@ Language=VBScript %>
<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-update-problem.asp								  *
	'* Purpose		:	Updates the bug										  *
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
	Dim lid 
	Dim ltitle
	Dim ldesc
	Dim lSteps
	Dim lWorkAround
	Dim lResolution
	Dim lFilesAffected
	Dim lTestCaseID
	Dim lAffectedProgram
	Dim lVersionBeforeFix
	Dim lVersionAfterFix
	Dim lmodule
	Dim lstatus
	Dim lpriority
	Dim lseverity	
	Dim lrepby
	Dim lresp
	Dim lfixby
	Dim lverby

	Dim lSBObj
	Dim rst
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivUpdateSel.style.background = "lightblue";
</script>
<BR><BR><BR>
<%	
	lid = Request.Form("hIdentifier")
	lmodule = Request.Form("sModules")
	lstatus = Request.Form("sBugsStatus")
	lpriority = Request.Form("sBugsPriority")
	lseverity = Request.Form("sBugsSeverity")			
	lrepby = Request.Form("sReportedBy")
	lresp = Request.Form("sResponsibility")
	lfixby = Request.Form("sFixedBy")
	lverby = Request.Form("sVerifiedBy")
	ldesc = Request.Form("hTab0")
	lSteps = Request.Form("hTab1")
	lWorkAround = Request.Form("hTab2")
	lResolution = Request.Form("hTab3")
	lFilesAffected = Request.Form("hTab4")
	lTestCaseID = Request.Form("ebTestCaseID")
	lAffectedProgram = Request.Form("ebAffectedProgram")
	lVersionBeforeFix = Request.Form("ebVersionBeforeFix")
	lVersionAfterFix = Request.Form("ebVersionAfterFix")

	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	Set rst = Server.CreateObject("ADODB.Recordset")	
	Set rst = lSBObj.UpdateAll(eval(lProjectID), eval(lDatabaseID), eval(lid), "", ldesc, eval(lmodule), eval(lstatus), eval(lpriority), eval(lseverity), eval(lrepby), eval(lresp), eval(lfixby), eval(lverby), lSteps,lWorkAround,lResolution,lFilesAffected,lAffectedProgram,lVersionBeforeFix,lVersionAfterFix, lTestCaseID) 
%>
<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="left"><font class="whiteboldtext">Bug Number <%=lid%> was Successfully Updated</TD>
</TR>
<TR>
	<TD class="tdbglight" align="center"><input type="button" value="View Bugs" style='BACKGROUND-COLOR: aqua' onclick="history.go(-2);"></TD>
</TR>
</TABLE>
</BODY>
</HTML>
