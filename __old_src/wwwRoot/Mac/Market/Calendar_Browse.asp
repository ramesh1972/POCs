<%option explicit
   
    dim lDMLServerObj

    '*** Browse
    
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
	dim LDATE
	
	dim lStatus
	dim butAction
	dim lRequestTask
	dim ss
	dim lStartDate
	dim strresponse
	dim lRecCount
	dim lResp
	dim lPageCount

	'*******
	CURRENTDATE=NOW()
	LMONTH= MONTH(CURRENTDATE)
	LDATE=DAY(CURRENTDATE)
	LYEAR = YEAR(CURRENTDATE)
	LYEAR1 = LYEAR+1
	lYearCurrent  = LYEAR
	lYearPrev	= LYEAR - 1
	lYearNext   = LYEAR + 1
   '******
   	'*** Time Stamp Checking ********
	dim gTimeStamp
	dim gTimeStampPrev
	dim gTimeStampNext
    dim gTimeStampBrowse
	dim Bstatus
    lStatus=Request.Form("hidLstatus")
    if (lStatus="B")then
	gTimeStampBrowse=Request.Form("hidtimeStampBrowse")
	else if (lStatus="N") then
	gTimeStampBrowse=Request.Form("hidtimeStamp")
	else if (lStatus="P") then
		gTimeStampBrowse=Request.Form("hidtimeStampPrev")
    end if
    end if
    end if		
    if (lStatus="B")then
    if len(gTimeStampBrowse) =8 then
     gTimeStampBrowse=mid(gTimeStampBrowse,1,4)+"-"+mid(gTimeStampBrowse,5,2)+"-"+mid(gTimeStampBrowse,7,2)
    else
     gTimeStampBrowse=mid(gTimeStampBrowse,1,4)+"-"+mid(gTimeStampBrowse,5,2)+"-"+mid(gTimeStampBrowse,7,1)
    end if
   end if    
   gTimeStampBrowse=Year(gTimeStampBrowse)&"-"&month(gTimeStampBrowse)&"-"&(day(gTimeStampBrowse))
   if Request.Form("hidstatus") ="" then
        Bstatus = "E"
        lStatus="B"
	else
		Bstatus = Request.Form("hidstatus")
	end if 
    butAction=gTimeStampBrowse
    'set lDMLServerObj = server.CreateObject("Project1.CalendarMgr")
    set lDMLServerObj = server.CreateObject("MAC.CalendarMgr")
    lResp=lDMLServerObj.DoBrowseDate(Bstatus,butAction,"" ,butAction,strResponse,lRecCount)
     if (lResp=0) then
      if Request.Form("hPageCount")="" then
        lPageCount=1
      else 
       if lStatus="N" then
         lPageCount=cint(Request.Form("hPageCount"))+1
       else if lStatus="P" then
         lPageCount=cint(Request.Form("hPageCount"))-1
       end if
       end if
      end if   
     end if 
     Dim strLn  'used for finding the line
  	 Dim strFld 'Used for finding the Columns
	 strLn = Split(strResponse,"$") 'here EOL is used to find the End Of File(VbCrlf)
     Dim FstPpPos  'used to find the First Pipe Character Position
   	 FstPpPos = InStr(1,strResponse, "|")
     Dim fstPpChar 'is used to find the character between start and Fist Character
	
	 fstPpChar = Mid(strResponse,1, FstPpPos - 1)
%>
	
<html>
<link rel="Stylesheet" Content="contemporary" href="../includes/theme.css">

<head>
<script>
function funprevious()
{
 document.form1.hidLstatus.value ="P";
 document.form1.hidstatus.value ="E";
 document.form1.method="post";
 document.form1.action="Calendar_Browse.asp";
 document.form1.submit();

}
function funNext()
{
if (document.form1.hPageCount.value > 1 )
  document.form1.subprevious.disabled=false;
document.form1.hidLstatus.value ="N";
document.form1.hidstatus.value ="T";
document.form1.method="post";
document.form1.action="Calendar_Browse.asp";
document.form1.submit();

}
function PrevButDisable()
{

if (document.form1.hPageCount.value == 1 )
  document.form1.subprevious.disabled=true;
if (document.form1.hRecCount.value !=14)
 document.form1.subNext.disabled=true;

}
</script>

<body onload="PrevButDisable();">

<br>
<!---#include file="../includes/header.inc"--->
<br>
<!---#include file="../includes/MACLinks.inc"--->
<br>
<table width="40%" border="0"  cellpadding=1 cellspacing=1 align=center>

<tr>
<!-- class="tdbglight">-->
  <td align=center colspan=5 class="blackboldtext1"> Calendar Maintenance </td>
</tr>
</table>
<br>
	<table border=0 width="100%" align = center >
		<TR>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Date</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Day</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Week Number</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Type of Day</font></th>
