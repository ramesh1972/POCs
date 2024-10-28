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
   
   dim ltimestamp 
   dim lldaytype
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
	dim lRandDelay
	
    dim lExecDay
    dim lExecDate
    dim lExecTime
    dim lEntEvent
    dim lEntType
    dim lEntCode
    dim lNxtPhase
    
    dim ltxtTimeOfExec             
    dim ltxtRandDelay              
    dim lselNextSess
    dim lselEventId
    dim OldExecTime
    dim OldSesExecTime
    dim oTimeStamp
    dim readReccont
    dim lTimeStampMod 
    dim Del_lResp
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
  
   set lDMLServerObj = server.CreateObject("MAC.RtcMgr")
 
   lExecDay=Request.QueryString("hExecDay")
   lExecDate=Request.QueryString("hExecDate")
   lExecTime=Request.QueryString("hExecTime")
   lRandDelay =Request.QueryString("hRandDel")             
   lEntEvent=Request.QueryString("hEntEvent")
   lEntType=Request.QueryString("hEntType")
   lEntCode=Request.QueryString("hEntCode")
   lNxtPhase=Request.QueryString("hNxtPhase")
   if (lExecDay<>"") then
    Read_lResp=lDMLServerObj.DoRead("MAS0001000",lExecDate,lExecTime,lEntEvent,lNxtPhase,lExecDay,lEntCode,lEntType,oTimeStamp,readReccont)
   end if
  lRequestTask=Request.Form("lUserType")
  if trim(lRequestTask) = "" then
    lRequestTask="sqlViewAll"
  end if  
   lSqlOperation=Request.Form("hSqlOpern")

   if (lSqlOperation="butUpdate") then
        ltxtDate       =Request.Form("hDateOfExec")
        ltxtTimeOfExec=Request.Form("txtTimeOfExec")             
        ltxtRandDelay =Request.Form("txtRandDelay")             
        lselNextSess=Request.form("selNextSess")
        lselDaytype=mid(Request.Form("hDayType"),3,1)
        lselEntityCode=Request.Form("hEntCode")
        lselEntityType=Request.Form("hEntType")  
        lselEventId=Request.Form("hEventId")
        OldExecTime=Request.Form("hTimeOfExec")
        lTimeStampMod=mid(Request.Form ("hTimeStamp"),3)
        if (Read_lResp=0) then
          ltxtRandDelay="+"&trim(ltxtRandDelay)
          Upd_lResp=lDMLServerObj.DoAction("MAS0001000","U",ltxtDate,lselDaytype,OldExecTime,ltxtRandDelay,lselEventId,lselEntityCode,lselEntityType,lselNextSess,ltxtTimeOfExec,lTimeStampMod)
          Response.Redirect "Ref_Tmr_Resp_Page.asp?hSqlOpern="&lSqlOperation&"&hUpdResponse="&Upd_lResp
         end if
    else if (lSqlOperation="butDelete") then
      if Request.Form("StartMonth")>=10 then
           ltxtDateValue=Request.Form("StartYear")&"-"&Request.Form("StartMonth")&"-"&Request.Form("StartDate")
      else
           ltxtDateValue=Request.Form("StartYear")&"-"&"0"&Request.Form("StartMonth")&"-"&Request.Form("StartDate")
      end if        
        ltxtDate      =Request.Form("hDateOfExec")
        ltxtTimeOfExec=Request.Form("txtTimeOfExec")             
        ltxtRandDelay =Request.Form("txtRandDelay")             
        lselNextSess=Request.form("selNextSess")
        lselDaytype=mid(Request.Form("hDayType"),3,1)
        lselEntityCode=Request.Form("hEntCode")
        lselEntityType=Request.Form("hEntType")  
        lselEventId=Request.Form("hEventId")
        OldExecTime=Request.Form("hTimeOfExec")
        lTimeStampMod=mid(Request.Form ("hTimeStamp"),3)
       Del_lResp=lDMLServerObj.DoAction("MAS0001000","D",ltxtDate,lselDaytype,OldExecTime,ltxtRandDelay,lselEventId,lselEntityCode,lselEntityType,lselNextSess,ltxtTimeOfExec,lTimeStampMod)
       Response.Redirect "Ref_Tmr_Resp_Page.asp?hSqlOpern="&lSqlOperation&"&hDelResponse="&Del_lResp
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
 document.form1.action="Ref_Tmr_Upd_Del.asp";
 document.form1.method="Post";
 document.form1.submit();

}

function SelDayType(val)
{
document.form1.hDaytype.value=val.value;
}
 
function CallBrowse()
{

 document.form1.hidLstatus.value ="B";
 if (document.form1.StartMonth.value <= 9) 
  document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+"0"+document.form1.StartMonth.value+document.form1.StartDate.value;
 else
  document.form1.hidtimeStampBrowse.value=document.form1.StartYear.value+document.form1.StartMonth.value+document.form1.StartDate.value;
 alert('callbrowse');
 alert(document.form1.hidtimeStampBrowse.value);
 document.form1.action="Ref_Tmr_Browse.asp";
 document.form1.method="post";
 alert('before submit');
 document.form1.submit();
}

