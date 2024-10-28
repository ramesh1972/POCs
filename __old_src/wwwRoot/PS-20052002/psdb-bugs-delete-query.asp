<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-problem-query.asp								  *
	'* Purpose		:	Query page for problems								  *
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
	Dim lSBObj
	Dim lTSObj	
	Dim lRs

	dim StartMonth
	dim StartDate
	dim startYear
	dim LMONTH
	DIM LYEAR
	DIM LYEAR1
	DIM LDATE
	DIM CURRENTDATE
	dim lYearPrev
%>

<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../timesheet/theme.css">
	<script language="Javascript">
	function validateDate()
	{
		lSDate	= document.frmViewQuery.StartDate.value ;
		lSMonth	= document.frmViewQuery.StartMonth.value;
		lSYear	= document.frmViewQuery.StartYear.value;
		lEDate	=	document.frmViewQuery.EndDate.value;
		lEMonth	=	document.frmViewQuery.EndMonth.value;
		lEYear	=	document.frmViewQuery.EndYear.value;  
		lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
		lEDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear);
		if (lSDay > lEDay) 
		{
			document.frmViewQuery.StartMonth.focus(); 
			alert("Start date should be Greater than End date");
			return false;
		}
		if ((validDate(lSMonth,lSDate,lSYear))== false )
		{
			document.frmViewQuery.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;
		}
		if ((validDate(lEMonth,lEDate,lEYear))== false)
		{
			document.frmViewQuery.EndDate.focus(); 
			alert("Please Enter valid End Date");
			return false;
		}
		return true;
	}
		
	function validDate(vMonth,vDay,vYear)
	{
	var vaMonths = new Array();
	vaMonths[1]=31;
	if (vYear%4==0)
		vaMonths[2]=29;
	else
		vaMonths[2]=28;
			
	vaMonths[3]=31;
	vaMonths[4]=30;
	vaMonths[5]=31;
	vaMonths[6]=30;
	vaMonths[7]=31;
	vaMonths[8]=31;
	vaMonths[9]=30;
	vaMonths[10]=31;
	vaMonths[11]=30;
	vaMonths[12]=31;
		
	if (vDay>vaMonths[vMonth])
		{
		return false;
		}
	return true;
	}	

	function CheckEndDate()
	{
    lEDate	=	document.frmViewQuery.EndDate.value
    lEMonth	=	document.frmViewQuery.EndMonth.value
	lEYear	=	document.frmViewQuery.EndYear.value	
	lDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear)
	lCDay	=	new Date();
	lCMonth =   lCDay.getMonth();
	lCMonth =	lCMonth + 1
	lCDate	=	lCDay.getDate();
	lCYear	=	lCDay.getYear();
	
	if (lEMonth > lCMonth)
	{	
		document.frmViewQuery.EndMonth.focus(); 
		alert("Please Enter Correct Month.\nEnd Date should be Less than or Equal to Current Date.");
		return false;
	}
	if (lEDate > lCDate)
	{	
		document.frmViewQuery.EndDate.focus();
		alert("Please Enter Correct Date.\nEnd Date should be Less than or Equal to Current Date.");
		return false;
	}
	if (lEYear > lCYear)
	{	
		document.frmViewQuery.EndYear.focus(); 
		alert("Please Enter Correct Year.\nEnd Date should be Less than or Equal to Current Date.");
		return false;
	}
	return true;
	}
	
	</script>
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivDeleteQry.style.background = "lightblue";
</script>
<%
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR=YEAR(CURRENTDATE)
	LYEAR1=LYEAR+1
	lYearPrev	= LYEAR -1
	
	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	Set lTSObj = Server.CreateObject("TimeSheet.clsTimeSheet")	
		
	Set lRs = Server.CreateObject("ADODB.Recordset")
%>
<BR><BR>
<FORM ACTION = "psdb-bugs-delete-view.asp" method="post" name="frmViewQuery" onsubmit="return validateDate();CheckEndDate();">
<TABLE border=1 width=80% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="10%" align="left"><B>Step</B> 1</TD>
	<TD width="90%" align="left"><font class="whiteboldtext">Query the Bugs Database</font></TD>
</TR>
</TABLE>

<TABLE align="center" border=1 width=80% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<%
	Dim lSelectStr
	
	lSelectStr = "<SELECT name='sModules'><Option Value='0'>All</Option>"
	Set lRs = lSBObj.GetProjectModules ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("M_ModuleID") & "'>" & lRs("M_ModuleName") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
  <TR>
    <TD align=right><B>Module</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>
<%
	lSelectStr = "<SELECT name='sModules'><Option Value='0'>All</Option>"
	Set lRs = lSBObj.GetProjectModules ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("M_ModuleID") & "'>" & lRs("M_ModuleName") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
  <TR>
