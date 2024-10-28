<%@ Language=VBScript %>

<%  
' option explicit
   Response.Buffer=true
    
   dim lRequestTask
  
   'For SQL Operation
   
   dim lDMLServerObj
   dim lSqlOperation
   dim ltxtDatevalue
   dim lResp
   dim ldate
   dim lDayType
   
   dim lldate
   dim ltimestamp 
   dim lldaytype
   dim leom
   dim leow
   dim lweekno
   dim llen
   dim lUpdTimestamp
   dim lStatus
   dim lRandDelay_1
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
	dim vvv
  '========
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR = YEAR(CURRENTDATE)
	LYEAR1 = LYEAR+1
	lYearCurrent  = LYEAR
	lYearPrev	= LYEAR - 1
	lYearNext   = LYEAR + 1
  '=========
  lRequestTask=Request.Form("lUserType")
  if trim(lRequestTask) = "" then
    lRequestTask="sqlViewAll"
  end if  
   set lDMLServerObj = server.CreateObject("MAC.RtcMgr")
   lSqlOperation=Request.Form("hSqlOpern")
   if (lSqlOperation="butAdd") then
     Response.Write "enter into add"
     ltxtDatevalue=Request.Form ("StartYear")+"-"+Request.Form ("StartMonth")+"-"+Request.Form ("StartDate")
     lDayType     =Request.Form("selDaytype")
     lTimeofExec  =Request.Form ("txtTimeOfExec")
     lRandDelay   =Request.Form ("txtRandDelay")
     lEntityType  =Request.Form ("selEntityType")
     lEntityCode  =Request.Form ("selEntityCode")
     lEventId     =Request.Form ("selEventId")
     lNextSess    =Request.Form ("txtNextSess")
     
     Response.Write "lDayType="&lDayType&"lTimeofExec="&lTimeofExec&"lRandDelay="&lRandDelay&"lEntityType="&lEntityType&"lEntityCode="&lEntityCode&"lEventId="&lEventId&"lNextSess="&lNextSess
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
       lRandDelay_1=mid(lRandDelay,1,1)
       if (lRandDelay_1<>"+") then
          lRandDelay="+"+lRandDelay
       end if   
       Response.Write "<br>"&"lRandDelay="&lRandDelay&"<br>"
       Response.Write " ltxtDateValue="&ltxtDateValue&" lDayType="&lDayType&" lTimeofExec="&lTimeofExec&" lRandDelay="&lRandDelay&" lEventId="&lEventId&" lEntityCode="&lEntityCode&" lEntityType="&lEntityType&" lNextSess="&lNextSess&" lTimeofExec="&lTimeofExec
       Add_lResp =lDMLServerObj.DoAction("MAS0001000", "A",ltxtDateValue,lDayType,lTimeofExec,lRandDelay,lEventId, lEntityCode, lEntityType,lNextSess,lTimeofExec, " ")
       Response.Write "add="&lResp
       Response.Redirect "Ref_Tmr_Resp_Page.asp?hSqlOpern="&lSqlOperation&"&hAddResponse="&Add_lResp
   else if (lSqlOperation="butUpdate") then
       lUpdTimestamp=Request.Form("htimestamp")
       Response.Redirect "Ref_Tmr_Main.asp?hSqlOpern="&lSqlOperation&"&hUpdResponse="&Upd_lResp
   else if (lSqlOperation="butView") then
      if Request.Form("StartMonth")>=10 then
           ltxtDateValue=Request.Form("StartYear")&"-"&Request.Form("StartMonth")&"-"&Request.Form("StartDate")
      else
           ltxtDateValue=Request.Form("StartYear")&"-"&"0"&Request.Form("StartMonth")&"-"&Request.Form("StartDate")
      end if        
      
  end if  
  end if
  end if
%>

<html>
<link rel="Stylesheet" Content="contemporary" href="../includes/Theme.css">
<head>
<script>

