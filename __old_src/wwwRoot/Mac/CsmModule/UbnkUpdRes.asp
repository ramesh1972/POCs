<%@ Language=VBScript %>
<%

    '**************************************************************************
	'* Application	:	BCE								    				   		  *
	'* Module		   :   Broker Admin										  		*
	'* File name	   :	ubnkview.asp               					  *
	'* Purpose		   :	This page will display   bank detial of a particular user           *
	'*                  code                                                  * 
	'* Prepared by	:	shaikh md zeeshan                 						  *	
	'* Date			:	30.11.2001											  			*
	'* Copyright	:	(c) SSI Technologies,India							  			*
	'*																		  				*
	'**************************************************************************

	'**************************************************************************
	'* General Notes														             *
	'* This page will display a record based on userid                  *
	'* Client Side	:	Javascript											          *
	'*																		              *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														          *
	'* Version No.- Date		- By				   - Explanation	   	             *
	'*	1		            - shaik md zeeshan              First Baseline      *
	'**************************************************************************
	dim CURRENTDATE
	dim lYearPrev
	dim lYearCurrent
	dim lYearNext
	dim butAction
	'*******
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR = YEAR(CURRENTDATE)
	LYEAR1 = LYEAR+1
	lYearCurrent  = LYEAR
	lYearPrev	= LYEAR - 1
	lYearNext   = LYEAR + 1
'*****for date
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
	

%>



<HTML>
<HEAD>
<style>
		a {text-decoration:none}
		a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
	<title>Welcome to the bombay oilseeds and oils exchange limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
	<script language="javascript">
		function fn_Go()
		{
			document.UsrBankDetailupdate.method="post";
			document.UsrBankDetailupdate.action="UbnkUpdResult.asp";
			document.UsrBankDetailupdate.submit();
		}
		</script>
	</HEAD>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<%
 dim lUsrID
 dim lAcctype
 dim lbankcode
 dim lBranchcode
 dim lAccno
 dim lAccOpenYear
 dim lAccOpenmonth
 dim lAccOpenday
 dim lResult
 dim lResultValues
 dim lDisValue
 dim luserid
 
	set lObjUsrBankDetail	= server.CreateObject("Mac.UserBankMgr")
	lUsrID	= trim(Request.Form("selUsrId"))
	lAcctype	= trim(Request.Form("selAccounttype"))
 	
	lbankcode=Request.Form("optBnkCode")
	lBranchcode= trim(Request.Form("OptBrnCode"))
 	
	lResult = lObjUsrBankDetail.DoUsrBnkView(lUsrID,lbankcode, lBranchcode, lAcctype,lAccno,lAccOpenYear)
	
	select case lResult
    case "0":
		lResponse = "hello"
	case "100":
		lResponse = "Record Does not Exist"	
	case "1800":
		lResponse = "The System Date doesn't match"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	End Select
	'Response.Write "Response code =" & lResult
%>
<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	

<%	
	if lResult = "0" then	
%>


