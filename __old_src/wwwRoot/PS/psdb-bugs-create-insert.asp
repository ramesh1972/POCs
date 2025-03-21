<%@ Language=VBScript %>
<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-insert-problem.asp								  *
	'* Purpose		:	Inserts a problem into the database					  *
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
	
	lProjectID = Request.Cookies ("BugsProjectID")
	lDatabaseID = Request.Cookies("BugsDatabaseID")
	
	if lProjectID = "" Or lDatabaseID = ""  Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<% 
	Dim ltitle
	Dim ldesc
	Dim lSteps
	Dim lAffProg
	Dim lProgVersion
	Dim lTestCaseID
	Dim lSBObj	
	Dim lInserted

	ltitle = Request.Form("ebTitle")
	ldesc = Request.Form("taDescription")
	lSteps = Request.Form("taSteps")
	lAffProg = Request.Form("ebAffectedProgram")
	lProgVersion = Request.Form("ebProgramVersion")		
	lTestCaseID = Request.Form("ebTestCaseID")		

	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	lInserted = lSBObj.InsertUserProblem(eval(lEmpID), eval(lProjectID), eval(lDatabaseID), ltitle, ldesc,lSteps, lAffProg, lProgVersion, lTestCaseID)
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK REL=StyleSheet HREF="theme.css" >
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCreate.style.background = "lightblue";
</script>
<BR><BR><BR>
<%
	if lInserted Then
%>
		<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
		<TR>
			<TD align="left"><font class="whiteboldtext">Bug was Successfully Inserted into the System</TD>
		</TR>
		<TR>
			<TD class="tdbglight" align="center"><A href="psdb-bugs-create.asp">Report</A> another Bug</TD>
		</TR>
		</TABLE>
<%
	else
%>
<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="left"><font class="whiteboldtext">Bug was Inserted into the System</TD>
</TR>
<TR>
	<TD class="tdbglight" align="center"><A href="psdb-bugs-create.asp">Click here</A> to Report another Bug</TD>
</TR>
</TABLE>
<%
	end if
%>
</BODY>
</HTML>