function SelectDateDisable()
{
if (document.form1.lUserType.value=="sqlUpdate") 
{document.form1.butDelete.disabled=false;document.form1.butUpdate.disabled=true;}
}

function SelectEventCode()
{
alert(document.form1.selEntityType.value)
if ((document.form1.selEntityType.value=="M") || (document.form1.selEntityType.value=="B"))  
  document.form1.selEntityCode.options[1].text="BOOE"
else if (document.form1.selEntityType.value=="C")
  document.form1.selEntityCode.options[1].text=" "
}
function NextPhaseAssign()
{
 if (document.form1.selEventId.value=="ETRD")
    document.form1.selNextSess.options[0].text="ENQR"
 else if (document.form1.selEventId.value=="OPEN")
    document.form1.selNextSess.options[0].text="CTNG"

}

</script>
</head>
<br>
  <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>
<body onload="NextPhaseAssign();">
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
<input type="hidden" name="hidstatus" >
<input type="hidden" name="hidLstatus" >
<input type="hidden" name="hAddResponse" value="<%=Add_lResp%>">
<input type="hidden" name="hUpdResponse" value="<%=Upd_lResp%>">
<input type="hidden" name="hDelResponse" value="<%=Del_lResp%>">

<input type="hidden" name="hTimeOfExec" value=<%=Request.QueryString("hExecTime")%>>
<input type="hidden" name="hDateOfExec" value=<%=lExecDate%>>
<input type="hidden" name="hDayType" value=<%=lExecDay%>>
<input type="hidden" name="hEntType" value=<%=lEntType%>>
<input type="hidden" name="hEntCode" value=<%=lEntCode%>>
<input type="hidden" name="hEventId" value=<%=lEntEvent%>>
<input type="hidden" name="hTimeStamp" value=<%=oTimeStamp%>>

<table width="70%" border="1"  cellpadding=1 cellspacing=1 align=center height="5%">
<tr class="tdbgdark">
  <td align=center colspan=5 class="whiteboldtext1"> Reference Timer Control </td>
</tr>
<%
if (lRequestTask="sqlView" or lRequestTask="sqlUpdate" or lRequestTask="sqlViewAll") then
%>
<table width="70%" border="1"  cellpadding=1 cellspacing=1 align=center height="20%">
<%end if %>
  <TD class=tdbglight align=Left><font class=blacktext>Date(yy/mm/dd) </font></TD>
  <td  class=tdbglight align=left><input disabled type=text size=13 name="txtDate" value="<%=lExecDate%>"></td>
 </tr>
<tr class="tdbgdark" height="20%">
 <TD class=tdbglight align=left><font class=blacktext>Time Of Execution </font></TD>
 <td  class=tdbglight align=left><input type=text size=10 name="txtTimeOfExec" value="<%=lExecTime%>"></td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Day Type </font></TD>
<td  class=tdbglight align=left>
  <select name="selDaytype" disabled onchange="SelDayType(this);"> 
     <option <%if lExecDay="O" then Response.Write("selected")%> value="O">Working Day</option>
     <option <%if lExecDay="W" then Response.Write("selected")%> value="W">Weekly Off</option>
     <option <%if lExecDay="N" or lldaytype="R" then Response.Write("selected")%> value="N">Holiday</option>
     <option <%if lExecDay="H" then Response.Write("selected")%>  value="H">Half Working Day</option>
   </select>         
</td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Random Delay </font></TD>
 <td  class=tdbglight>
  <input type=text size=10 name="txtRandDelay" value="<%=lRandDelay%>"></td>
 </td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Entity Type/Code </font></TD>
 <td class=tdbglight align=left>
 <select name="selEntityType" disabled onchange="SelectEventCode();">
   <option <%if lEntType="M" then Response.Write("selected")%> value="M">Market </option>
   <option <%if lEntType="B" then Response.Write("selected")%> value="B">Basket </option>
   <option <%if lEntType="C" then Response.Write("selected")%> value="C">Contract </option>
   </select>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

  <select name="selEntityCode" disabled>
   <option value="<%=lEntCode%>" disabled selected=true><%=lEntCode%> </option>
  </select>
  </td>
</tr>
<tr>
<TD class=tdbglight align=left><font class=blacktext>Event Id </font></TD>
 <td valign=center class=tdbglight align=left>
  <select name="selEventId" disabled>
   <option value=<%=lEntEvent%>><%=lEntEvent%> </option>
   </select>
&nbsp;&nbsp;&nbsp;&nbsp;

<font class=blacktext>Next Session </font>
<select name="selNextSess">
  <option value="ENQR" selected> </option>
 </select>
</td>
</tr>
<tr> 
 <td align=center class=tdbglight colspan=5>
   <input type=button name="butUpdate" value="Update" onclick="Assign(this);document.form1.butUpdate.disabled=true;document.form1.butDelete.disabled=false;">
   <input type=button name="butDelete" value="Delete" onclick="document.form1.butDelete.disabled=true;document.form1.butUpdate.disabled=false;Assign(this);">
   <input type=button name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Browse.asp'">
</td>   
</tr>
</table>
</table>
</form>
<br>
	<!---#include file="../includes/footer.inc"--->
</body>
</html>


