<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK rel="stylesheet" href="../Includes/theme.css">
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
<script language="javascript">
function OnClickStartPage() {
	document.location.href="psdb-bugs-report-select.asp";
}
</script>

<%
	Dim lmodule1
	Dim lstatus1
	Dim lpriority1
	Dim lrepby1
	Dim lresp1
	Dim lfixedby1
	Dim lverby1
	Dim lserverity1
	dim lStartDate
	dim lEndDate
	Dim lIdentifier
	Dim lShortDescription
	Dim lReportedBy
	Dim lReportedDate
	Dim lStatus
	Dim lModule
	Dim lPriority
	Dim lSeverity
	Dim lResponsibility
	Dim lEstimatedTime
	Dim lFixedBy
	Dim lFixedDate
	Dim lVerifiedBy
	Dim lVerifiedDate

	lmodule1 = Request.QueryString("vModule")
	lstatus1 = Request.QueryString("vStatus")
	lpriority1 = Request.QueryString("vPriority")
	lrepby1 = Request.QueryString("vReportedBy")
	lresp1 = Request.QueryString("vResponsibility")
	lfixedby1 = Request.QueryString("vFixedBy")
	lverby1 = Request.QueryString("vVerifiedBy")
	lserverity1 = Request.QueryString("vSeverity")
	lStartDate = Request.QueryString("vStartDate")
	lEndDate = Request.QueryString("vEndDate")

	lIdentifier = Request.QueryString("bIdentifier")
	lShortDescription = Request.QueryString("bShortDescription")
	lReportedBy = Request.QueryString("bReportedBy")
	lReportedDate = Request.QueryString("bReportedDate")
	lStatus = Request.QueryString("bStatus")
	lModule = Request.QueryString("bModule")
	lPriority = Request.QueryString("bPriority")
	lSeverity = Request.QueryString("bSeverity")
	lResponsibility = Request.QueryString("bResponsibility")
	lEstimatedTime = Request.QueryString("bEstimatedTime")
	lFixedBy = Request.QueryString("bFixedBy")
	lFixedDate = Request.QueryString("bFixedDate")
	lVerifiedBy = Request.QueryString("bVerifiedBy")
	lVerifiedDate = Request.QueryString("bVerifiedDate")
%>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivReportSel.style.background = "lightblue";
</script>
<BR>
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Report Generated</span></td>
      </tr>
     </table>
	<table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
<%	' Generate the report
	Dim lSBObj
	Dim lCreated
	Dim lFileName
	Dim lFileFullName
	
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")  

	lFileName = lSBObj.GetReportsFileName (eval(lBugsGroupID), Cstr(lStartDate))
	lFileFullName = "C:\inetpub\wwwroot\ps\reports\" & lFileName
	
	lCreated = lSBObj.GenBugReport(lFileFullName, eval(lBugsGroupID), lmodule1,lstatus1,lpriority1,lrepby1,lresp1,lfixedby1,lverby1,lserverity1,lStartDate,lEndDate,lShortDescription,lReportedBy,lReportedDate,lStatus,lModule,lPriority,lSeverity,lResponsibility,lEstimatedTime,lFixedBy,lFixedDate,lVerifiedBy,lVerifiedDate)	
	
	If lCreated Then
%>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext"><A href="reports/<%=lFileName%>">Report</A></div>
        </td>
      </tr>
      </table>
      	<TABLE width=50% align="center">
		<TR>
			<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'></TD>
		</TR>
		</TABLE>
<% else %>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Error while generating the report. <A href="psdb-bugs-report-select.asp">Click here</A> to try again.</div>
        </td>
      </tr>
      </table>
<% end if 

	Set lTSObj = Nothing
%> 

 
</body>
</html>
