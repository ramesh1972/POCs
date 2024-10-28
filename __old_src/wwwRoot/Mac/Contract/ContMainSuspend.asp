<%@Language=VBSCRIPT%>
<%
Option Explicit
%>
<%	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC module      								      *
	'* File name	:	ContMainSuspend.asp 						          *
	'* Purpose		:	This page is used to Display on Revoked TCM's      	  * 
	'* Prepared by	:	C.Satheesh Kumar    	    						  *
	'* Date			:	24.10.2001			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page is used to Display on Revoked TCM's       					  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   		   C.Satheesh Kumar               First Baseline      *
	'*																		  *
	'**************************************************************************
%>		


<%
	dim lContCode
	dim objreport
	dim lPageSize
	dim lTotalPage
	dim lCount	
	dim lStart
	dim lEnd
		
	'***
	dim StartMonth
	dim StartDate
	dim startYear
	dim CURRENTDATE
	dim lYearPrev
	dim lYearCurrent
	dim lYearNext
	DIM LMONTH
	DIM LDATE
	DIM LYEAR
	DIM LYEAR1
	dim lStartDay
	dim lStartMonth
	dim lStartYear
	dim lStartDate 		 
	'*******
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR = YEAR(CURRENTDATE)
	LYEAR1 = LYEAR+1
	lYearCurrent  = LYEAR
	lYearPrev	= LYEAR - 1
	lYearNext   = LYEAR + 1
	'********
	if Request.Form("StartDate")="" then
		lStartDate	=	Request.Form("hidStartDate")
	else
		lStartDay	=	cstr(Request.Form("StartDate"))
	if len(lStartDay) <=1  then
		lStartDay	=	0	&	lStartDay
	end if
	lStartMonth	=	cstr(Request.Form("StartMonth")) 
	if len(lStartMonth)<=1 then
		lStartMonth	=	0 & lStartMonth
	end if
		lStartYear	=	cstr(Request.Form("StartYear"))
		lStartDate	=	lStartYear & "-" & lStartMonth & "-" & lStartDay
		lStartDate	=	cstr(lStartDate)
	end if

	'***********
	dim InstCode
	InstCode = Request.QueryString("ContCode")
		
	
