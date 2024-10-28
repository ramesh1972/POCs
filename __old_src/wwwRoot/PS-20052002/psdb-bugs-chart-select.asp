<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title>Login</title>
<LINK REL=StyleSheet HREF="../timesheet/theme.css" >
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%  ' Check if the user belongs to the group
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies("BugsGroupID")
	if lBugsGroupID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
</head>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivChartSel.style.background = "lightblue";
</script>

<br><br>
<FORM ACTION = "psdb-bugs-chart-query.asp" method="post" name="frmChooseQuery">
<TABLE border=1 width=80% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="10%" align="left"><B>Step</B> 1</TD>
	<TD width="90%" align="left"><font class="whiteboldtext">Select the Category to be Displayed in the Chart</font></TD>
</TR>
</TABLE>
<TABLE border=1 width=80% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<TD width=50%><INPUT type="radio" name="rCategory" value="ReportedBy" checked>Reported By</TD>
<TD width=50%><INPUT type="radio" name="rCategory" value="Responsibility">Responsibility</TD>
</TR>
<TR>
<TD width=50%><INPUT type="radio" name="rCategory" value="Module">Module</TD>
<TD width=50%><INPUT type="radio" name="rCategory" value="Status">Status</TD>
</TR>
<TR>
<TD width=50%><INPUT type="radio" name="rCategory" value="Priority">Priority</TD>
<TD width=50%><INPUT type="radio" name="rCategory" value="Severity">Severity</TD>
</TR>
<TR>
<TD width=50%><INPUT type="radio" name="rCategory" value="FixedBy">Fixed By</TD>
<TD width=50%><INPUT type="radio" name="rCategory" value="VerifiedBy">Verified By</TD>
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
