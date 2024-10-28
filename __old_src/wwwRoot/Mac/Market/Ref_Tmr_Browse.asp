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
    dim gDate
    dim gTime
    dim SessPrev
    dim SessPrev1
    
    dim lEventTime
    dim lEventId
    dim lDayType
    dim lEntityType
    dim lEntityCode
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
	dim gTimeStampNext1
	dim gTimeStampPrev1
	
    lStatus=Request.Form("hidLstatus")
    if lStatus="" then
       lStatus="V"
    end if
    gTimeStampBrowse=Request.Form("hidtimeStampBrowse")
    lEventTime = Request.Form ("hidEventTime")
    lEventId=Request.Form("hidEventId")
    lDayType=Request.Form("hidDayType")
    lEntityType=Request.Form ("hidEntityType")
    lEntityCode=Request.Form("hidEntityCode")
    
    lPageCount=Request.Form("hPageCount")
    if (lStatus="B")then
      if (lPageCount = 0)  then
	   gTimeStampBrowse=Request.Form("hidtimeStampBrowse")
      else
       gDate=Session("SessPrev")
       gTime=Session("SessPrev1")
       gTimeStampBrowse=gDate
      end if
	else if (lStatus="N") then
	  gDate=Request.Form("hidtimeStampNext")
	  gTime=Request.Form("hidtimeStampNext1")
	else if (lStatus="P") then
      gDate=Session("SessPrev")
      gTime=Session("SessPrev1")
    end if
    end if
    end if
    if (lStatus="B")then
    if len(gTimeStampBrowse) = 8 then
     gTimeStampBrowse=mid(gTimeStampBrowse,1,4)+"-"+mid(gTimeStampBrowse,5,2)+"-"+mid(gTimeStampBrowse,7,2)
    else
     gTimeStampBrowse=mid(gTimeStampBrowse,1,4)+"-"+mid(gTimeStampBrowse,5,2)+"-"+mid(gTimeStampBrowse,7,1)
   end if
   end if    
    butAction=gTimeStampBrowse
    set lDMLServerObj = server.CreateObject("MAC.RtcMgr")
     if (trim(lStatus) = "B") then
        'lResp=lDMLServerObj.DoBrowse("MAS0001000",gTimeStampBrowse,lEventTime,lEventId,lDayType,lEntityCode,lEntityType,strResponse,lRecCount)
         if (gTimeStampBrowse<>"" and trim(lEventId) ="Empty") then
                  lResp=lDMLServerObj.DoBrowse("MAS0001000",gTimeStampBrowse," "," "," "," "," ",strResponse,lRecCount)
         end if
         if (lEventId<>"Empty") then
                 lResp=lDMLServerObj.DoBrowse("MAS0001000"," "," ",lEventId," "," "," ",strResponse,lRecCount)
         end if
         if (lDayType ="O" or lDayType="H") then
                lResp=lDMLServerObj.DoBrowse("MAS0001000"," "," "," ",lDayType," "," ",strResponse,lRecCount)
         end if
         
         if (lEntityType <> "Empty") then
                lResp=lDMLServerObj.DoBrowse("MAS0001000"," "," "," "," ",lEntityCode,lEntityType,strResponse,lRecCount)
         end if         
     else if (lStatus = "V") then
      lResp=lDMLServerObj.DoBrowse ("MAS0001000", " ", " ", " ", " ", " ", " ",strResponse,lRecCount ) 'All
    
     else if ((lStatus ="N") or (lStatus = "P" and lPageCount<>2))  then
       lResp=lDMLServerObj.DoBrowse ("MAS0001000",gDate,gTime, " ", " ", " ", " ",strResponse,lRecCount ) 'All
     else if (lStatus = "P" and lPageCount=2) then
       lResp=lDMLServerObj.DoBrowse ("MAS0001000", " ", " ", " ", " ", " ", " ",strResponse,lRecCount ) 'All
     end if
     end if           
     end if
     end if
     if (lResp=0) then
      if Request.Form("hPageCount")="" then
        lPageCount=1
      else 
      if lStatus="N" then
         lPageCount=cint(Request.Form("hPageCount"))+1
       else if lStatus="P" or lStatus ="B" then
         lPageCount=cint(Request.Form("hPageCount"))-1
       end if
      end if
      end if   
     end if 
     Dim strLn  'used for finding the line
  	 Dim strFld 'Used for finding the Columns
     strLn = Split(mid(strResponse,2,len(strResponse)),"$") 'here EOL is used to find the End Of File(VbCrlf)
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
 if (document.form1.hPageCount.value ==2 )
   document.form1.hidLstatus.value ="B";
 else
 document.form1.hidLstatus.value ="P";
 document.form1.method="post";
 document.form1.action="Ref_Tmr_Browse.asp";
 document.form1.submit();

}
function funNext()
{
if (document.form1.hPageCount.value > 1 )
  document.form1.subprevious.disabled=false;
document.form1.hidLstatus.value="N";
document.form1.hidstatus.value ="T";
document.form1.method="post";
document.form1.action="Ref_Tmr_Browse.asp";
document.form1.submit();

}
function PrevButDisable()
{
if (document.form1.hPageCount.value == 1 )
{
  document.form1.subprevious.disabled=true;
} 
if (document.form1.hRecCount.value <8) 
{
 document.form1.subNext.disabled=true;
 }
}
</script>
<br>
  <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>

<body onload="PrevButDisable();">
<table width="40%" border="0"  cellpadding=1 cellspacing=1 align=center>
<tr>
<!-- class="tdbglight">-->
  <td align=center colspan=5 class="blackboldtext1"> Reference Timer Control </td>
