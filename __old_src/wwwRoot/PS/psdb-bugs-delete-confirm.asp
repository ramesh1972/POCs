<%@ Language=VBScript %>
<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-delete-confirm.asp								  *
	'* Purpose		:	COnfirm page for deleting the problem				  *
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
	Dim lsdesc
	Dim lldesc

	Dim lSBObj
	Dim rec
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<%	lid = Request("Identifier") 

	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set rec = Server.CreateObject ("ADODB.RecordSet")

	Set rec = lSBObj.ViewDescriptions (eval(lProjectID), eval(lDatabaseID), eval(lid))
	lsdesc = trim(rec("BR_ShortDescription"))
	lldesc = trim(rec("BR_LongDescription"))
%>
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<!-- #include file="psdb-title.asp" -->
<script language="javascript">
document.all.oDivDeleteQry.style.background = "lightblue";
</script>
<% Call DisplayTitle() %>
<BR>
<FORM ACTION = "psdb-bugs-delete-remove.asp" method="post" name="frmDelete">
<TABLE border=1 width=75% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="10%" align="left"><B>Step</B> 4</TD>
	<TD width="90%" align="left"><font class="whiteboldtext">Cofirm Deletion of Bug</font></TD>
</TR>
</TABLE>

<TABLE align="center" border=1 width=75% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD align="right"><B>Identifier</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300><%=lid%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Bug Title</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300><%If lsdesc <> "" Then Response.Write(lsdesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  <TR>
    <TD align="right"><B>Bug Description</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300 align=left><%If lldesc <> "" Then Response.Write(lldesc) Else Response.Write("&nbsp") End If%></TD>
  </TR>
  <INPUT type="hidden" name="hIdentifier" value = <%=lid%>>
  </TABLE>
  <BR>
<TABLE width=25% align="center" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><INPUT type="submit" Value="Confirm Delete" style='BACKGROUND-COLOR: aqua'></TD>
	<TD align="center"><INPUT type="button" Value="View Bugs" style='BACKGROUND-COLOR: aqua' onclick="history.back();"></TD>	
</TR>
</TABLE>
</FORM>
<BR>
</BODY>
</HTML>
