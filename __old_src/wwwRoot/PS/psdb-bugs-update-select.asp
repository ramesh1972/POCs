<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
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
</head>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<!-- #include file="psdb-title.asp" -->
<script language="javascript">
document.all.oDivUpdateSel.style.background = "lightblue";
</script>

<% Call DisplayTitle() %>
<br>
<FORM ACTION = "psdb-bugs-update-query.asp" method="post" name="frmSelectQuery">
<TABLE border=1 width=80% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="10%" align="left"><B>Step</B> 1</TD>
	<TD width="90%" align="left"><font class="whiteboldtext">Select the Fields to be Displayed</font></TD>
</TR>
</TABLE>
<TABLE border=1 width=80% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<TD width=50%><INPUT disabled type="checkbox" name="cbIdentifier" checked>Identifier</TD>
<TD width=50%><INPUT disabled type="checkbox" name="cbShortDescription" checked>Short Description</TD>
</TR>
<TR>
<TD width=50%><INPUT type="checkbox" name="cbReportedBy" checked>Reported By</TD>
<TD width=50%><INPUT type="checkbox" name="cbReportedDate" checked>Reported Date</TD>
</TR>
<TR>
<TD width=50%><INPUT type="checkbox" name="cbStatus" checked>Status</TD>
<TD width=50%><INPUT type="checkbox" name="cbModule" checked>Module</TD>
</TR>
<TR>
<TD width=50%><INPUT type="checkbox" name="cbPriority" checked>Priority</TD>
<TD width=50%><INPUT type="checkbox" name="cbSeverity" checked>Severity</TD>
</TR>
<TR>
<TD width=50%><INPUT type="checkbox" name="cbResponsibility" checked>Responsibility</TD>
<TD width=50%><INPUT type="checkbox" name="cbEstimatedTime">Estimated Time</TD>
</TR>
<TR>
<TD width=50%><INPUT type="checkbox" name="cbFixedBy">Fixed By</TD>
<TD width=50%><INPUT type="checkbox" name="cbFixedDate">Fixed Date</TD>
</TR>
<TR>
<TD width=50%><INPUT type="checkbox" name="cbVerifiedBy">Verified By</TD>
<TD width=50%><INPUT type="checkbox" name="cbVerifiedDate">Verified Date</TD>
</TR>
<TR>
<TD width=50%><INPUT type="checkbox" name="cbAffectedProgram">Affected Programs</TD>
<TD width=50%><INPUT type="checkbox" name="cbTestCaseID">Test Cases</TD>
</TR>
</TABLE>
<BR>
<TABLE width=80% align="center" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><INPUT type="submit" Value="Next >>" style='BACKGROUND-COLOR: aqua'></TD>
</TR>
</TABLE>
</form>
</body>
</html>