function Assign(task)
{
 document.form1.hSqlOpern.value=task.name;
 document.form1.action="Ref_Tmr_Main.asp";
 document.form1.submit();
}

function SelDayTypeFun(val)
{
document.form1.hDaytype.value=val.value;
}
 
function CallBrowse(task)
{
 if (task.name=="butViewAll" )
     document.form1.hidLstatus.value ="V";
 else if (task.name=="butBrowse" )
    document.form1.hidLstatus.value ="B";
  
 document.form1.hidEventTime.value =document.form1.txtEventTime.value;
 document.form1.hidEventId.value =document.form1.selEventId.value;
 document.form1.hidDayType.value=document.form1.selDaytype1.value;
 document.form1.hidEntityType.value=document.form1.selEntityType.value;
 document.form1.hidEntityCode.value=document.form1.selEntityCode.value; 
 if (document.form1.StartMonth.value <= 9) 
 {
  if (document.form1.StartDate.value <= 9) 
    document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+"0"+document.form1.StartMonth.value+"0"+document.form1.StartDate.value;
  else
    document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+"0"+document.form1.StartMonth.value+document.form1.StartDate.value;
 }
 else
 {
  if (document.form1.StartDate.value <= 9) 
    document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+document.form1.StartMonth.value+"0"+document.form1.StartDate.value;
  else
    document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+document.form1.StartMonth.value+document.form1.StartDate.value;
  } 
 document.form1.action="Ref_Tmr_Browse.asp";
 document.form1.method="post";
 document.form1.submit();
}

function SelectDateDisable()
{
if (document.form1.lUserType.value=="sqlUpdate") 
{document.form1.butView.disabled=false;document.form1.butUpdate.disabled=true;}
}

function SelectEventCode()
{
if ((document.form1.selEventId.value =="BDAY")  ||(document.form1.selEventId.value =="CLSE")
  ||(document.form1.selEventId.value =="ETRD")|| (document.form1.selEventId.value =="HALT")
    ||(document.form1.selEventId.value =="EDAY"))   
    {
      document.form1.txtNextSess.value="ENQR"
     }
 else if (document.form1.selEventId.value =="OPEN")
   {
      document.form1.txtNextSess.value="CTNG"
   }
if ((document.form1.selEntityType.value=="M") || (document.form1.selEntityType.value=="B"))  
  document.form1.selEntityCode.options[1].text="BOOE"
else if (document.form1.selEntityType.value=="C")
  document.form1.selEntityCode.options[1].text=" "
  
if (document.form1.selEntityType.value=="M")
 {
   document.form1.selEventId.length=5;   
   document.form1.selEventId.options[1].text="BDAY";
   document.form1.selEventId.options[2].text="ETRD";
   document.form1.selEventId.options[3].text="HALT";
   document.form1.selEventId.options[4].text="EDAY";
   
 }
else if  (document.form1.selEntityType.value=="B")
{
  document.form1.selEventId.length=7;   
  document.form1.selEventId.options[1].text="BDAY";
  document.form1.selEventId.options[2].text="ETRD";
  document.form1.selEventId.options[3].text="HALT";
  document.form1.selEventId.options[4].text="EDAY";
  document.form1.selEventId.options[5].text="OPEN";
  document.form1.selEventId.options[6].text="CLSE";
  document.form1.selEventId.options[5].value="OPEN";
  document.form1.selEventId.options[6].value="CLSE";
 }   
}
</script>
</head>
<br>
  <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>
<body>
<form name=form1 method=post> 
<input type=hidden name=hDaytype>

<input type=hidden name=hSqlOpern>
<input type=hidden name=htxtdate>
<input type=hidden name=htxteow>
<input type=hidden name=htxteom>
<input type=hidden name=htxtweeknumber>
<input type=hidden name=hUDate value=<%=ltxtDateValue%>>
<input type=hidden name=htimestamp value="<%=ltimestamp%>">
<input type=hidden name=lUserType value="<%=lRequestTask%>">
<input type="hidden" name="hidtimeStampBrowse"> 
<input type="hidden" name="hidEventTime">
<input type="hidden" name="hidEventId">
<input type="hidden" name="hidDayType">
<input type="hidden" name="hidEntityType">
<input type="hidden" name="hidEntityCode">

