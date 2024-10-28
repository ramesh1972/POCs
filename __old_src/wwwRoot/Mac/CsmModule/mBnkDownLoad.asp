<%@Language=VBSCRIPT%>
<%
'Option Explicit
%>
<%	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Surveillance User								      *
	'* File name	:	BnkDownLoad.asp								      *
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
<%'<!--#include file="../Includes/LogonCheck.asp" ---->	%>
<%
	dim rsupdate
	dim objreport
	dim lLastTradePrice
	dim lBuyPrice
	dim lSellPrice
	dim lShowPage
	dim lShowNextTen
	dim lPageSize
	dim lTotalPage
	dim lCount	
	dim lCheckFlag
	dim lCheckRecord
	dim lRecordsShown
	dim lShowPageCount
	dim lStart
	dim lEnd
	dim Qstr 
	dim netValSum
	dim M2MLossSum
	dim net1
	dim net2
	dim strResponse
	dim ss
'**
	dim StartMonth
	dim StartDate
	dim startYear
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
	'********
	'set ss = server.CreateObject("ClearAndSettlement.ClearSettlement")
	set ss = server.CreateObject("Mac.ExchMgr")
	'****
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
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
	</HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<script language =javascript>
	function funprevious()
	{
		document.frmDownLoadASP.hidstatus.value ="P";
		document.frmDownLoadASP.method="post";
		document.frmDownLoadASP.action="BnkDownLoad.asp";
		document.frmDownLoadASP.submit();
		//alert("prvious");
	}
	function funNext()
	{
		document.frmDownLoadASP.hidstatus.value ="N";
		document.frmDownLoadASP.method="post";
		document.frmDownLoadASP.action="BnkDownLoad.asp";
		document.frmDownLoadASP.submit();
		//alert("Next")
	}
	</script>
	<%'if not(rsupdate.EOF and rsupdate.BOF) then%>
    <form method="post" name="frmDownLoadASP">
	<table width="50%" border="1" cellpadding="1"  cellspacing="1" align="center">
	<tr class=tdbglight height=10 align="middle" >
 		<td>
		 <font class=blackboldtext1 align="center">Exchnage DownLoad Bank Details</font>
 		</td>
 	</tr>
	</table>
	<br>
	<TABLE align="right">
	    <TR >
			<TD class=tdbglight width="160" height="10">
				<font class=blacktext>Please Select the Date</font>
			</TD>
			<TD WIDTH="200" CLASS=tdbglight height="10"> 
				<select size="1" name="StartMonth" style="HEIGHT: 22px; WIDTH: 92px" >
					<option value="">--Months--</option>
					<OPTION  value="1" >January</OPTION>
					<OPTION value="2" >February</OPTION>
					<OPTION value="3" >March</OPTION>
					<OPTION value="4" <%'if LMONTH=4 then Response.Write "selected"%>>April</OPTION>
					<OPTION value="5" <%'if LMONTH=5 then Response.Write "selected"%>>May</OPTION>
					<OPTION value="6" <%'if LMONTH=6 then Response.Write "selected"%>>June</OPTION>
					<OPTION value="7" <%'if LMONTH=7 then Response.Write "selected"%>>July</OPTION>
					<OPTION value="8" <%'if LMONTH=8 then Response.Write "selected"%>>August</OPTION>
					<OPTION value="9" <%'if LMONTH=9 then Response.Write "selected"%>>September</OPTION>
					<OPTION value="10" <%'if LMONTH=10 then Response.Write "selected"%>>October</OPTION>
					<OPTION value="11" <%'if LMONTH=11 then Response.Write "selected"%>>November</OPTION>
					<OPTION value="12" <%'if LMONTH=12 then Response.Write "selected"%>>December</OPTION>
				</select> 
				<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" >
					<option value="">--Date--</option>
					<OPTION  value="1" <%'if LDATE=1 then Response.Write "selected"%>>1</OPTION> <OPTION value="2" <%'if LDATE=2 then Response.Write "selected"%>>2</OPTION>
					<OPTION value="3"  <%'if LDATE=3 then Response.Write "selected"%>>3</OPTION> <OPTION value="4" <%'if LDATE=4 then Response.Write "selected"%>>4</OPTION>
					<OPTION value="5"  <%'if LDATE=5 then Response.Write "selected"%>>5</OPTION> <OPTION value="6" <%'if LDATE=6 then Response.Write "selected"%>>6</OPTION>
					<OPTION value="7"  <%'if LDATE=7 then Response.Write "selected"%>>7</OPTION> <OPTION value="8" <%'if LDATE=8 then Response.Write "selected"%>>8</OPTION>
					<OPTION value="9"  <%'if LDATE=9 then Response.Write "selected"%>>9</OPTION> <OPTION value="10" <%'if LDATE=10 then Response.Write "selected"%>>10</OPTION>
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
				<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
					<OPTION value="<%=lYearPrev%>" ><%=lYearPrev%></OPTION>
					<OPTION value="<%=lYearCurrent%>" selected><%=lYearCurrent%></OPTION>
					<OPTION value="<%=lYearNext%>" ><%=lYearNext%></OPTION>
				</select>
			</TD>
		</TR>
	</table>
	
	
