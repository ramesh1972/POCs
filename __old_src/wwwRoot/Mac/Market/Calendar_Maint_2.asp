 <%@ Language=VBScript %>

<%  
' option explicit
   Response.Buffer=true
    
   dim lRequestTask
   dim result
   dim MySelf
   dim MyServer
   dim lDMLServerObj1
  
   'For SQL Operation
   
   dim lDMLServerObj
   dim lSelServerObj
   dim lLatestRS
   dim lSqlOperation
   dim ltxtDatevalue
   dim lResp
   dim lGivendate
   dim lTodaydate
   dim ldate
   dim lDayType
   
   dim lldate
   dim ltimestamp 
   dim lldaytype
   dim lholidayz
   dim leom
   dim  leow
   dim lweekno
   dim llen
   dim  lval
   dim lUpdDate
   dim lUpdEOW
   dim lUpdEOM
   dim lUpdWN
   dim lUpdDayType
   dim lUpdTimestamp
   dim lRecCount
   dim strResponse  
   dim lStatus
 '**
	dim StartMonth
	dim StartDate
	dim startYear
	dim CURRENTDATE
	dim lYearPrev
	dim lYearCurrent
	dim lYearNext
	dim LMONTH
	dim LYEAR
	dim LYEAR1
	dim i
	dim Add_lResp
	dim Upd_lResp
  '========
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR = YEAR(CURRENTDATE)
	LYEAR1 = LYEAR+1
	lYearCurrent  = LYEAR
	lYearPrev	= LYEAR - 1
	lYearNext   = LYEAR + 1
	lYearNext1  = LYEAR + 2
  '=========
   lRequestTask=Request.Form("lUserType")
  if trim(lRequestTask) = "" then
    lRequestTask="sqlViewAll"
  end if  
'  if Request.Form("hResPageCode")="butAdd" then
 '   lRequestTask="sqlAdd" 
 ' else if  Request.Form("hResPageCode")="butUpdate" then
 '   lRequestTask="sqlUpdate" 
 ' end if
  'end if   
   'For SQL Operation
'   Add_lResp=1   
 '  Upd_lResp=1
'   set lDMLServerObj = server.CreateObject("Project1.CalendarMgr")
   set lDMLServerObj = server.CreateObject("MAC.CalendarMgr")
   lSqlOperation=Request.Form("hSqlOpern")
   if (lSqlOperation="butAdd") then
     ltxtDatevalue=Request.Form ("StartYear")+"-"+Request.Form ("StartMonth")+"-"+Request.Form ("StartDate")
     lDayType     =Request.Form("selDaytype")
     lGivendate=datevalue(ltxtDatevalue)
     if ( (Month(datevalue(ltxtDateValue)) <> 11) and (Month(datevalue(ltxtDateValue)) <>12)) then
        if (day(ltxtDateValue)<10) then
          ltxtDateValue=Year(ltxtDateValue)&"-"&"0"&month(ltxtDateValue)&"-"&"0"&day(ltxtDateValue)
        else  
          ltxtDateValue=Year(ltxtDateValue)&"-"&"0"&month(ltxtDateValue)&"-"&day(ltxtDateValue)
        end if
     else
     if (day(ltxtDateValue)>9) then
        ltxtDateValue=Year(ltxtDateValue)&"-"&month(ltxtDateValue)&"-"&day(ltxtDateValue)
     else
        ltxtDateValue=Year(ltxtDateValue)&"-"&month(ltxtDateValue)&"-"&"0"&day(ltxtDateValue)
     end if
    end if  
    lTodaydate=date()
    'if (lGivendate > lTodaydate) then
      Add_lResp = lDMLServerObj.DoAddDate(ltxtDateValue, " ", "lDayType", " ", " ", " ", 0, 0, " ")
      Response.Redirect "Calendar_Resp_Page.asp?hSqlOpern="&lSqlOperation&"&hAddResponse="&Add_lResp
'     end if     
   else if (lSqlOperation="butUpdate") then
      lResp = lDMLServerObj.DoReadDate(Request.Form("hUDate"), " ", "W", " ", "N", "N", 0, 0, " ", lldate, ltimestamp, lldaytype, lholidayz, leom, leow, lweekno, llen, lval)
      lUpdTimestamp=Request.Form("htimestamp")
      Upd_lResp=lDMLServerObj.DoUpdateDate(lldate,lUpdTimestamp,Request.Form("selDaytype")," ",leom,leow,clng(lweekno),0,"" )
      Response.Redirect "Calendar_Resp_Page.asp?hSqlOpern="&lSqlOperation&"&hUpdResponse="&Upd_lResp
   else if (lSqlOperation="butView") then
      if Request.Form("StartMonth")>=10 then
           ltxtDateValue=Request.Form("StartYear")&"-"&Request.Form("StartMonth")&"-"&Request.Form("StartDate")
      else
           ltxtDateValue=Request.Form("StartYear")&"-"&"0"&Request.Form("StartMonth")&"-"&Request.Form("StartDate")
      end if        
       'Response.Write "ltxtDateValue="&ltxtDateValue       
      lResp = lDMLServerObj.DoReadDate(ltxtDateValue, " ", "W", " ", "N", "N", 0, 0, " ", lldate, ltimestamp, lldaytype, lholidayz, leom, leow, lweekno, llen, lval)
  end if  
  end if
  end if