</tr>
</table>
<br>
	<table border=0 width="100%" align = center >
		<TR>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Exec.Day</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Exec.Date</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Exec.Time</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Entity Event</font></th>
<!--			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Holiday Zones</font></th>-->
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Entity Type</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Entity Code</font></th>
			<th class=tdbgdark width="10%"><font class=WhiteBoldtext>Next Phase</font></th>
			
		</TR>
	</table>
	<%'end if %>
<%
If Trim(fstPpChar) <> "" Then
    dim field1
    dim field2
    dim field3
    dim field4
    dim field5
    dim field6
    dim field7
    
	For i = 0 To lRecCount-1
	    strFld = Split(strLn(i), "|")
	    Dim j 
	    If i = 0 Then
		%>
		<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
			<tr class=tdbglight>
				 <TD width="15%" align="middle">
					<TT><font class=blacktext2>
                   
					<a href="Ref_Tmr_Upd_Del.asp?hExecDay=<%= strFld(0)%>
					                             &hExecDate=<%=strFld(1)%>
					                             &hExecTime=<%=strFld(2)%>
					                             &hEntEvent=<%=  strFld(3)%>
					                             &hEntType=<%= strFld(4)%>
					                             &hEntCode=<%=  strFld(5)%>
					                             &hNxtPhase=<%= strFld(6)%>
					                             &hRandDel=<%=strFld(7)%> "> 
                 					<%Response.Write  strFld(0)%></a></TT></FONT>
			</TD>
				<TD width="15%" align="left">
					<TT><font class=blacktext2><%Response.Write  strFld(1)%></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(2)%></TT></FONT>
				</TD>
				<TD width="15%" align="left">
					<TT><font class=blacktext2><%Response.Write  strFld(3)  %></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write strFld(4)%></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write strFld(5)%></TT></FONT>
				</TD>
				<TD width="10%" align="middle">
    				<TT><font class=blacktext2><%Response.Write strFld(6)%></TT></FONT>
 				</TD>
				
			</tr>
		</table>
		<%
		else
		%>
				
		<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
			<tr class=tdbglight>
				<TD width="15%" align="middle">
				<TT><font class=blacktext2>
					<a href="Ref_Tmr_Upd_Del.asp?hExecDay=<%= strFld(0)%>
					                            &hExecDate=<%=strFld(1)%>
					                            &hExecTime=<%=strFld(2)%>
					                            &hEntEvent=<%=  strFld(3)%>
					                            &hEntType=<%= strFld(4)%>
					                            &hEntCode=<%=  strFld(5)%>
					                            &hNxtPhase=<%= strFld(6)%>
					                            &hRandDel=<%=strFld(7)%>">
    				<%Response.Write  strFld(0)%></a>
   				</TT></FONT>
				</TD>
				<TD width="15%" align="left">
					<TT><font class=blacktext2><%Response.Write strFld(1)%></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(2)%></TT></FONT>
				</TD>
				<TD width="15%" align="left">
					<TT><font class=blacktext2><%Response.Write  strFld(3) %></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(4)%></TT></FONT>
				</TD>
				<TD width="15%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(5)%></TT></FONT>
				</TD>
				<TD width="10%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(6)%></TT></FONT>
				</TD>

			</tr>
		</table>
		<%
		 End If
    if (i=(lRecCount-1)) then
      gTimeStampNext=strFld(1)
	  gTimeStampNext1=strFld(2)      		 

   	  Session("SessPrev")=Request.Form("hidtimeStampPrev")
      Session("SessPrev1")=Request.Form("hidtimeStampPrev1")
	  gTimeStampPrev=strFld(1)
	  gTimeStampPrev1=strFld(2)
	  
   end if  
   Next	
	else
	%>
	<table width="70%" align=center>
		<tr><td>&nbsp;</td></tr>
			<tr class=tdbgdark><td colspan=2 class="whiteboldtext1">Reference Timer Control</td></tr>
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
<input type="hidden" name="hidtimeStampPrev1" value="<%=gTimeStampPrev1%>" >
<input type="hidden" name="hidtimeStampNext" value="<%=gTimeStampNext%>">
<input type="hidden" name="hidtimeStampNext1" value="<%=gTimeStampNext1%>">
<input type="hidden" name="hidResCode" value="<%=fstPpChar%>">
<input type="hidden" name="hidLstatus" >
<input type="hidden" name="hidstatus" >
<input type="hidden" name="hPageCount" value="<%=lPageCount%>">
<input type="hidden" name="hRecCount" value="<%=lRecCount%>">

<input type="hidden"  name="hExecDay">
<input type="hidden"  name="hExecDate">
<input type="hidden"  name="hExecTime">
<input type="hidden"  name="hEntEvent">
<input type="hidden"  name="hEntType">
<input type="hidden"  name="hEntCode">
<input type="hidden"  name="hNxtPhase">
<input type="hidden"  name="hRandDel">

<br>
	<table align="center">
	 <tr class=tdbglight height=30 align="center">
		<td>
    		<center>
				<input type="button" name="subprevious" value="Previous" onclick="funprevious();">
				<input type="button" name="subNext" value="Next" onclick="funNext();">
                <input type=button   name="butCancel" value="Reset" onclick="window.location.href='Ref_Tmr_Main.asp'">
				<input type=hidden   name="hidStartDate" value="<%=lStartDate%>">
			</center>
		</td>
	 </tr>
	</table>
</form>
<br>
	<!---#include file="../includes/footer.inc"--->
</body>
</html>
