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
<LINK REL=StyleSheet HREF="../timesheet/theme.css" >
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
	Dim lGroupID
	
	lGroupID = Request.Form("sBugsGroups")
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
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivCreate.style.background = "lightblue";
</script>

<BR>
<FORM ACTION = "psdb-bugs-create-insert.asp" method="post" name="frmCreate" Onsubmit="return Validate();">
<TABLE align="center" border=1 width=75% class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD><FONT CLASS="whiteboldtext">Report a New Bug</FONT></TD>
  </TR>
 </TABLE>
<TABLE align="center" border=1 width=75% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD align="right"><B>Name</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300><%=lEmpName%></TD>
  </TR>

  <TR>
    <TD align="right"><B>Bug Title</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Or Short Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300><INPUT MAXLENGTH=1024 type="text" name="ebTitle"></TD>
  </TR>
  <TR>
    <TD align="right"><B>Bug Long Description</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Or Steps to Recreate the Bug&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=300><TEXTAREA cols=40 rows=8 name="taDescription"></TEXTAREA></TD>
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