%>

<HTML>
	<HEAD>
		<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
	</style>
	<BR>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
	</HEAD>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
<br>
<script>

function Assign(task)
{
 document.form1.hSqlOpern.value=task.name;
 document.form1.action="Calendar_Maint_2.asp"
 document.form1.submit();
}

 function AddDisable()
 { 
 //document.form1.txtEndOfMonth.disabled=true;
 //document.form1.txtEndOfWeek.disabled=true;
 //document.form1.txtWeekNumber.disabled=true;
 } 
 
function ViewDisable()
 {
 document.form1.txtDate.disabled=true;
 //document.form1.txtEndOfMonth.disabled=true;
 //document.form1.txtEndOfWeek.disabled=true;
 //document.form1.txtWeekNumber.disabled=true;
 document.form1.selDaytype.disabled=true;
 }
 
function UpdateDisable()
{ 
 document.form1.butUpdate.disabled=true; 
 document.form1.txtDate.disabled=true;
 //document.form1.txtEndOfMonth.disabled=true;
 //document.form1.txtEndOfWeek.disabled=true;
 //document.form1.txtWeekNumber.disabled=true;
}

function CallBrowse()
{
 document.form1.hidLstatus.value ="B";
 if (document.form1.StartMonth.value <= 9) 
  document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+"0"+document.form1.StartMonth.value+document.form1.StartDate.value;
 else
  document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+document.form1.StartMonth.value+document.form1.StartDate.value;
  document.form1.action="Calendar_Browse.asp";
  document.form1.method="post";
  document.form1.submit();
}

function SelectDateDisable()
{
if (document.form1.lUserType.value=="sqlUpdate") 
{document.form1.butView.disabled=false;document.form1.butUpdate.disabled=true;}

}

<!--#include file="../includes/DateValid.inc"-->

/*function DateValidation(MonthValue,DateValue)
{
 
 if (MonthValue==4 || MonthValue==6 || MonthValue==9 || MonthValue==11)
 {
   if (DateValue>30)
     alert('Please Select Below 31st');
  }   
}

function LeapYearValidation(YearValue,DateValue,MonthValue)
{
if (YearValue % 4 ==0 && MonthValue==2)
 {
   if (DateValue > 29 )
     {
     alert ('Please Select Below 29th');
     return false;
     }
 }
 else if (YearValue % 4 !=0 && MonthValue==2)
 {
    if (DateValue > 28)
		{
         alert ('Please Select Below 28th');
         alert('hi');
         return false;
         }
  }
 return true;
}*/
</script>
</head>
<% if lRequestTask="sqlAdd" then
%>
 <BODY onload="AddDisable()"> 
 <%else if lRequestTask="sqlView" then%>
 <BODY onload="ViewDisable()">
 <%else if lRequestTask="sqlUpdate" then %>
  <BODY onload="UpdateDisable()">
 <%else%>
<body>
<%end if%>
<%end if
  end if
%>

<form name=form1 method=post> 
<input type=hidden name=hSqlOpern>
<input type=hidden name=htxtdate>
<input type=hidden name=htxteow>
<input type=hidden name=htxteom>
<input type=hidden name=htxtdaytype>
<input type=hidden name=htxtweeknumber>
<input type=hidden name=hUDate value=<%=ltxtDateValue%>>
<input type=hidden name=htimestamp value="<%=ltimestamp%>">
<input type=hidden name=lUserType value="<%=lRequestTask%>">
<input type="hidden" name="hidtimeStampBrowse"> 
<input type="hidden" name="hidstatus" >
<input type="hidden" name="hidLstatus" >
<input type="hidden" name="hAddResponse" value="<%=Add_lResp%>">
<input type="hidden" name="hUpdResponse" value="<%=Upd_lResp%>">
<%
IF lRequestTask <>"sqlView" and lRequestTask <>"sqlUpdate" and lRequestTask<>"sqlViewAll" then %>
<table width="70%" border="1"  cellpadding=1 cellspacing=1 align=center height="30%">
<tr class="tdbgdark">
  <td align=center colspan=5 class="whiteboldtext1"> Calendar Maintenance </td>
</tr>
<%end if%>

<%
if (lRequestTask="sqlView" or lRequestTask="sqlUpdate" or lRequestTask="sqlViewAll") then
'if (lRequestTask="sqlViewAll") then
%>
<table width="40%" border="0"  cellpadding=1 cellspacing=1 align=center>
<% if (lRequestTask="sqlViewAll") then %>
<!-- <tr class="tdbgdark">-->
<tr>
  <td align=center colspan=5 class="blackboldtext1"> Calendar Maintenance </td>