<center>
<form name="UsrBankDetailupdate"  method="post" >
<table width="640" border="1"  cellpadding=2 cellspacing=2 align=center height="208">
<tr class="tdbgdark">
 <td valign=center colspan=3 class="whiteboldtext1" width="628" height="19">User Bank Detail</td>
 </tr>
	 <TR><TD class=tdbglight width=202 height="13"><font class=blacktext>User&nbsp;
        </font></TD>
        <TD width="303" class=tdbglight height="23">
			<%=lUsrID%>        <input name="selUsrId" type=hidden value="<%=lUsrID%>">
		 <!--<INPUT NAME="selUsrId" size="19" > -->

		
		<TR><TD class=tdbglight width=202 height="23"><font class=blacktext>Account
            Type:</font></TD>
       <TD width="303" class=tdbglight height="23">
       <%=lAcctype%> <input name="selAccounttype" type=hidden value="<%=lAcctype%>">
		<!-- <INPUT NAME="selAccounttype" size="19" > --> </TD>
     	</TR>
		
	   <TR><TD class=tdbglight width=202 height="23"><font class=blacktext>Bank Code:</font></TD>
	   <TD width="303" class=tdbglight height="23">
	   		<%=lbankcode%><input name="selBankCode" type=hidden value="<%=lbankcode%>">
		 	<!--<INPUT NAME="selBankCode" size="19" > --> 
		 </TD>
		</TR>
		<TR>
			<TD class=tdbglight width=202 height="23"><font class=blacktext>Branch Code:</font></TD>
			<TD width="303" class=tdbglight height="23">
				<%=lBranchcode%><input name="selBranchCode" type=hidden value="<%=lBranchcode%>">
				<!--  <INPUT NAME="selBranchCode" size="19" > -->
			 </TD>
	  </TR>
		<TR>
			<TD class=tdbglight width=202 height="23"><font class=blacktext>Account Number:</font></TD>
			<TD width="303" class=tdbglight height="23"> 
			 <INPUT NAME="txtAccno" size="19" value=" <%=lAccno%>"></TD>
		<TR >
			<TD class=tdbglight width="160" height="10">
				<font class=blacktext>Please Select the Date</font>
				
			</TD>
			
			
			<TD WIDTH="200" CLASS=tdbglight height="10"> 
			    <%LMONTH=mid(lAccOpenYear,6,2)
					IF LEFT(LMONTH,1)="0" THEN
						LMONTH = MID(LMONTH,2)
					END IF
			    %>
			     
				<select size="1" name="StartMonth" style="height: 23; width: 72" >
					<OPTION  value="1"  <%if LMONTH=1 then Response.Write "selected"%>>January</OPTION>
					<OPTION value="2" <%if LMONTH=2 then Response.Write "selected"%> >February</OPTION>
					<OPTION value="3"  <%if LMONTH=3 then Response.Write "selected"%>>March</OPTION>
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
				<select size="1" name="StartDate" style="height: 23; width: 55" >
				    <%LDATE=mid(lAccOpenYear,9,2)
					IF LEFT(LDATE,1)="0" THEN
						LDATE = MID(LDATE,2)
					END IF
			        %>
			   
					<OPTION  value="1" <%if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%'if LDATE=2 then Response.Write "selected"%>>2</OPTION>
					<OPTION value="3"  <%if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%'if LDATE=4 then Response.Write "selected"%>>4</OPTION>
					<OPTION value="5"  <%if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%'if LDATE=6 then Response.Write "selected"%>>6</OPTION>
					<OPTION value="7"  <%if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%'if LDATE=8 then Response.Write "selected"%>>8</OPTION>
					<OPTION value="9"  <%if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%'if LDATE=10 then Response.Write "selected"%>>10</OPTION>
					<OPTION value="11" <%if LDATE=11 then Response.Write "selected"%>>11</OPTION> <OPTION value="12" <%'if LDATE=12 then Response.Write "selected"%>>12</OPTION>
					<OPTION value="13" <%if LDATE=13 then Response.Write "selected"%>>13</OPTION> <OPTION value="14" <%'if LDATE=14 then Response.Write "selected"%>>14</OPTION>
					<OPTION value="15" <%if LDATE=15 then Response.Write "selected"%>>15</OPTION> <OPTION value="16" <%'if LDATE=16 then Response.Write "selected"%>>16</OPTION>
					<OPTION value="17" <%if LDATE=17 then Response.Write "selected"%>>17</OPTION> <OPTION value="18" <%'if LDATE=18 then Response.Write "selected"%>>18</OPTION>
					<OPTION value="19" <%if LDATE=19 then Response.Write "selected"%>>19</OPTION> <OPTION value="20" <%'if LDATE=20 then Response.Write "selected"%>>20</OPTION>
					<OPTION value="21" <%if LDATE=21 then Response.Write "selected"%>>21</OPTION> <OPTION value="22" <%'if LDATE=22 then Response.Write "selected"%>>22</OPTION>
					<OPTION value="23" <%if LDATE=23 then Response.Write "selected"%>>23</OPTION> <OPTION value="24" <%'if LDATE=24 then Response.Write "selected"%>>24</OPTION>
					<OPTION value="25" <%if LDATE=25 then Response.Write "selected"%>>25</OPTION> <OPTION value="26" <%'if LDATE=26 then Response.Write "selected"%>>26</OPTION>
					<OPTION value="27" <%if LDATE=27 then Response.Write "selected"%>>27</OPTION> <OPTION value="28" <%'if LDATE=28 then Response.Write "selected"%>>28</OPTION>
					<OPTION value="29" <%if LDATE=29 then Response.Write "selected"%>>29</OPTION> <OPTION value="30" <%'if LDATE=30 then Response.Write "selected"%>>30</OPTION>
					<OPTION value="31" <%if LDATE=31 then Response.Write "selected"%>>31</OPTION>
				</select>
				<select name="StartYear"  size="1" name="Year" style="HEIGHT: 22px; WIDTH: 55px" >
					<OPTION value="<%=mid(lAccOpenYear,1,4)%>"><%=mid(lAccOpenYear,1,4)%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION>
				</select>
			</TD>
		</TR>
				 <tr>
					 <td colspan=3 valign="center" align=middle class="tdbglight" height="16" width="628">
   						<input type="button" name="sbtViewChrg"   value="Update" onclick=" fn_Go();" >&nbsp;&nbsp;&nbsp;
        				<input type="reset" name="sbtCancel" value="Cancel">
					</td>
				</tr>
	</table>
  </form>
<%else%>
r><br>
<center>
<Table width="40%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>User Bank Details </font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1><%=lResponse%> Click <a href="UbnkUpdateDilogBox.asp">here</a> to back  the previous UpdateDailogBox</font></td>
		</tr>
</Table>
</center>
<br><br><br>
<%end if%>
 <!---#include file="../Includes/footer.inc"---> 
   	
</center>
</body>
</html>





