<input type="hidden" name="hidstatus" >
<input type="hidden" name="hidLstatus" >
<input type="hidden" name="hAddResponse" value="<%=Add_lResp%>">
<input type="hidden" name="hUpdResponse" value="<%=Upd_lResp%>">
<%
IF lRequestTask <>"sqlView" and lRequestTask <>"sqlUpdate" and lRequestTask<>"sqlViewAll" then %>
<table width="70%" border="1"  cellpadding=1 cellspacing=1 align=center height="40%">
<tr class="tdbgdark">
  <td align=center colspan=5 class="whiteboldtext1"> Reference Timer Control </td>
</tr>
<%end if%>

<%
if (lRequestTask="sqlView" or lRequestTask="sqlUpdate" or lRequestTask="sqlViewAll") then
%>
<table width="40%" border="0"  cellpadding=1 cellspacing=1 align=center>
<% if (lRequestTask="sqlViewAll") then %>
<tr>
  <td width=40% align=center colspan=5 class="blackboldtext1"> Reference Timer Control </td>
</tr>
</table>

<table align=center border=2 width=60%>
<tr>
			<td  class=tdbglight>
				<font class=blacktext>Date</font>
			</TD>
    		<TD CLASS=tdbglight> 
				<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px" onchange="SelectDateDisable();">
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
				<select name="StartYear" onchange="SelectDateDisable();">
    			<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION> 
				</select>
			</TD>
</TR>
<tr height=5 align="center" class=tdbglight> 
 <td class=tdbglight align=left><font class=blacktext>Time </font></td>   
 <td class=tdbglight align=left><input type=text size=10 name=txtEventTime></td>
</tr>
<tr height=20 align="center"> 
<td class=tdbglight align=left><font class=blacktext>Event</font></td>
 <td class=tdbglight align=left>
 <select name="selEventId">
   <option value="Empty" selected> -  Select  -- </option>
   <option value="BDAY">BDAY </option>
   <option value="OPEN">OPEN </option>
   <option value="ETRD">ETRD </option>
   <option value="HALT">HALT </option>
   <option value="CLSE">CLSE </option>
   <option value="EDAY">EDAY </option>
   </select>
 </td>   
</tr>
<tr height=20 align="center"> 
<td class=tdbglight align=left><font class=blacktext>Day Type</font></td>
 <td class=tdbglight align=left>
 <select name="selDaytype1" onchange="SelDayTypeFun(this);"> 
    <option value="Empty" selected> -  Select  -- </option>
     <option <%if lldaytype="O" then Response.Write("selected")%> value="O">Working Day</option>
     <option <%if lldaytype="H" then Response.Write("selected")%>  value="H">Half Working Day</option>
 </select>         

</td>   
</tr>
<tr height=20 align="center"> 
<TD class=tdbglight align=left><font class=blacktext>Entity Type/Code </font></TD>
<!-- <td valign=center class=tdbglight align=left><input type=text size=3 name="txtWeekNumber" value="<%=lweekno%>"></td>-->
 <td class=tdbglight align=left>
 <select name="selEntityType" onchange="SelectEventCode();">
   <option value="Empty" selected> -Select- </option>
   <option value="M">Market </option>
   <option value="B">Basket </option>
   <option value="C">Contract </option>
   </select>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

  <select name="selEntityCode">
   <option value="Empty" selected> -Select- </option>
   <option value="BOOE" selected=false></option>
  </select>
  </td>
</tr>
</table>
<%end if%>
<!--<br>-->
<table width="80%" border="1"  cellpadding=1 cellspacing=1 align=center height="20%">
<%end if %>
<% if lRequestTask <>"sqlViewAll" then%>
<tr class="tdbgdark" height="20%">
<%if lRequestTask ="sqlAdd" then  %>
<TD class=tdbglight align=Left><font class=blacktext>Date of Execution</font></TD>
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
                  <select size="1" name="StartDate">
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
				<select name="StartYear">
    			<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION> 
				</select>
