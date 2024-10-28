<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-create-problem.asp								  *
	'* Purpose		:	A form to enter the bug for end user				  *
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
<TITLE></TITLE>
<LINK REL=StyleSheet HREF="theme.css" >
<SCRIPT Language="Javascript">
function Validate() {
	if (document.frmCreate.ebTitle.value  == "")
	 {
		alert("Please enter the title of the bug.");
		document.frmCreate.ebTitle.focus();
		return false;
	}
	
}
</SCRIPT>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<%
	Dim lBugsGroupID
	Dim lBugsDatabaseID
	
	lBugsGroupID = Request.Cookies ("BugsProjectID")
	if lBugsGroupID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
	
	lBugsDatabaseID = Request.Cookies ("BugsDatabaseID")
	if lBugsDatabaseID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<% ' Get the Employee Name
	Dim lEmpName
	Dim lEmpRs
	Dim lTSObj

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lEmpRs = Server.CreateObject ("ADODB.RecordSet")
	Set lEmpRs = lTSObj.GetUserProfile (lEmpID)
	
	lEmpName = ""
	if lEmpRs.RecordCount > 0 Then
		lEmpName = trim(lEmpRs("U_Name"))
	End If
%>
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<!-- #include file="psdb-title.asp" -->

<script language="javascript">
document.all.oDivCreate.style.background = "lightblue";
</script>

<% Call DisplayTitle() %>
<BR>
<FORM ACTION = "psdb-bugs-create-insert.asp" method="post" name="frmCreate" Onsubmit="return Validate();">
<TABLE align="center" border=1 width=75% class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD><FONT CLASS="whiteboldtext">Report a New Bug</FONT></TD>
  </TR>
 </TABLE>
<TABLE align="center" border=1 width=75% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD align="right" valign="top"><B>Bug Title <font color="red">*</font></B>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300 valign="top"><INPUT size=40 MAXLENGTH=1024 type="text" name="ebTitle"></TD>
  </TR>
  <TR>
    <TD align="right" valign="top"><B>Bug Long Description</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300 valign="top"><TEXTAREA cols=40 rows=8 name="taDescription"></TEXTAREA></TD>
  </TR>
  <TR>
    <TD align="right" valign="top"><B>Steps to Recreate</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300 valign="top"><TEXTAREA cols=40 rows=5 name="taSteps"></TEXTAREA></TD>
  </TR>
  <TR>
    <TD align="right" valign="top"><B>Affected Program</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>(e.g. .exe, URL etc..)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300 valign="top"><INPUT size=40 MAXLENGTH=1024 type="text" name="ebAffectedProgram"></TD>
  </TR>
  <TR>
    <TD align="right" valign="top"><B>Program Version</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300 valign="top"><INPUT size=40 MAXLENGTH=1024 type="text" name="ebProgramVersion"></TD>
  </TR>
  <TR>
    <TD align="right"><B>Test Case ID</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300><INPUT size=40 MAXLENGTH=1024 type="text" name="ebTestCaseID"></TD>
  </TR>
  </TABLE>
  <BR>
<table width="75%%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sCreateBug" value="Report Bug" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
</FORM>
</BODY>
<BR>
</HTML>
