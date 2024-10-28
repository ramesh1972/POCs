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
	Dim ltitle
	Dim ldesc
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
<LINK rel="stylesheet" href="../timesheet/theme.css">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivUpdateSel.style.background = "lightblue";
</script>
<BR>
<%	lid = Request.Form("hIdentifier") 
	ltitle = Request.Form("ebTitle")
	ldesc = Request.Form("taDescription")
	lmodule = Request.Form("sModules")
	lstatus = Request.Form("sBugsStatus")
	lpriority = Request.Form("sBugsPriority")
	lseverity = Request.Form("sBugsSeverity")			
	lrepby = Request.Form("sReportedBy")
	lresp = Request.Form("sResponsibility")
	lfixby = Request.Form("sFixedBy")
	lverby = Request.Form("sVerifiedBy")

	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	Set rst = Server.CreateObject("ADODB.Recordset")	
	Set rst = lSBObj.UpdateAll  (eval(lid), ltitle, ldesc, eval(lmodule), eval(lstatus), eval(lpriority), eval(lseverity), eval(lrepby), eval(lresp), eval(lfixby), eval(lverby)) 
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
