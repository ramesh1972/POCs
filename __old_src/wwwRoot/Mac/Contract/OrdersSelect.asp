<%@ Language=VBScript %>
<% 
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading												  *
	'* File name	:	OrdersSelect.asp									  *
	'* Purpose		:	This is used to Change Pin					          *
	'* Prepared by	:	V.Christopher Britto								  *	
	'* Date			:	20.07.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to change Pin for TCM,ICM, SubBroker & Client			  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	   	  *
	'*	1		   20.07.2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************
	
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR=YEAR(CURRENTDATE)
	LYEAR1=LYEAR+1
	lYearPrev = LYEAR - 1
	

	%>
	<HTML>
	<HEAD>
	<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<LINK REL=StyleSheet HREF="../Includes/theme.css" TITLE="Contemporary">
	<script language="Javascript">
	function validateDate()
	{
		lSDate	= document.frmOrdersSelect.StartDate.value ;
		lSMonth	= document.frmOrdersSelect.StartMonth.value;
		lSYear	= document.frmOrdersSelect.StartYear.value;
		lEDate	=	document.frmOrdersSelect.EndDate.value;
		lEMonth	=	document.frmOrdersSelect.EndMonth.value;
		lEYear	=	document.frmOrdersSelect.EndYear.value;  
		lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
		lEDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear);
		if (lSDay > lEDay) 
		{
			document.frmOrdersSelect.StartMonth.focus(); 
			alert("Start date should be Greater than End date");
			return false;
		}
		if ((validDate(lSMonth,lSDate,lSYear))== false )
		{
			document.frmOrdersSelect.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;
		}
		if ((validDate(lEMonth,lEDate,lEYear))== false)
		{
			document.frmOrdersSelect.EndDate.focus(); 
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
	
	function validateOrderSelect()
	{
		if (document.frmOrdersSelect.txtAciveOrder.checked == false)
		{
			document.frmOrdersSelect.txtAciveOrder.focus();
			alert("Please Select eithor Active Order or Executed Order");
			return false;
		}
		if (document.frmOrdersSelect.txtOrderType.checked == false)
		{
			alert("Please Select on of these Order type Buy, Sell and Both ");
			document.frmOrdersSelect.txtOrderType.focus(); 
			return false;
		}
		return true;
	}
	
	function validateOrder()
	{
		document.frmOrdersSelect.StartDate.disabled = true;
		document.frmOrdersSelect.StartMonth.disabled = true;
		document.frmOrdersSelect.StartYear.disabled = true;
		document.frmOrdersSelect.EndDate.disabled = true;
		document.frmOrdersSelect.EndMonth.disabled = true;
		document.frmOrdersSelect.EndYear.disabled = true;   
	}
	
	function validateDateEnabled()
	{
		document.frmOrdersSelect.StartDate.disabled = false;
		document.frmOrdersSelect.StartMonth.disabled = false;
		document.frmOrdersSelect.StartYear.disabled = false;
		document.frmOrdersSelect.EndDate.disabled = false;
		document.frmOrdersSelect.EndMonth.disabled = false;
		document.frmOrdersSelect.EndYear.disabled = false;   
	}
	</script></HEAD>
	<center>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/LogonCheck.asp" --->
	<!-- #include file = "../Includes/IncludeCheck.asp" --><br>
	</center>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
	<form name="frmOrdersSelect" method="post" action="OrdSelectRes.asp">
	<table width="50%" border="1"  cellpadding=2 cellspacing=2 align=center height="146">
		<tr class="tdbgdark"> 
			<td valign=center colspan=3 class="whiteboldtext1">Orders Selection</td>
		</tr>
		<tr class="tdbglight">
			<td class="blacktext"><input type="radio" size="10" name="txtAciveOrder" value="A" checked onclick="return validateDateEnabled();">Active Order</td>
			<td class="blacktext" colspan=2><input type="radio" size="10" name="txtAciveOrder" value="E" onclick="return validateOrder();">Executed Order</td>
	    </tr> 
	    <tr class="tdbglight"> 
			<td valign=center class="blacktext" >Orders Type</td>
			<td class="blacktext"><input type="radio" size="10" name="txtOrderType" value="B" checked>Buy
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" size="10" name="txtOrderType" value="S">Sell</td>
		</tr>
		
	    <TR><TD class=tdbglight width="230" height="25"><font class=blacktext>Start Date</font></TD>
			<TD WIDTH="367" CLASS=tdbglight height="25"> 
				<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px" >
					<OPTION  value="1" <%if  LMONTH=1 then Response.Write "selected"%>>January</OPTION>
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
					<OPTION value="<%=lYearPrev%>"><%=lYearPrev%></OPTION>
					<OPTION value="<%=LYEAR%>" selected><%=LYEAR%></OPTION>
				</select>
			</TD>
		</TR>							    
		<TR><TD class=tdbglight width="230" height="25"><font class=blacktext> End Date</font></TD>
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
					<OPTION value="<%=LYEAR%>" selected><%=LYEAR%></OPTION>
				</select>
			</TD>
		</TR>
		<tr> 
			<td colspan=3 valign="center" align=middle class="tdbglight">
				<input type="submit" name="sbtOrderSelect" value="Display"  onclick ="validateOrderSelect();return validateDate();">
			</td>
		</tr>
	</table>
	</form>
	</body><br>
	<center><!-- #include file="../includes/footer.inc"--></center>
	</html>