</td>				
<%else%>
  <TD class=tdbglight align=Left><font class=blacktext>Date(yy/mm/dd) </font></TD>
  <td  class=tdbglight align=left><input type=text size=13 name="txtDate" value="<%=lldate%>"></td>
 <%end if%> 
 </tr>
<tr class="tdbgdark" height="20%">
 <TD class=tdbglight align=left><font class=blacktext>Time Of Execution <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   &nbsp;&nbsp;&nbsp;&nbsp;(00:00:00)</font></TD>
 <td  class=tdbglight align=left><input type=text size=10 name="txtTimeOfExec" value="<%=leow%>"></td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Day Type </font></TD>
 <td  class=tdbglight align=left>
    <select name="selDaytype" onchange="SelDayTypeFun(this);"> 
     <option <%if lldaytype="O" then Response.Write("selected")%> value="O">Working Day</option>
     <option <%if lldaytype="H" then Response.Write("selected")%>  value="H">Half Working Day</option>
   </select>         
</td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Random Delay <br>&nbsp;&nbsp;&nbsp;(+00:00.00)</font></TD>
 <td  class=tdbglight>
  <input type=text size=10 name="txtRandDelay" value="<%=leom%>"></td>
 </td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Entity Type/Code </font></TD>
<!-- <td valign=center class=tdbglight align=left><input type=text size=3 name="txtWeekNumber" value="<%=lweekno%>"></td>-->
 <td class=tdbglight align=left>
 <select name="selEntityType" onchange="SelectEventCode();">
   <option value="Empty" selected> -Select- </option>
   <option value="M">Market </option>
   <option value="B">Basket </option>
   <option value="C">Contract </option>
   </select>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

  <select name="selEntityCode">
   <option value="Empty" selected> -Select- </option>
   <option value="BOOE" selected=false></option>
  </select>
  </td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Event Id </font></TD>
 <td valign=center class=tdbglight align=left>
  <select name="selEventId" onchange="SelectEventCode();">
   <option value="Empty" selected> -  Select  -- </option>
   <option value="BDAY"> </option>
   <option value="ETRD"> </option>
   <option value="HALT"> </option>
   <option value="EDAY"> </option>
   <option value="OPEN"> </option>
   <option value="CLSE"> </option> 
   </select>
&nbsp;&nbsp;&nbsp;&nbsp;
<font class=blacktext>Next Session </font>
 <input type=text name="txtNextSess" size=10>
</td>
</tr>
<%end if %>
<% if lRequestTask="sqlAdd" then
 %>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butAdd" value="Add" onclick="Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Menu.asp'">
</td>   
</tr>
<% else if lRequestTask="sqlUpdate" then
%>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butUpdate" value="Update" onclick="Assign(this);">
   <input type=button name="butView" value="View" onclick="Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Menu.asp'">
</td>   
</tr>
<% else if lRequestTask="sqlView" then
%>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butView" value="View" onclick="Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Menu.asp'">
</td>   
</tr>
<% else if lRequestTask="sqlViewAll" then
%>
<table align=center border=2>
<tr height=30 align="center"> 
 <td class=tdbglight>
   <input type=button name="butViewAll" value="View All" onclick="CallBrowse(this);">
   <input type=button name="butBrowse" value="Submit" onclick="CallBrowse(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Menu.asp'">
</td>   
</tr>
</table>
<% else %>
<%
  if  lRequestTask="sqlView" then %>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butView" value="View">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Menu.asp'">
</td>   
</tr>
<%else%>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butUpdate" value="Update" onclick="Assign(this);">
   <input type=button name="butView" value="View" onclick="Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Menu.asp'">
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
</form>
<br>
	<!---#include file="../includes/footer.inc"--->
</body>
</html>

