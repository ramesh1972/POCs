<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	UsrStatChange.asp										  *
	'* Purpose		:	This is used for .		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for .								  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   27/11/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************	

<%
	dim lAction
	dim	lUsrId
	dim lUsrStat
	dim lUsrStartDt
	dim lEndDt
	
	dim lPSMonth
	dim lPSDate
	dim lPSYear
	dim lPEMonth
	dim lPEDate
	dim lPEYear
	dim lPStartDate
	dim lPEndDate
	
	if Request("a") <>"" then
		
		lAction = Request("a")
		lUsrId		= trim( Request.Form("hidUsrId"))
		lUsrStat	= trim(Request.Form("optUsrStat"))
		lUsrStartDt	= trim(Request.Form("hidUsrStartDt"))
		lEndDt	= trim(Request.Form("hidEndDt"))
		
	
	 lPSMonth	= trim(Request.Form("optPSMonth"))
	 lPSDate	= trim(Request.Form("optPSDate"))
	 lPSYear	= trim(Request.Form("optPSYear"))
	 lPEMonth	= trim(Request.Form("optPEMonth"))
	 lPEDate	= trim(Request.Form("optPEDate"))
	 lPEYear	= trim(Request.Form("optPEYear"))					
	
	if len(lPSMonth) <=1 then
		lPSMonth	= "0" & lPSMonth
	end if
	if len(lPSDate) <= 1 then
		lPSDate	= "0" & lPSDate
	end if
	
	if len(lPEMonth) <=1 then
		lPEMonth	= "0" & lPEMonth
	end if
	if len(lPEDate) <= 1 then
		lPEDate	= "0" & lPEDate
	end if
	
	lPStartDate	= lPSYear & "-" & lPSMonth & "-" & lPSDate
	lPEndDate	= lPEYear & "-" & lPEMonth & "-" & lPEDate
	
	Response.Write 	lPStartDate & " D" & lPEndDate
		
		
		
		
	'	Response.Write lUsrId & lUsrStat & 	lUsrStartDt & lEndDt
		%>
		<html>
		<head>
		<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		<title>Welcome to the Bombay Commodity Exchange Limited</title>
		<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
		<!---#include file="../Includes/header.inc"---><br>
		<!--#include file="../Includes/MACLinks.inc" ----><br>
		<table width="60%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
				<td valign=center width="60%" height="27"><font class="whiteboldtext1"> User Status Change </font></td>
		</tr>
		<tr class="tdbglight"> 
			<td valign=center align=left width="60%" height="27"><font class="blacktext">
	
		<%	
		select case(lAction)
		case "s"	:

				set lObjUserStatus	=	server.CreateObject("Project1.UsrAndCompanyBrowseMgr")
				lResult = lObjUserStatus.UsrSuspend(lUsrId,lUsrStat, "MNA0003000", lPStartDate,lPEndDate, "11:12:20", "16:32:20", "MNA0003000")
				Response.Write lResult
				select case(lResult)
					case	0		:	Response.Write "Suspended"
					case	1000	:	Response.Write "Invalid User Id"
					case	2000	:	Response.Write "User is already in Procedural Suspension"
					case	2400	:	Response.Write "User is already in Disciplinary Suspension"
				end select
		case "h"	:
				
				set lObjUserStatus	=	server.CreateObject("Project1.UsrAndCompanyBrowseMgr")
				lResult = lObjUserStatus.UsrHalt(lUsrId,"H", "MNA0003000", lPStartDate,lPEndDate, "11:12:20", "16:32:20", "MNA0003000")
				Response.Write lResult
					select case(lResult)
					case	0		:	Response.Write "Halted"
					case	1000	:	Response.Write "Invalid User Id"
					case	2000	:	Response.Write "User is already in Procedural Suspension"
					case	2400	:	Response.Write "User is already in Disciplinary Suspension"
					case	2200	:	Response.Write "User is already in Halt state"
				end select
		case "a"	:

				set lObjUserStatus	=	server.CreateObject("Project1.UsrAndCompanyBrowseMgr")
				lResult = lObjUserStatus.UsrReactivate(lUsrId,"N", "MNA0003000", lPStartDate,lPEndDate,"11:12:20", "16:32:20")
				Response.Write lResult
				select case(lResult)
					case	0		:	Response.Write "User Reactivated"
					case	1000	:	Response.Write "Invalid User Id"
					case	2300	:	Response.Write "User is not in halt stage"
				end select
		
		case "r"	:

				set lObjUserStatus	=	server.CreateObject("Project1.UsrAndCompanyBrowseMgr")
				lResult = lObjUserStatus.UsrResume(lUsrId,"N", "MNA0003000", lPStartDate,lPEndDate, "11:12:20", "16:32:20")
				Response.Write lResult
				select case(lResult)
					case	0	:	Response.Write "User Resumed"
					case	1000	:	Response.Write "Invalid User Id"
					case	2100	:	Response.Write "User is already in Procedural Suspension"
					case	2500	:	Response.Write "User is already in Disciplinary Suspension"
				end select
		end select %>
		</font></td>
		</tr></table>
		<br><!---#include file="../includes/footer.inc"--->
		</body>
		</html>
	<%
	else		

	dim lSMonth
	dim lSYear
	dim lEDate
	dim lEMonth
	dim lEYear
	dim lCurrentDate
	dim lMonth
	dim lDate
	dim lYear
	dim lYearprev
	dim lYearNext
	
	
	lUsrId		= trim( Request("uid"))
	lUsrStat	= trim(Request("st"))
	lUsrStartDt	= trim(Request("sd"))
	lEndDt		=trim(Request("ed"))
	
	lSDate = mid(lUsrStartDt,9,2)
	lSMonth	= mid(lUsrStartDt,6,2)
	lSYear	= left(lUsrStartDt,4)
	
	if left(lSDate,1) = "0" then
		lSDate = right(lSDate,1)
	end if
	if left(lSMonth,1) = "0" then
		lSMonth = right(lSMonth,1)
	end if
	
	lEDate = mid(lEndDt,9,2)
	lEMonth	= mid(lEndDt,6,2)
	lEYear	= left(lEndDt,4)
	
	if left(lEDate,1) = "0" then
		lEDate = right(lEDate,1)
	end if
	if left(lEMonth,1) = "0" then
		lEMonth = right(lEMonth,1)
	end if
	
	lCurrentDate=now()
	lMonth= month(lCurrentDate)
	lDate=day(lCurrentDate) 
	lYear=year(lCurrentDate) 
	lYearprev = lYear -1
	lYearNext	= lYear + 1
	
	'Response.Write "Start Date- dt = " & lSDate & "<br>"
	'Response.Write "Start Date- Month = " & lSMonth & "<br>"
	'Response.Write "User Id = " & lUsrId & "<br>"
	'Response.Write "User Status = " & lUsrStat & "<br>"
	'Response.Write "User Start Date = " &  lUsrStartDt & "<br>"
	'Response.Write "User End Date = " & lEndDt & "<br>"
	%>
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<script language="javascript">
	function Action(fnValue)
	{
		if (fnValue == 1 )
		{
			if ((document.frmUsrStatChange.optUsrStat.value =='P') || (document.frmUsrStatChange.optUsrStat.value =='D'))
			{
				document.frmUsrStatChange.action = 'UsrStatChange.asp?a=s';
				document.frmUsrStatChange.method = "post";
				document.frmUsrStatChange.submit();  
			}
			else
			{
				document.frmUsrStatChange.optUsrStat.focus(); 
				alert("User Suspension should be either Procedural suspension\n or Disciplinary suspension");
				return false;
			}
		}
		
		if (fnValue == 2 )
		{
			if (document.frmUsrStatChange.optUsrStat.value =='H')
			{
				document.frmUsrStatChange.action = 'UsrStatChange.asp?a=h';
				document.frmUsrStatChange.method = "post";
				document.frmUsrStatChange.submit();  
			}
			else
			{
				document.frmUsrStatChange.optUsrStat.focus(); 
				alert("User Status should be Halted");
				return false;
			}
		}
		
		if (fnValue == 3 )
		{
			if (document.frmUsrStatChange.optUsrStat.value =='N')
			{
				document.frmUsrStatChange.action = 'UsrStatChange.asp?a=a';
				document.frmUsrStatChange.method = "post";
				document.frmUsrStatChange.submit();  
			}
			else
			{
				document.frmUsrStatChange.optUsrStat.focus(); 
				alert("User Status should be Active for Reactive");
				return false;
			}
		}
		
		
		if (fnValue == 4 )
		{
			if (document.frmUsrStatChange.optUsrStat.value =='N')
			{
				document.frmUsrStatChange.action = 'UsrStatChange.asp?a=r';
				document.frmUsrStatChange.method = "post";
				document.frmUsrStatChange.submit();  
			}
			else
			{
				document.frmUsrStatChange.optUsrStat.focus(); 
				alert("User Status should be Active for Resume");
				return false;
			}
		}
	}
	var lCount;
	lCount =0;
	
	function ValueCheck()
	{
	if (((event.keyCode >= 48) && (event.keyCode <=57) ) || (event.keyCode ==58 )){
		if (event.keyCode ==58){
			if (lCount < 2){
				lCount = lCount +1;}
			else{
				document.frmUsrStatChange.txtStartTime.select(); 
				alert("Please enter the time in this format (hh:mm:ss)");
				return false;}
			}return true;}
		else{
			alert("Please enter the time in this format (hh:mm:ss)");
			event.returnValue  = 0;
			return false;}	
	}
	</script>
	
	</
	head>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	<form name="frmUsrStatChange" action="UsrStatChange.asp">
	<table width="60%" border="1"  cellpadding=1 cellspacing=1 align="center">
	<tr class="tdbgdark"> 
		<td valign=center width="60%" colspan=2 height="27"><font class="whiteboldtext1"> User Status </font></td>
	</tr>
	<tr class="tdbglight"> 
		<td valign=center width="50%" height="27"><font class="blacktext"> User ID</font></td>
		<td valign=center width="50%" height="27"><font class="blacktext"><%=lUsrId%></font></td>
	</tr>
	<tr class="tdbglight"> 
		<td valign=center width="50%" height="27"><font class="blacktext"> User Status</font></td>
		<td valign=center width="50%" height="27"><font class="blacktext">
			<select name="optUsrStat" width="27%" style="HEIGHT: 22px; WIDTH: 199px">
				<option value="N" <%if lUsrStat="N" then Response.Write "selected" %> >Active</option>
				<option value="H" <%if lUsrStat="H" then Response.Write "selected" %> >Halt</option>
				<option value="P" <%if lUsrStat="P" then Response.Write "selected" %> >Procedural Suspension</option>
				<option value="D" <%if lUsrStat="D" then Response.Write "selected" %> >Disciplinary Suspension</option>
			</select>
		</font></td>
	</tr>
	<tr class="tdbglight"> 
		<td valign=center width="50%" height="27"><font class="blacktext"> Password Start Date</font></td>
			<td  class=tdbglight height="20" width="50%"> 
			<select size="1" name="optPSMonth">
				<option  value="1" <%if lSMonth=1 then Response.Write "selected"%>>January</option>
				<option value="2" <%if lSMonth=2 then Response.Write "selected"%>>February</option>
				<option value="3" <%if lSMonth=3 then Response.Write "selected"%>>March</option>
				<option value="4" <%if lSMonth=4 then Response.Write "selected"%>>April</option>
				<option value="5" <%if lSMonth=5 then Response.Write "selected"%>>May</option>
				<option value="6" <%if lSMonth=6 then Response.Write "selected"%>>June</option>
				<option value="7" <%if lSMonth=7 then Response.Write "selected"%>>July</option>
				<option value="8" <%if lSMonth=8 then Response.Write "selected"%>>August</option>
				<option value="9" <%if lSMonth=9 then Response.Write "selected"%>>September</option>
				<option value="10" <%if lSMonth=10 then Response.Write "selected"%>>October</option>
				<option value="11" <%if lSMonth=11 then Response.Write "selected"%>>November</option>
				<option value="12" <%if lSMonth=12 then Response.Write "selected"%>>December</option>
			</select> 
			<select size="1" name="optPSDate">
				<option  value="1" <%if lSDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lSDate=2 then Response.Write "selected"%>>2</option>
				<option value="3" <%if lSDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lSDate=4 then Response.Write "selected"%>>4</option>
				<option value="5" <%if lSDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lSDate=6 then Response.Write "selected"%>>6</option>
				<option value="7" <%if lSDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lSDate=8 then Response.Write "selected"%>>8</option>
				<option value="9" <%if lSDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lSDate=10 then Response.Write "selected"%>>10</option>
				<option value="11" <%if lSDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lSDate=12 then Response.Write "selected"%>>12</option>
				<option value="13" <%if lSDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lSDate=14 then Response.Write "selected"%>>14</option>
				<option value="15" <%if lSDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lSDate=16 then Response.Write "selected"%>>16</option>
				<option value="17" <%if lSDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lSDate=18 then Response.Write "selected"%>>18</option>
				<option value="19" <%if lSDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lSDate=20 then Response.Write "selected"%>>20</option>
				<option value="21" <%if lSDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lSDate=22 then Response.Write "selected"%>>22</option>
				<option value="23" <%if lSDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lSDate=24 then Response.Write "selected"%>>24</option>
				<option value="25" <%if lSDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lSDate=26 then Response.Write "selected"%>>26</option>
				<option value="27" <%if lSDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lSDate=28 then Response.Write "selected"%>>28</option>
				<option value="29" <%if lSDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lSDate=30 then Response.Write "selected"%>>30</option>
				<option value="31" <%if lSDate=31 then Response.Write "selected"%>>31</option>
			</select>&nbsp;
				
			<select name="optPSYear"  size="1" >
				<option value="<%=lSYear%>" selected ><%=lSYear%></option>
				<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
				<option value="<%=lYear%>" ><%=lYear%></option>
			</select>
			</td>
		</tr>
	
	
		<tr class="tdbglight"> 
			<td valign=center width="50%" height="27"><font class="blacktext"> Password End Date</font></td>
			<td  class=tdbglight height="20" width="50%"> 
			<select size="1" name="optPEMonth">
				<option  value="1" <%if lEMonth=1 then Response.Write "selected"%>>January</option>
				<option value="2" <%if lEMonth=2 then Response.Write "selected"%>>February</option>
				<option value="3" <%if lEMonth=3 then Response.Write "selected"%>>March</option>
				<option value="4" <%if lEMonth=4 then Response.Write "selected"%>>April</option>
				<option value="5" <%if lEMonth=5 then Response.Write "selected"%>>May</option>
				<option value="6" <%if lEMonth=6 then Response.Write "selected"%>>June</option>
				<option value="7" <%if lEMonth=7 then Response.Write "selected"%>>July</option>
				<option value="8" <%if lEMonth=8 then Response.Write "selected"%>>August</option>
				<option value="9" <%if lEMonth=9 then Response.Write "selected"%>>September</option>
				<option value="10" <%if lEMonth=10 then Response.Write "selected"%>>October</option>
				<option value="11" <%if lEMonth=11 then Response.Write "selected"%>>November</option>
				<option value="12" <%if lEMonth=12 then Response.Write "selected"%>>December</option>
			</select> 
			<select size="1" name="optPEDate">
				<option  value="1" <%if lEDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lEDate=2 then Response.Write "selected"%>>2</option>
				<option value="3" <%if lEDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lEDate=4 then Response.Write "selected"%>>4</option>
				<option value="5" <%if lEDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lEDate=6 then Response.Write "selected"%>>6</option>
				<option value="7" <%if lEDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lEDate=8 then Response.Write "selected"%>>8</option>
				<option value="9" <%if lEDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lEDate=10 then Response.Write "selected"%>>10</option>
				<option value="11" <%if lEDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lEDate=12 then Response.Write "selected"%>>12</option>
				<option value="13" <%if lEDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lEDate=14 then Response.Write "selected"%>>14</option>
				<option value="15" <%if lEDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lEDate=16 then Response.Write "selected"%>>16</option>
				<option value="17" <%if lEDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lEDate=18 then Response.Write "selected"%>>18</option>
				<option value="19" <%if lEDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lEDate=20 then Response.Write "selected"%>>20</option>
				<option value="21" <%if lEDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lEDate=22 then Response.Write "selected"%>>22</option>
				<option value="23" <%if lEDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lEDate=24 then Response.Write "selected"%>>24</option>
				<option value="25" <%if lEDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lEDate=26 then Response.Write "selected"%>>26</option>
				<option value="27" <%if lEDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lEDate=28 then Response.Write "selected"%>>28</option>
				<option value="29" <%if lEDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lEDate=30 then Response.Write "selected"%>>30</option>
				<option value="31" <%if lEDate=31 then Response.Write "selected"%>>31</option>
			</select>&nbsp;
			<select name="optPEYear"  size="1" >
				<option value="<%=lEYear%>" selected ><%=lEYear%></option>
				<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
				<option value="<%=lYear%>" ><%=lYear%></option>
				<option value="<%=lYearNext%>"><%=lYearNext%></option>
			</select>
			</td>
		</tr>
		
		<tr class="tdbglight"> 
			<td valign=center width="50%" height="27"><font class="blacktext">Password Start Time (hh:mm:ss)</font></td>
			<td valign=center width="50%" height="27"><input type=text name="txtStartTime" size=26 maxlength=8 onkeypress="return ValueCheck();" ></td>
		</tr>
		
		<tr class="tdbglight"> 
			<td valign=center width="50%" height="27"><font class="blacktext">Password End Time  (hh:mm:ss)</font></td>
			<td valign=center width="50%" height="27"><input type=text name="txtEndTime" size=26 maxlength=8 onkeypress="return ValueCheck();"></td>
		</tr>
		<input type="hidden" name="hidUsrId" value="<%=lUsrId%>" >
		<input type="hidden" name="hidUsrStat" value="<%=lUsrStat%>" >
		<input type="hidden" name="hidUsrStartDt" value="<%=lUsrStartDt%>" >
		<input type="hidden" name="hidEndDt" value="<%=lEndDt%>" >
		<tr class="tdbglight"> 
			<td valign=center align=center width="50%" height="27" colspan=4>
				<input type=button name="btnSuspend" value="Suspend" onclick="return Action(1);">
				<input type=button name="btnSuspend" value="Resume" onclick="return Action(4);">
				<input type=button name="btnSuspend" value="Halt" onclick="return Action(2);">
				<input type=button name="btnSuspend" value="Reactivate" onclick="return Action(3);">
		
			</td>
		</tr>
		</table>
		</form>
		<br><!---#include file="../includes/footer.inc"--->
		</body>
		</html>
		<%end if%>