%>
<HTML>
 <HEAD>
		<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
		</style>
		<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
		<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
 </HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<script language =javascript>
	function validateDate()
	{
		lSDate	= document.ContMainSuspend.StartDate.value ;
		lSMonth	= document.ContMainSuspend.StartMonth.value;
		lSYear	= document.ContMainSuspend.StartYear.value;
		lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
		if ((validDate(lSMonth,lSDate,lSYear))== false )
	{
			document.ContMainSuspend.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;
	}
	return true;
	}
	
	function IntChange()
	{
		document.ContMainSuspend.FStartMonth.value = document.ContMainSuspend.FStartMonth.options[document.ContMainSuspend.FStartMonth.selectedIndex].value;
		document.ContMainSuspend.FStartDate.value = document.ContMainSuspend.FStartDate.options[document.ContMainSuspend.FStartDate.selectedIndex].value;
		document.ContMainSuspend.FStartYear.value = document.ContMainSuspend.FStartYear.options[document.ContMainSuspend.FStartYear.selectedIndex].value;
        document.ContMainSuspend.TStartMonth.value = document.ContMainSuspend.TStartMonth.options[document.ContMainSuspend.TStartMonth.selectedIndex].value;
		document.ContMainSuspend.TStartDate.value = document.ContMainSuspend.TStartDate.options[document.ContMainSuspend.TStartDate.selectedIndex].value;
		document.ContMainSuspend.TStartYear.value = document.ContMainSuspend.TStartYear.options[document.ContMainSuspend.TStartYear.selectedIndex].value;

	}
	
	
	function SelectResume()
	{
		document.ContMainSuspend.FStartMonth.disabled=true;
		document.ContMainSuspend.hidRBstatus.value=document.ContMainSuspend.radioResume.value;
		document.ContMainSuspend.FStartDate.disabled=true;
		document.ContMainSuspend.FStartYear.disabled=true;
		document.ContMainSuspend.TStartMonth.disabled=true;
		document.ContMainSuspend.TStartDate.disabled=true;
	    document.ContMainSuspend.TStartYear.disabled=true;   
	    document.ContMainSuspend.r 
	}
	
	function SelectSuspend()
	{
		document.ContMainSuspend.FStartMonth.disabled=false;
		document.ContMainSuspend.hidSBstatus.value=document.ContMainSuspend.radioSuspend.value;
		document.ContMainSuspend.FStartDate.disabled=false;
		document.ContMainSuspend.FStartYear.disabled=false;
		document.ContMainSuspend.TStartMonth.disabled=false;
		document.ContMainSuspend.TStartDate.disabled=false;
	    document.ContMainSuspend.TStartYear.disabled=false;   
	 }
	
	function FunctionSuspend()
	{
		document.ContMainSuspend.action ="ContractSuspendRes.asp";
		document.ContMainSuspend.hidSBstatus.value="S";
		document.ContMainSuspend.hidFSmonth.value=document.ContMainSuspend.FStartMonth.value;
		document.ContMainSuspend.hidFSday.value=document.ContMainSuspend.FStartDate.value;
		document.ContMainSuspend.hidFSyear.value=document.ContMainSuspend.FStartYear.value;
		document.ContMainSuspend.hidTSmonth.value=document.ContMainSuspend.TStartMonth.value;
		document.ContMainSuspend.hidTSday.value=document.ContMainSuspend.TStartDate.value;
		document.ContMainSuspend.hidTSyear.value=document.ContMainSuspend.FStartYear.value;
		document.ContMainSuspend.method ="post";
		document.ContMainSuspend.submit();
	}
	
	function FunctionResume()
	{
		document.ContMainSuspend.action ="ContractSuspendRes.asp";
		document.ContMainSuspend.hidRBstatus.value="R";
		document.ContMainSuspend.method ="post";
		document.ContMainSuspend.submit();
	}
	
	
	</script>
		
	<form method="post"  name="ContMainSuspend">
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	<table width="80%" border="1" cellpadding="1"  cellspacing="1" align="center">
	<tr class="tdbglight">
		<td width="30%"><font class=blacktext>Select for Suspend/Resume </font></td>
		<td class="blacktext"><input type="radio" size="10" name="radioSuspend" value="S"  onclick="return SelectSuspend();">Suspend</td>
		<td class="blacktext" colspan=2><input type="radio" size="10" name="radioResume" value="R" onclick="return SelectResume();">Resume </td>
    </tr> 
	
	<tr class="tdbglight">
	<td align="left" colspan=4>Contract Suspended period</td>
	</tr> 
	
	<tr class="tdbglight">
		<TD width="25%"><font class=blacktext>Suspend From Date</font></TD>
		<CENTER>
		<td WIDTH="30%"  colspan=3>
		<select size="1" name="FStartMonth" style="HEIGHT: 22px; WIDTH: 100px" onchange="IntChange()">
				<OPTION  value="1" <%'if LMONTH=1 then Response.Write "selected"%>>Jan</OPTION>
				<OPTION value="2" <%'if LMONTH=2 then Response.Write "selected"%>>Feb</OPTION>
				<OPTION value="3" <%'if LMONTH=3 then Response.Write "selected"%>>Mar</OPTION>
				<OPTION value="4" <%'if LMONTH=4 then Response.Write "selected"%>>Apr</OPTION>
				<OPTION value="5" <%'if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
				<OPTION value="6" <%'if LMONTH=6 then Response.Write "selected"%>>Jun</OPTION>
				<OPTION value="7" <%'if LMONTH=7 then Response.Write "selected"%>>Jul</OPTION>
				<OPTION value="8" <%'if LMONTH=8 then Response.Write "selected"%>>Aug</OPTION>
				<OPTION value="9" <%'if LMONTH=9 then Response.Write "selected"%>>Sep</OPTION>
				<OPTION value="10" <%'if LMONTH=10 then Response.Write "selected"%>>Oct</OPTION>
				<OPTION value="11" <%'if LMONTH=11 then Response.Write "selected"%>>Nov</OPTION>
				<OPTION value="12" <%'if LMONTH=12 then Response.Write "selected"%>>Dec</OPTION>
		</select> 
		<select size="1" name="FStartDate" style="HEIGHT: 22px; WIDTH: 70px"  onchange="IntChange()">
				<OPTION  value="1" <%'if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%'if LDATE=2 then Response.Write "selected"%>>2</OPTION>
				<OPTION value="3" <%'if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%'if LDATE=4 then Response.Write "selected"%>>4</OPTION>
				<OPTION value="5" <%'if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%'if LDATE=6 then Response.Write "selected"%>>6</OPTION>
				<OPTION value="7" <%'if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%'if LDATE=8 then Response.Write "selected"%>>8</OPTION>
				<OPTION value="9" <%'if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%'if LDATE=10 then Response.Write "selected"%>>10</OPTION>
				<OPTION value="11" <%'if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%'if LDATE=12 then Response.Write "selected"%>>12</OPTION>
				<OPTION value="13" <%'if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%'if LDATE=14 then Response.Write "selected"%>>14</OPTION>
				<OPTION value="15" <%'if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%'if LDATE=16 then Response.Write "selected"%>>16</OPTION>
				<OPTION value="17" <%'if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%'if LDATE=18 then Response.Write "selected"%>>18</OPTION>
				<OPTION value="19" <%'if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%'if LDATE=20 then Response.Write "selected"%>>20</OPTION>
				<OPTION value="21" <%'if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%'if LDATE=22 then Response.Write "selected"%>>22</OPTION>
				<OPTION value="23" <%'if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%'if LDATE=24 then Response.Write "selected"%>>24</OPTION>
				<OPTION value="25" <%'if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%'if LDATE=26 then Response.Write "selected"%>>26</OPTION>
				<OPTION value="27" <%'if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%'if LDATE=28 then Response.Write "selected"%>>28</OPTION>
				<OPTION value="29" <%'if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%'if LDATE=30 then Response.Write "selected"%>>30</OPTION>
				<OPTION value="31" <%'if LDATE=31 then Response.Write "selected"%>>31</OPTION>
		</select>
		<select name="FStartYear"  size="1" style="HEIGHT: 22px; WIDTH: 70px" onchange="IntChange()" >
				<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
				<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
				<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION>
		</select>
		</TD>
	</tr>
	
	<tr class="tdbglight">
		<TD width="25%"><font class=blacktext>Suspend To Date</font></TD>
		<CENTER>
		<td WIDTH="30%"  colspan=3>
		<select size="1" name="TStartMonth" style="HEIGHT: 22px; WIDTH: 100px" onchange="IntChange()">
				<OPTION  value="1" <%'if LMONTH=1 then Response.Write "selected"%>>Jan</OPTION>
				<OPTION value="2" <%'if LMONTH=2 then Response.Write "selected"%>>Feb</OPTION>
				<OPTION value="3" <%'if LMONTH=3 then Response.Write "selected"%>>Mar</OPTION>
				<OPTION value="4" <%'if LMONTH=4 then Response.Write "selected"%>>Apr</OPTION>
				<OPTION value="5" <%'if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
				<OPTION value="6" <%'if LMONTH=6 then Response.Write "selected"%>>Jun</OPTION>
				<OPTION value="7" <%'if LMONTH=7 then Response.Write "selected"%>>Jul</OPTION>
				<OPTION value="8" <%'if LMONTH=8 then Response.Write "selected"%>>Aug</OPTION>
				<OPTION value="9" <%'if LMONTH=9 then Response.Write "selected"%>>Sep</OPTION>
				<OPTION value="10" <%'if LMONTH=10 then Response.Write "selected"%>>Oct</OPTION>
				<OPTION value="11" <%'if LMONTH=11 then Response.Write "selected"%>>Nov</OPTION>
				<OPTION value="12" <%'if LMONTH=12 then Response.Write "selected"%>>Dec</OPTION>
		</select> 
		<select size="1" name="TStartDate" style="HEIGHT: 22px; WIDTH: 70px"  onchange="IntChange()">
				<OPTION  value="1" <%'if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%'if LDATE=2 then Response.Write "selected"%>>2</OPTION>
				<OPTION value="3" <%'if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%'if LDATE=4 then Response.Write "selected"%>>4</OPTION>
				<OPTION value="5" <%'if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%'if LDATE=6 then Response.Write "selected"%>>6</OPTION>
				<OPTION value="7" <%'if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%'if LDATE=8 then Response.Write "selected"%>>8</OPTION>
				<OPTION value="9" <%'if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%'if LDATE=10 then Response.Write "selected"%>>10</OPTION>
				<OPTION value="11" <%'if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%'if LDATE=12 then Response.Write "selected"%>>12</OPTION>
				<OPTION value="13" <%'if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%'if LDATE=14 then Response.Write "selected"%>>14</OPTION>
				<OPTION value="15" <%'if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%'if LDATE=16 then Response.Write "selected"%>>16</OPTION>
				<OPTION value="17" <%'if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%'if LDATE=18 then Response.Write "selected"%>>18</OPTION>
				<OPTION value="19" <%'if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%'if LDATE=20 then Response.Write "selected"%>>20</OPTION>
				<OPTION value="21" <%'if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%'if LDATE=22 then Response.Write "selected"%>>22</OPTION>
				<OPTION value="23" <%'if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%'if LDATE=24 then Response.Write "selected"%>>24</OPTION>
				<OPTION value="25" <%'if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%'if LDATE=26 then Response.Write "selected"%>>26</OPTION>
				<OPTION value="27" <%'if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%'if LDATE=28 then Response.Write "selected"%>>28</OPTION>
				<OPTION value="29" <%'if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%'if LDATE=30 then Response.Write "selected"%>>30</OPTION>
				<OPTION value="31" <%'if LDATE=31 then Response.Write "selected"%>>31</OPTION>
		</select>
		<select name="TStartYear"  size="1" style="HEIGHT: 22px; WIDTH: 70px" onchange="IntChange()" >				<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
				<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
				<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION>
		</select>
		</TD>
	</tr>
	
	<table  align="center">
	  <br>
	 <tr class=tdbglight height=30 align="center">
		<td>
			<input type="submit" name="ContSuspend" Value="Suspend" onclick="FunctionSuspend()">
			<input type="submit" name="ContResume" Value="Resume" onclick="FunctionResume()">
			<input type="Reset" name="Reset" value="Cancel">
		</td>
	</tr>
	</table>
	<Input type="hidden" name="hidSBstatus">
	<Input type="hidden" name="hidRBstatus">
	<Input type="hidden" name="hidContCode" value=<%=InstCode%>>
	<input type="hidden" name="hidFSmonth">
	<input type="hidden" name="hidFSday">
	<input type="hidden" name="hidFSyear">
	<input type="hidden" name="hidTSmonth">
	<input type="hidden" name="hidTSday">
	<input type="hidden" name="hidTSyear">
		
	</form>
	</body>	
    </HTML>