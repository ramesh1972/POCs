<%  ' Get the project and database ids
	Dim lHProjectID
	Dim lHDatabaseID
	
	lHProjectID = Request.Cookies("BugsProjectID")
	if lHProjectID = "" Then
		lHProjectID = 0
	end if
	
	lHDatabaseID = Request.Cookies("BugsDatabaseID")
	if lHDatabaseID = "" Then
		lHDatabaseID = 0
	end if
%>
<%  ' Check if the user is logged in, is an admin, lead, developer or tester
	Dim lHEmpID
	Dim lLoggedOn
	Dim lHEmpAdmin
	Dim lHEmpProjectLead
	Dim lHEmpDeveloper
	Dim lHEmpTester
	Dim lTSHObj
	
	lLoggedOn = false
	lHEmpID = Request.Cookies("EmployeeID")
	if lHEmpID <> "" Then
		lLoggedOn = true
	end if
	
	Set lTSHObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	if lLoggedOn Then
		lHEmpAdmin = lTSHObj.CheckIfAdministrator(eval(lHEmpID))
		lHEmpProjectLead = lTSHObj.CheckIfGroupLead(eval(lHEmpID), eval(lHProjectID))
		lHEmpDeveloper = lTSHObj.CheckIfDeveloper(eval(lHEmpID), eval(lHProjectID))
		lHEmpTester = lTSHObj.CheckIfTester(eval(lHEmpID), eval(lHProjectID))
	end if
		
	Set lTSHObj = Nothing
%>
<% 
	Dim lDay
	Dim lWeekDay
	Dim lTime1
   
	lTime1 = Now()
	lWeekDay = Weekday(lTime1)
	lDay = Weekdayname(lWeekDay)
%>
  
<script Language="JavaScript">
var timerID = null;
var timerRunning = false;

function gettheDate() {
	Todays = new Date();
	TheDate = (Todays.getMonth()+ 1) +"/"+ Todays.getDate() + "/" + Todays.getYear(); 

	return TheDate;
}

function stopclock (){
	if(timerRunning)
		clearTimeout(timerID);
	timerRunning = false;
}

function startclock () {
	stopclock();
	gettheDate()
	showtime();
}

function showtime () {
	var now = new Date();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var seconds = now.getSeconds()
	var timeValue = "" + ((hours >12) ? hours -12 :hours)

	var ldate = gettheDate();
	
	timeValue += ((minutes < 10) ? ":0" : ":") + minutes
	timeValue += ((seconds < 10) ? ":0" : ":") + seconds
	timeValue += (hours >= 12) ? " P.M." : " A.M."
	document.all.divTime.innerHTML = "<font style='color:orange'>" + ldate + ", <%=lDay%>" + "</font><BR>" + "<font class='whiteboldtext'><B>" + timeValue + "</font></B>";

	// you could replace the above with this
	// and have a clock on the status bar:
	// window.status = timeValue;

	timerID = setTimeout("showtime()",1000);
	timerRunning = true;
}
</script>

<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<LINK REL=StyleSheet HREF="theme.css" >
<% ' Compute the Time
	Dim lTime
	lTime = Now()
%>
<TABLE width="100%" cellspacing="0" cellpadding="0">
<tr>
	<td bgcolor="black" width="20%" align="middle"><div id="divTime"></div></td>
	<TD width="80%"><IMG height=78 src="images/psdb-earth.bmp" width="100%"></TD>
</tr>
</TABLE>
<%  if lLoggedOn = true Then 
		if lHEmpAdmin = true Or lHEmpProjectLead = true Then %>
			<TABLE border=1 width="100%" cellspacing="0" align="center" cellpadding="0">
			<TR>
			<TD align=center bgcolor="lightgreen" width=11%><A href="psdb-bugs-group-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivSelGroup"><B>Home</B></div></font></A></TD>
			<TD align="center" bgcolor="lightgreen" width=13%><A href="psdb-bugs-create.asp"><font style="text-decoration: none;color: blue;"><div id="oDivCreate"><B>Report Bugs</B></div></font></A></TD>
			<TD align="center" bgcolor="lightgreen" width=13%><A href="psdb-bugs-report-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivReportSel"><B>View Bugs</B></div></font></A></TD>
			<TD align="center" bgcolor="lightgreen" width=13%><A href="psdb-bugs-chart-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivChartSel"><B>Bug Charts</B></div></font></A></TD>	
			<TD align="center" bgcolor="lightgreen" width=13%><A href="psdb-bugs-update-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivUpdateSel"><B>Update Bugs</B></div></font></A></TD>
			<TD align="center" bgcolor="lightgreen" width=13%><A href="psdb-bugs-delete-query.asp"><font style="text-decoration: none;color: blue;"><div id="oDivDeleteQry"><B>Delete Bugs</B></div></font></A></TD>			
			<TD align="center" bgcolor="lightgreen" width=13%><A href="psdb-bugs-cat-start.asp"><font style="text-decoration: none;color: blue;"><div id="oDivCat"><B>Administer</B></div></font></A></TD>		
			<TD align="center" bgcolor="lightgreen" width=11%><A href="ts-logon-logout.asp"><font style="text-decoration: none;color: blue;"><div id="oDivLogout"><B>Logout</B></div></font></A></TD>		
			</TR>
			</TABLE>
		<% else %>
				<TABLE border=1 width="100%" cellspacing="0" align="center" cellpadding="0">
				<TR>
				<TD align=center bgcolor="lightgreen" width=13%><A href="psdb-bugs-group-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivSelGroup"><B>Home</B></div></font></A></TD>
				<TD align="center" bgcolor="lightgreen" width=15%><A href="psdb-bugs-create.asp"><font style="text-decoration: none;color: blue;"><div id="oDivCreate"><B>Report Bugs</B></div></font></A></TD>
				<TD align="center" bgcolor="lightgreen" width=15%><A href="psdb-bugs-report-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivReportSel"><B>View Bugs</B></div></font></A></TD>
				<TD align="center" bgcolor="lightgreen" width=15%><A href="psdb-bugs-chart-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivChartSel"><B>Bug Charts</B></div></font></A></TD>	
				<TD align="center" bgcolor="lightgreen" width=15%><A href="psdb-bugs-update-select.asp"><font style="text-decoration: none;color: blue;"><div id="oDivUpdateSel"><B>Update Bugs</B></div></font></A></TD>
				<TD align="center" bgcolor="lightgreen" width=12%><A href="ts-logon-logout.asp"><font style="text-decoration: none;color: blue;"><div id="oDivLogout"><B>Logout</B></div></font></A></TD>		
				</TR>
				</TABLE>
		<% end if %>
<%  else %>
		<TABLE border=1 width="10%" cellspacing="0" align="left" cellpadding="0">
		<TR>
		<TD align=center bgcolor="lightgreen"><A href="ts-logon-start.asp"><font style="text-decoration: none;color: blue;"><div id="oDivLogon"><B>Login</B></div></font></A></TD>	
		</TR>
		</TABLE>
<% end if %>
</TR>
</TABLE>

<script language="javascript">
startclock();
</script>