</tr>
<%end if%>
</table>
<table align=center border=4>
<tr>
			<td  class=tdbglight colspan=4>
				<font class=blacktext>Please Select the Date</font>
			</TD>
    		<TD WIDTH="200" CLASS=tdbglight height="10" > 
				<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px" onchange="SelectDateDisable();">
<!--				<select size="1" name="StartMonth"> -->
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
<!--				<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" >-->
                  <select size="1" name="StartDate" onchange="SelectDateDisable();">
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
				</select>&nbsp;
<!--				<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >-->
				<select name="StartYear" onchange="SelectDateDisable();">
    			<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION> 
					<OPTION value="<%=lYearNext1%>" ><%=lYearNext1%></OPTION> 
				
				</select>
			</TD>
</TR>
</table>
<br>
<table width="60%" border="1"  cellpadding=1 cellspacing=1 align=center height="20%">
<%end if %>
<% if lRequestTask <>"sqlViewAll" then%>
<tr class="tdbgdark" height="15%">
<%if lRequestTask ="sqlAdd" then  %>
<TD class=tdbglight align=Left><font class=blacktext>Date </font></TD>
    		<TD CLASS=tdbglight>
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
<!--				<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" >-->
                  <select size="1" name="StartDate" onchange="DateValidation(document.form1.StartMonth.value,this.value);")>
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
				</select>&nbsp;
<!--				<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >-->
				<select name="StartYear" onchange="return LeapYearValidation(document.form1.StartYear.value,document.form1.StartDate.value,document.form1.StartMonth.value)">
    			<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION> 
					<OPTION value="<%=lYearNext1%>" ><%=lYearNext1%></OPTION> 
				</select>
</td>				
<%else%>
  <TD class=tdbglight align=Left><font class=blacktext>Date(yy/mm/dd) </font></TD>
  <td  class=tdbglight align=left><input type=text size=13 name="txtDate" value="<%=lldate%>"></td>
 <%end if%> 
 </tr>
<!--<tr class="tdbgdark" height="20%">
 <TD class=tdbglight align=left><font class=blacktext>End of Week </font></TD>
 <td  class=tdbglight align=left><input type=text size=3 name="txtEndOfWeek" value="<%=leow%>"></td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>End of Month </font></TD>
 <td  class=tdbglight align=left><input type=text size=3 name="txtEndOfMonth" value="<%=leom%>"></td>
</tr>-->
<tr height=15%>
<TD class=tdbglight align=left><font class=blacktext>Type of Day </font></TD>
 <td  class=tdbglight>
   <select name="selDaytype" onchange="document.form1.butView.disabled=true;document.form1.butUpdate.disabled=false;">
     <option <%if lldaytype="O" then Response.Write("selected")%> value="O">Working Day </option>
     <option <%if lldaytype="W" then Response.Write("selected")%> value="W">Weekly Off </option>
     <option <%if lldaytype="N" or lldaytype="R" then Response.Write("selected")%> value="N">Holiday </option>
     <option <%if lldaytype="H" then Response.Write("selected")%>  value="H">Half Working Day </option>
     </select>         
 </td>
</tr>
<!--<tr>
<TD class=tdbglight align=left><font class=blacktext>Week Number </font></TD>
 <td valign=center class=tdbglight align=left><input type=text size=3 name="txtWeekNumber" value="<%=lweekno%>"></td>
</tr>-->
<%end if %>
<% if lRequestTask="sqlAdd" then
 %>
<tr height=26%> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butAdd" value="Add" onclick="Assign(this);">
   <!-- alert('add='+document.form1.hAddResponse.value);window.location.href='Calendar_Resp_Page.asp'"> -->
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='CalMenu.asp'">
</td>   
</tr>
<% else if lRequestTask="sqlUpdate" then
%>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butUpdate" value="Update" onclick="Assign(this);">
   <input type=button name="butView" value="View" onclick="Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='CalMenu.asp'">
</td>   
</tr>
<% else if lRequestTask="sqlView" then
%>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butView" value="View" onclick="Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='CalMenu.asp'">
</td>   
</tr>
<% else if lRequestTask="sqlViewAll" then
%>
<table align=center border=2>
<tr height=30 align="center"> 
 <td class=tdbglight>
   <input type=button name="butBrowse" value="Submit" onclick="CallBrowse();">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='CalMenu.asp'">
  
<!--   <input type=button name="butCancel" value="Cancel" onclick="window.location.href='CalMenu.asp'">-->
</td>   
</tr>
</table>
<% else %>
<%'Response.Write "mid="& Mid(lval,21,6)&"<br>"
  'Response.Write "req="&Request.Form("lUserType")
  if  lRequestTask="sqlView" then %>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butView" value="View">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='CalMenu.asp'">
</td>   
</tr>
<%else%>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butUpdate" value="Update" onclick="Assign(this);">
   <input type=button name="butView" value="View" onclick="Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='CalMenu.asp'">
</td>   
</tr>

<%end if
  end if 
  end if 
  end if
  end if
%>
</table>
</table>
<br>
<!---#include file="../includes/footer.inc"--->
</form>
</body>
</html>