<%
	lSelectStr = "<SELECT name='sBugsStatus'><Option Value='0'>All</Option>"
	Set lRs = lSBObj.GetAllBugsStatus ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("S_StatusID") & "'>" & lRs("S_Status") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>

    <TD align=right><B>Status</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsPriority'><Option Value='0'>All</Option>"
	Set lRs = lSBObj.GetAllBugsPriority  ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("P_PriorityID") & "'>" & lRs("P_Priority") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align=right><B>Priority</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsSeverity'><Option Value='0'>All</Option>"
	Set lRs = lSBObj.GetAllBugsSeverity   ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("S_SeverityID") & "'>" & lRs("S_Severity") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align=right><B>Severity</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>
		<TR><TD align=right><B>Start Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
			<TD WIDTH="367" CLASS=tdbglight height="25"> 
			<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px" >
				<OPTION  value="1" <%if LMONTH=1 then Response.Write "selected"%>>January</OPTION>
				<OPTION value="2" <%if LMONTH=2 then Response.Write "selected"%>>February</OPTION>
				<OPTION value="3" <%if LMONTH=3 then Response.Write "selected"%>>March</OPTION>
				<OPTION value="4" <%if LMONTH=4 then Response.Write "selected"%>>April</OPTION>
				<OPTION value="5" <%if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
				<OPTION value="6" <%if LMONTH=6 then Response.Write "selected"%>>June</OPTION>
				<OPTION value="7" <%if LMONTH=7 then Response.Write "selected"%>>July</OPTION>
				<OPTION value="8" <%if LMONTH=8 then Response.Write "selected"%>>August</OPTION>
				<OPTION value="9" <%if LMONTH=9 then Response.Write "selected"%>>September</OPTION>
				<OPTION value="10" <%if LMONTH=10 then Response.Write "selected"%>>October</OPTION>
				<OPTION value="11" <%if LMONTH=11 then Response.Write "selected"%>>November</OPTION>
				<OPTION value="12" <%if LMONTH=12 then Response.Write "selected"%>>December</OPTION>
			</select> 
			<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" >
				<OPTION  value="1" <%if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%if LDATE=2 then Response.Write "selected"%>>2</OPTION>
				<OPTION value="3" <%if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%if LDATE=4 then Response.Write "selected"%>>4</OPTION>
				<OPTION value="5" <%if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%if LDATE=6 then Response.Write "selected"%>>6</OPTION>
				<OPTION value="7" <%if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%if LDATE=8 then Response.Write "selected"%>>8</OPTION>
				<OPTION value="9" <%if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%if LDATE=10 then Response.Write "selected"%>>10</OPTION>
				<OPTION value="11" <%if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%if LDATE=12 then Response.Write "selected"%>>12</OPTION>
				<OPTION value="13" <%if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%if LDATE=14 then Response.Write "selected"%>>14</OPTION>
				<OPTION value="15" <%if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%if LDATE=16 then Response.Write "selected"%>>16</OPTION>
				<OPTION value="17" <%if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%if LDATE=18 then Response.Write "selected"%>>18</OPTION>
				<OPTION value="19" <%if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%if LDATE=20 then Response.Write "selected"%>>20</OPTION>
				<OPTION value="21" <%if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%if LDATE=22 then Response.Write "selected"%>>22</OPTION>
				<OPTION value="23" <%if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%if LDATE=24 then Response.Write "selected"%>>24</OPTION>
				<OPTION value="25" <%if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%if LDATE=26 then Response.Write "selected"%>>26</OPTION>
				<OPTION value="27" <%if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%if LDATE=28 then Response.Write "selected"%>>28</OPTION>
				<OPTION value="29" <%if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%if LDATE=30 then Response.Write "selected"%>>30</OPTION>
				<OPTION value="31" <%if LDATE=31 then Response.Write "selected"%>>31</OPTION>
			</select>&nbsp;
			<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
				<OPTION value="<%=lYearPrev%>" selected><%=lYearPrev%></OPTION>
				<OPTION value="<%=LYEAR%>" selected><%=LYEAR%></OPTION>
			</select>
			</TD>
		</TR>
		<TR><TD <TD align=right><B>End Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
			<TD WIDTH="367" CLASS=tdbglight height="25"> 
			<select size="1" name="EndMonth" style="HEIGHT: 22px; WIDTH: 92px" >
				<OPTION  value="1" <%if LMONTH=1 then Response.Write "selected"%>>January</OPTION>
				<OPTION value="2" <%if LMONTH=2 then Response.Write "selected"%>>February</OPTION>
				<OPTION value="3" <%if LMONTH=3 then Response.Write "selected"%>>March</OPTION>
				<OPTION value="4" <%if LMONTH=4 then Response.Write "selected"%>>April</OPTION>
				<OPTION value="5" <%if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
				<OPTION value="6" <%if LMONTH=6 then Response.Write "selected"%>>June</OPTION>
				<OPTION value="7" <%if LMONTH=7 then Response.Write "selected"%>>July</OPTION>
				<OPTION value="8" <%if LMONTH=8 then Response.Write "selected"%>>August</OPTION>
				<OPTION value="9" <%if LMONTH=9 then Response.Write "selected"%>>September</OPTION>
				<OPTION value="10" <%if LMONTH=10 then Response.Write "selected"%>>October</OPTION>
				<OPTION value="11" <%if LMONTH=11 then Response.Write "selected"%>>November</OPTION>
				<OPTION value="12" <%if LMONTH=12 then Response.Write "selected"%>>December</OPTION>
			</select> 
			<select size="1" name="EndDate" style="HEIGHT: 22px; WIDTH: 40px" >
				<OPTION  value="1" <%if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%if LDATE=2 then Response.Write "selected"%>>2</OPTION>
				<OPTION value="3" <%if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%if LDATE=4 then Response.Write "selected"%>>4</OPTION>
				<OPTION value="5" <%if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%if LDATE=6 then Response.Write "selected"%>>6</OPTION>
				<OPTION value="7" <%if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%if LDATE=8 then Response.Write "selected"%>>8</OPTION>
				<OPTION value="9" <%if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%if LDATE=10 then Response.Write "selected"%>>10</OPTION>
				<OPTION value="11" <%if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%if LDATE=12 then Response.Write "selected"%>>12</OPTION>
				<OPTION value="13" <%if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%if LDATE=14 then Response.Write "selected"%>>14</OPTION>
				<OPTION value="15" <%if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%if LDATE=16 then Response.Write "selected"%>>16</OPTION>
				<OPTION value="17" <%if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%if LDATE=18 then Response.Write "selected"%>>18</OPTION>
				<OPTION value="19" <%if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%if LDATE=20 then Response.Write "selected"%>>20</OPTION>
				<OPTION value="21" <%if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%if LDATE=22 then Response.Write "selected"%>>22</OPTION>
				<OPTION value="23" <%if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%if LDATE=24 then Response.Write "selected"%>>24</OPTION>
				<OPTION value="25" <%if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%if LDATE=26 then Response.Write "selected"%>>26</OPTION>
				<OPTION value="27" <%if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%if LDATE=28 then Response.Write "selected"%>>28</OPTION>
				<OPTION value="29" <%if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%if LDATE=30 then Response.Write "selected"%>>30</OPTION>
				<OPTION value="31" <%if LDATE=31 then Response.Write "selected"%>>31</OPTION>
			</select>&nbsp;
			<select name="EndYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
				<OPTION value="<%=lYearPrev%>" selected><%=lYearPrev%></OPTION>
				<OPTION value="<%=LYEAR%>" selected><%=LYEAR%></OPTION>
			</select>
			</TD>
		</TR>
  <TR>
