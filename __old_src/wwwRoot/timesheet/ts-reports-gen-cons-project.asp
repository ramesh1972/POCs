<%@ Language=VBScript %>
<% Server.ScriptTimeout = 1200 %>
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
%>
<%
	Dim lStartDate
	Dim lEndDate
	Dim lDayOfWeek	
	Dim lMondayDate
	Dim lSundayDate
	
	lStartDate = Request.Form("ebReportFromDate")
	lEndDate = Request.Form("ebReportToDate")

	' Find out the day of the week and compute start monday date
	lDayOfWeek=WeekDay(CDate(lStartDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if
	
	lStartDate = CDate(lStartDate)-(lDayOfWeek-vbMonday)

	lDayOfWeek=WeekDay(CDate(lEndDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if
	
	lEndDate = CDate(lEndDate)-(lDayOfWeek-vbMonday)
%>
<% 'Get the project id
	Dim lProjectID
	
	lProjectID = Request.Form("sProjects")
%>

<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-reports-start.asp";
}
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivReports.style.background = "lightblue";
</script>
<BR>
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Generating Time Sheet Report...
          </span></td>
      </tr>
     </table>
	<table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
<%	' Generate the report
	Dim lTSObj
	Dim lCreated
	Dim lFileName
	Dim lFileFullName
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")      
	lFileName = lTSObj.GetReportsFileName(eval(lProjectID), lStartDate)
	lFileFullName = "C:\inetpub\wwwroot\timesheet\reports\users\" & lFileName
	
	lCreated = lTSObj.GenConsTSForProject (lFileFullName, eval(lProjectID), lStartDate, lEndDate)
	
	If lCreated Then
%>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext"><A href="reports/users/<%=lFileName%>">Report</A></div>
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
          <div align="left" class="blacktext">Error while generating the report. <A href="ts-reports-start.asp">Click here</A> to try again.</div>
        </td>
      </tr>
      </table>
<% end if 

	Set lTSObj = Nothing
%> 

 
</body>
</html>