<!--			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Holiday Zones</font></th>-->
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>End Of Month</font></th>
			<th class=tdbgdark width="10%"><font class=WhiteBoldtext>End Of Week</font></th>
		</TR>
	</table>
	<%'end if %>
<%
If Trim(fstPpChar) <> "" Then
	For i = 0 To UBound(strLn)-1
	    strFld = Split(strLn(i), "|")
	    Dim j 
	    If i = 0 Then
		%>
		<% gTimeStampPrev=strFld(0)
   	       gTimeStampPrev=mid(gTimeStampPrev,4,2)+"-"+mid(gTimeStampPrev,1,2)+"-"+mid(gTimeStampPrev,7,4)
           gTimeStampPrev=cdate(gTimeStampPrev)-14
           gTimeStampPrev=Year(gTimeStampPrev)&"-"&month(gTimeStampPrev)&"-"&(day(gTimeStampPrev))
		  %>
		<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
			<tr class=tdbglight>
				 <TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(0)%></TT></FONT>
				</TD>
				<TD width="15%" align="left">
					<TT><font class=blacktext2><%Response.Write  WeekDayName(WeekDay(strFld(0)))%></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(6)%></TT></FONT>
				</TD>

				<TD width="15%" align="left">
					<TT><font class=blacktext2><%select case strFld(2)
					                             case "O" 
					                             Response.Write  "Working Day"
					                             case "W"
					                             Response.Write  "Weekly Off"
					                             case "N"
					                             Response.Write  "Holiday"
					                             case "R"
					                             Response.Write  "Holiday"
					                             case "H"
					                             Response.Write  "Half Working Day"
					                             end select
					                               %></TT></FONT>
				</TD>
			<!--<TD width="15%" align="middle">
					<TT><font class=blacktext2><% Response.Write strFld(3) %></TT></FONT>
				</TD>-->
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  ucase(strFld(4))%></TT></FONT>
				</TD>
				<TD width="10%" align="middle">
					<TT><font class=blacktext2><%Response.Write  ucase(strFld(5))%></TT></FONT>
				</TD>
				
			</tr>
		</table>
		<%
		else
		%>
				
		<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
			<tr class=tdbglight>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(0)%></TT></FONT>
				</TD>
				<TD width="15%" align="left">
					<TT><font class=blacktext2><%Response.Write  WeekDayName(WeekDay(strFld(0)))%></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(6)%></TT></FONT>
				</TD>
				<TD width="15%" align="left">
					<TT><font class=blacktext2><%select case strFld(2)
					                             case "O" 
					                             Response.Write  "Working Day"
					                             case "W"
					                             Response.Write  "Weekly Off"
					                             case "N"
					                             Response.Write  "Holiday"
					                             case "R"
					                             Response.Write  "Holiday"
					                             case "H"
					                             Response.Write  "Half Working Day"
					                             end select%></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(4)%></TT></FONT>
				</TD>
				<TD width="10%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(5)%></TT></FONT>
				</TD>
			</tr>
		</table>
		<%
		 End If
    if (i=UBound(strLn)-1) then
     gTimeStampNext=strFld(0) 		 
     gTimeStampNext=mid(gTimeStampNext,4,2)+"-"+mid(gTimeStampNext,1,2)+"-"+mid(gTimeStampNext,7,4)
   end if  
	Next	
	else
	%>
	<table width="70%" align=center>
		<tr><td>&nbsp;</td></tr>
			<tr class=tdbgdark><td colspan=2 class="whiteboldtext1">Calendar Maintenance</td></tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">Not Available For the Selected Criteria......Click
					<A href=""><b>here</b></A> to view Selection Criteria Page</td></tr>
			<tr><td>&nbsp;</td></tr>
	     </table>
	<%
	set ss=nothing
end if
%>
<form name=form1 method=post> 

<input type="hidden" name="hidtimeStampPrev" value="<%=gTimeStampPrev%>" >
<input type="hidden" name="hidtimeStamp" value="<%=gTimeStampNext%>">
<input type="hidden" name="hidResCode" value="<%=fstPpChar%>">
<input type="hidden" name="hidLstatus" >
<input type="hidden" name="hidstatus" >
<input type="hidden" name="hPageCount" value="<%=lPageCount%>">
<input type="hidden" name="hRecCount" value="<%=lRecCount%>">
<br>
	<table align="center">
	 <tr class=tdbglight height=30 align="center">
		<td>
    		<center>
				<input type="button" name="subprevious" value="Previous" onclick="funprevious();">
				<input type="button" name="subNext" value="Next" onclick="funNext();">
                <input type=button name="butCancel" value="Reset" onclick="window.location.href='Calendar_Maint_2.asp'">
				<input type=hidden name="hidStartDate" value="<%=lStartDate%>">
			</center>
		</td>
	 </tr>
	</table>
</form>
<br>
<!---#include file="../includes/footer.inc"--->
</body>
</html>
