<%@ Language=VBScript %>
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
	Dim lGroupID
	Dim lDayOfWeek	
	Dim lMondayDate
	Dim lSundayDate
	
	lStartDate = Request.Form("ebReportDate")
	lGroupID = Request.Form("sGroups")

	' Find out the day of the week and compute monday and sunday dates
	lDayOfWeek=WeekDay(CDate(lStartDate))
	if (lDayOfWeek = vbSunday) then
		lDayOfWeek = 8	
	end if
	
	lMondayDate = CDate(lStartDate)-(lDayOfWeek-vbMonday)
	lSundayDate = lMondayDate + 6
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
	lFileName = lTSObj.GetReportsFileName(lGroupID, lStartDate)
	lFileFullName = "C:\inetpub\wwwroot\timesheet\reports\groups\" & lFileName
	lCreated = lTSObj.GenTSForGroup (lFileFullName, lGroupID, lMondayDate)
	
	If lCreated Then
%>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext"><A href="reports/groups/<%=lFileName%>">Report</A></div>
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