<%
	lSelectStr = "<SELECT name='sBugsReportedBy'><Option Value='0'>All</Option>"
	Set lRs = lTSObj.GetGroupUsers   (eval(lBugsGroupID)) 
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("U_Employee_ID") & "'>" & lRs("U_Name") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align=right><B>Reported By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsResponsibility'><Option Value='0'>All</Option>"
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("U_Employee_ID") & "'>" & lRs("U_Name") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align=right><B>Responsibility</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>
  <TR>
<%
	lSelectStr = "<SELECT name='sBugsFixedBy'><Option Value='0'>All</Option>"
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("U_Employee_ID") & "'>" & lRs("U_Name") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align=right><B>Fixed By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	<TD width=50%><%=lSelectStr%></TD>
  </TR>
  <TR>
<%
	lSelectStr = "<SELECT name='sBugsVerifiedBy'><Option Value='0'>All</Option>"
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			lSelectStr = lSelectStr & "<Option Value='" & lRs("U_Employee_ID") & "'>" & lRs("U_Name") & "</Option>"
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align=right><B>Verified By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	<TD width=50%><%=lSelectStr%></TD>
  </TR>
 </TABLE>
 <BR>
<TABLE width=80% align="center" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><INPUT type="submit" Value="View Bugs" style='BACKGROUND-COLOR: aqua'></TD>
</TR>
</TABLE>

</FORM>
<BR>
</BODY>
<%
	Set lSBObj = Nothing
	Set lTSObj = Nothing
	Set lRs = Nothing
%>
</HTML>