<%
	'*** Time Stamp Checking ********
	dim gTimeStamp
	dim gTimeStampPrev
	dim gTimeStampNext
	dim Bstatus
	
	if Request.Form("hidstatus") ="" then
		Bstatus = "V"
	else
		Bstatus = Request.Form("hidstatus")
	end if 
	if trim(Request.Form("hidtimeStampNext"))="" or Bstatus="V" then
	   gTimeStamp="  1900-01-01:00:00:00.000000"
	else
	   gTimeStampNext=trim(Request.Form("hidtimeStampNext"))
	   gTimeStampPrev=trim(Request.Form("hidtimeStampPrev"))
	end if
	if trim(Request.Form("hidResCode")) ="100" then
		gTimeStamp="  1900-01-01:00:00:00.000000"
		Bstatus = "V"
	end if
	select case Bstatus
		case "N":
			butAction= gTimeStampNext
		case "P":
			butAction=gTimeStampPrev
	    case "V":
		    butAction=gTimeStamp
		case else:
			butAction=gTimeStamp
	end select
	if Request.Form("hidtimeStampPrev")="" and Request.Form("hidtimeStampNext")="" and Bstatus="N" then
		gTimeStamp="  1900-01-01:00:00:00.000000"
		Bstatus = "V"
		butAction=gTimeStamp
		'Response.Write "hai"
	end if
	dim s
			
	'strResponse  = ss.exchangeDownload ("MDI0002000",trim(lStartDate), butAction, trim(Bstatus))''''''''''''''''''''''''''''''
	dim lrec
	dim lprev
	dim lnext
	dim lResponse
	if lStartDate = "" then
	        %>
	        <br>
	       <br> 
		<table width="50%" align=center  >
		<tr>
			<td>&nbsp;</td></tr>
			<tr class=tdbgdark><td colspan=2 class="whiteboldtext1">Bank Down Load</td></tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">Select Date then Click Browse Button</td></tr>
			<tr><td>&nbsp;</td></tr>
	</table>
	<%else
	'strResponse  = ss.DoExchBrowse("2001-12-19", "1900-01-01:01:01:01.000001", "V", lResponse, lrec, lprev, lnext)
	'strResponse  = ss.DoExchBrowse(trim(lStartDate), butAction,"V", lResponse, lrec, lprev, lnext)
	strResponse  = ss.DoExchBrowse(trim(lStartDate),trim(butAction), trim(Bstatus), lResponse, lrec, lprev, lnext)
	'Response.Write lStartDate & "<br>"
	'Response.Write Bstatus & "<br>"
	'Response.Write butAction & "<br>"
	'Response.Write lrec  
	dim RecCount
	RecCount=cint(lrec)
	if strResponse = 0 then
		Dim strLn  'used for finding the line
		Dim strFld 'Used for finding the Columns
		strLn = Split(lResponse,"$") 'here EOL is used to find the End Of File(VbCrlf)
		Dim i 
		Dim FstPpPos  'used to find the First Pipe Character Position
		FstPpPos = InStr(1,lResponse, "|")
		Dim fstPpChar 'is used to find the character between start and Fist Character
		fstPpChar = Mid(lResponse,1,FstPpPos - 1)
	
   %>
   <br>
	<br>
	<table border=1 width="100%" align = center  >
		<TR>
			<th class=tdbgdark width="10%"><font class=WhiteBoldtext>Date</font></th>
			<th class=tdbgdark width="10%"><font class=WhiteBoldtext>Userid</font></th>
			<th class=tdbgdark width="20%"><font class=WhiteBoldtext>Name</font></th>
			<th class=tdbgdark width="5%"><font class=WhiteBoldtext>Account Type</font></th>
			<th class=tdbgdark width="10%"><font class=WhiteBoldtext>Account No</font></th>
			<th class=tdbgdark width="5%"><font class=WhiteBoldtext>Amount Type</font></th>
			<th class=tdbgdark width="10%"><font class=WhiteBoldtext>Amount(Rs.)</font></th>
			
		</TR>
	</table>
   <%
	For i = 0 To UBound(strLn)-1
	    strFld = Split(strLn(i), "|")
	     
		%>
		<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
			<tr class=tdbglight>
				 <TD width="10%" align="left">
					<TT><font class=blacktext2><%Response.Write  strFld(0)%></TT></FONT>
				</TD>
				<TD width="10%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(1)%></TT></FONT>
				</TD>
				<TD width="20%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(2)%></TT></FONT>
				</TD>
				<TD width="5%" align="middle">
					<TT><font class=blacktext2><%if trim(ucase(strFld(3)))= "M" then
					                                Response.Write "Margin" 
					                            elseif trim(ucase(strFld(3)))= "C" then
					                                 Response.Write "Clearing"
					                             else
					                                 Response.Write "Invalid"
					                             end if
					                                 %></TT></FONT>
				</TD>
				<TD width="10%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(4)%></TT></FONT>
				</TD>
				<TD width="5%" align="middle">
					<TT><font class=blacktext2><%if trim(ucase(strFld(5)))= "D" then
					                                Response.Write "Debit" 
					                             elseif trim(ucase(strFld(5)))= "C" then
					                                 Response.Write "Credit"
					                             else
					                                 Response.Write "Invalid"
					                             end if%></TT></FONT>
				</TD>
				<TD width="10%" align="middle">
					<TT><font class=blacktext2><%Response.Write  strFld(6)%></TT></FONT>
				</TD>
				
			</tr>
		</table>
		<%
		Next	
	else%>
		<table width="70%" align=center>
			<tr align="center">
				<td>&nbsp;</td>
			</tr>
			<tr class=tdbgdark align=center>
				<td colspan=2 class="whiteboldtext1">Bank Down Load</td>
			</tr>
			<tr class="tdbglight" align=center> 
				<td colspan=2 class="blacktext">Not Available For the Selected Criteria......Click
					<A href=""><b>here</b></A> to view Selection Criteria Page</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
	<%
	end if
	%>
		<%
	set ss=nothing
end if
%>
<input type="hidden" name="hidtimeStampPrev" value="<%=lprev%>" >
<input type="hidden" name="hidtimeStampNext" value="<%=lnext%>">
<input type="hidden" name="hidstatus">
<input type="hidden" name="hidResCode" value="<%=fstPpChar%>">
<br>
<%'Response.Write Bstatus%>
	<br>
	<br>
	<table align="center">
	 <tr class=tdbglight height=30 align="center">
		<td>
			<center>
				<input type="submit" name="subView" Value="Browse">&nbsp;
				<input type="button" name="subprevious" value="Previous"
				<%if RecCount=0 and trim(Bstatus)= "P" then%>
					disabled
					<%else%>
					<%response.write "dsdsfsdfsdafsdfdsf"%>
				<%end if%>
				
				 onclick="funprevious();">
				<input type="button" name="subNext" value="Next" 
				<%
				if RecCount < 9 and trim(Bstatus)= "N"then%>
					disabled
				<%else%>
					<%response.write "dsdsfsdfsdafsdfdsf"%>
				<%end if%>
				
				onclick="funNext();">
				<input type="Submit" name="btnDownLoad" value="DownLoad" onclick=<%call func()%>>
				<input type=hidden name="hidStartDate" value="<%=lStartDate%>">
			</center>
		</td>
	 </tr>
	</table>
	<%
	sub func()
		Dim Splitstr 
		DIM DownRs
		Dim DownObj
		dim lResponse
		dim lprev
		dim lnext
		set DownObj = server.CreateObject("Mac.ExchMgr")
		DownRs = DownObj.DoDownloadExch(trim(lStartDate),"1900-01-01:01:01:01.000001","V",lResponse)
		'Response.Write lResponsetrim(lStartDate)
		Splitstr = split(lResponse,"$")
		Const ForReading = 1, ForWriting = 2, ForAppending = 8
		Dim fso, f
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f = fso.OpenTextFile("c:\inetpub\wwwroot\mac\DownLoad-" & replace(date,"/","-") & ".txt",ForWriting,true)
		'f.Write replace(replace(replace(strResponse,"|",","),"$",vbcrlf)," ","") --& date() &
		For i = 0 To UBound(Splitstr)
			f.Write Splitstr(i) & vbcrlf
		next
		f.Close
		'set fso=nothing
	end sub
   %>
	</form>
		</body>	
    </HTML>