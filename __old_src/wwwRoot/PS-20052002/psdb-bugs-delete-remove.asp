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
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies ("BugsGroupID")
	if lBugsGroupID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<% 
	Dim lid 
	Dim lSBObj
	Dim lDeleted
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivDeleteQry.style.background = "lightblue";
</script>
<BR>
<%	
	lid = Request.Form("hIdentifier") 
	
	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	lDeleted = lSBObj.DeleteProblem (eval(lid))
	
	if lDeleted Then
%>
<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="left"><font class="whiteboldtext">Bug Number <%=lid%> was Successfully Deleted</TD>
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
	<TD align="left"><font class="whiteboldtext">Bug Number <%=lid%> was not Deleted</TD>
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
