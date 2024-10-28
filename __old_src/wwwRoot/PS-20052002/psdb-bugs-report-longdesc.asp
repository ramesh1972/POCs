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
	Dim lsdesc
	Dim lldesc

	Dim srv
	Dim rec
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../timesheet/theme.css">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivReportSel.style.background = "lightblue";
</script>
<BR>
<%	lid = Request.QueryString ("Identifier") 

	Set srv = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set rec = Server.CreateObject("ADODB.Recordset")

	Set rec = srv.ViewDescriptions(cint(lid))
	
	lsdesc = trim(rec("BR_ShortDescription"))
	lldesc = trim(rec("BR_LongDescription"))
	
%>

<TABLE align="center" border=1 width=75% class="tdbgdark" style='border-collapse:collapse'>
  <TR>
    <TD align=left><font class="whiteboldtext">Bug Details</font></TD>
  </TR>
</TABLE>
<TABLE align="center" border=1 width=75% class="tdbglight" style='border-collapse:collapse'>
  <TR>
    <TD align="right"><B>Identifier</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lid%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Bug Short Description</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% If lsdesc <> "" Then Response.Write(lsdesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Bug Long Description</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50% align=left><%If lldesc <> "" Then Response.Write(lldesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  </TABLE>
<TABLE align="center" width=75%>
  <TR>
    <TD align="center"><input type="button" value="View Bugs" onclick="history.back();" style='BACKGROUND-COLOR: aqua'></TD>
  </TR>
</TABLE>
 
  <BR>
</BODY>
</HTML>
