<%@ Language=VBScript %>
<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-delete-problem.asp								  *
	'* Purpose		:	This deletes a bug from the database   				  *
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
	Dim lBugList
	Dim lSBObj
	Dim lDeleted
	Dim lBugArray
	
	lBugList = Request.Form("hDeleteBugList")
	
	lBugArray = Split(lBugList, ",")
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivDeleteQry.style.background = "lightblue";
</script>
<BR><BR><BR>
<%	
	Dim lLen
	Dim lIdx
	
	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	lLen = UBound(lBugArray)

	For lIdx = 0 To lLen
		Dim lid
		lid = lBugArray(lIdx)
	
		lDeleted = lSBObj.DeleteProblem(eval(lPRojectID), eval(lDatabaseID), eval(lid))
	next
	
	if lDeleted Then
%>
<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="left"><font class="whiteboldtext">Bugs were Successfully Deleted</TD>
</TR>
<TR>
	<TD class="tdbglight" align="center"><input type="button" value="View Bugs" style='BACKGROUND-COLOR: aqua' onclick="history.go(-2);"></TD>
</TR>
</TABLE>
<%
	else
%>
<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="left"><font class="whiteboldtext">Some of the Bugs were not Deleted</TD>
</TR>
<TR>
	<TD class="tdbglight" align="center"><input type="button" value="View Bugs" style='BACKGROUND-COLOR: aqua' onclick="history.go(-2);"></TD>
</TR>
</TABLE>
<%
	end if
%>
</BODY>
</HTML>
