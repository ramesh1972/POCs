<%@Language=VBSCRIPT%>
<%
'Option Explicit
%>
<%	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Surveillance User								      *
	'* File name	:	WBnkDownLoad.asp								      *
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
	dim StartMonth
	dim StartDay
	dim startYear
	dim currentdate
	dim lPrevYear
	dim lCurrYear
	dim lNextYear
	
	currentdate=NOW()
	lCurrYear  = Year(Currentdate)
	lPrevYear	= lCurrYear - 1
	lNextYear   = lCurrYear + 1
   %>
   <HTML>
	<HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
    </head>

	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class="bodycolor">
	<form name="FrmBnkDownLoadSelection"  method="post">
	<center>
	<br>
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	<script language =javascript>
		function FunctionView()
		{
		document.FrmBnkDownLoadSelection.action="WBnkDownLoadRes.asp";
		document.FrmBnkDownLoadSelection.method="post";
		document.FrmBnkDownLoadSelection.submit();
		}
		
		function FunctionCancel()
		{
		document.FrmBnkDownLoadSelection.action="MacClearingSettlement.asp";
		document.FrmBnkDownLoadSelection.submit();
		}  
	   <!--#include file="../Includes/DateValid.inc"--> 
	</script>
	
	<table width="50%" border="1" cellpadding="3"  cellspacing="1" align="center">
	<tr>
 		<td colspan=2 align="Left"  class="tdbglight">
		 <font class=blackboldtext1>Wrong Account Number DownLoad Bank Details</font>
 		</td>
 	</tr>
   <TR >
	<TD class=tdbglight width="160" height="10">
		<font class=blacktext>Please Select the Date</font>
	</TD>
	<TD WIDTH="200" CLASS=tdbglight height="10"> 
			<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px">
					<OPTION  value="1" <%if LMONTH=1 then Response.Write "selected"%>>January</OPTION>
					<OPTION value="2"  <%if LMONTH=2 then Response.Write "selected"%>>February</OPTION>
					<OPTION value="3"  <%if LMONTH=3 then Response.Write "selected"%>>March</OPTION>
					<OPTION value="4"  <%if LMONTH=4 then Response.Write "selected"%>>April</OPTION>
					<OPTION value="5"  <%if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
					<OPTION value="6"  <%if LMONTH=6 then Response.Write "selected"%>>June</OPTION>
					<OPTION value="7"  <%if LMONTH=7 then Response.Write "selected"%>>July</OPTION>
					<OPTION value="8"  <%if LMONTH=8 then Response.Write "selected"%>>August</OPTION>
					<OPTION value="9"  <%if LMONTH=9 then Response.Write "selected"%>>September</OPTION>
					<OPTION value="10" <%if LMONTH=10 then Response.Write "selected"%>>October</OPTION>
					<OPTION value="11" <%if LMONTH=11 then Response.Write "selected"%>>November</OPTION>
					<OPTION value="12" <%if LMONTH=12 then Response.Write "selected"%>>December</OPTION>
			</select> 
			
			 <select size="1" name="StartDay" onchange="DateValidation(document.FrmBnkDownLoadSelection.StartMonth.value,this.value);")>
					<OPTION  value="1" <%if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%if LDATE=2 then Response.Write "selected"%>>2</OPTION>
					<OPTION value="3"  <%if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%if LDATE=4 then Response.Write "selected"%>>4</OPTION>
					<OPTION value="5"  <%if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%if LDATE=6 then Response.Write "selected"%>>6</OPTION>
					<OPTION value="7"  <%if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%if LDATE=8 then Response.Write "selected"%>>8</OPTION>
					<OPTION value="9"  <%if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%if LDATE=10 then Response.Write "selected"%>>10</OPTION>
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
			</select>
				
			<select size="1" name="StartYear" size="1" style="HEIGHT: 22px; WIDTH: 60px" onchange="return LeapYearValidation(document.FrmBnkDownLoadSelection.StartYear.value,document.FrmBnkDownLoadSelection.StartDay.value,document.FrmBnkDownLoadSelection.StartMonth.value)">
	   			<OPTION value="<%=lPrevYear%>" ><%=lPrevYear%></OPTION>
				<OPTION value="<%=lCurrYear%>" selected><%=lCurrYear%></OPTION>
				<OPTION value="<%=lNextYear%>" ><%=lNextYear%></OPTION> 
				<OPTION value="<%=lNextYear+1%>" ><%=lNextYear+1%></OPTION> 
			</select>
		</TD>
		</TR>
	
	<tr>
	<td colspan=2 align="center"  class="tdbglight">
	   <input type="submit" name="BtnView" value="View" onclick="FunctionView();">
	   <input type="Reset"  name="BtnCancel" value="Cancel" onclick="FunctionCancel();">
	</td>
	
   	<tr>
	</table>   
	<br><br>
    <!---#include file="../Includes/footer.inc"---> 
	</form>
	</body>	
    </HTML>