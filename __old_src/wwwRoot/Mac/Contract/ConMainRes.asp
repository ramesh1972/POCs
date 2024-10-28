<%@Language=VBSCRIPT%>
<%
Option Explicit
%>
<%	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Surveillance User								      *
	'* File name	:	TCMGEM2MDetails.asp								          *
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
	dim lPageSize
	dim lTotalPage
	dim lCount	
	dim lStart
	dim lEnd
		
	'***
	dim StartMonth
	dim StartDate
	dim startYear
	dim CURRENTDATE
	dim lYearPrev
	dim lYearCurrent
	dim lYearNext
	DIM LMONTH
	DIM LDATE
	DIM LYEAR
	DIM LYEAR1
	dim lStartDay
	dim lStartMonth
	dim lStartYear
	dim lStartDate 		 
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

	'***********
	dim InstCode
	dim InstStatus
	dim lBrosday
	dim lBrosMonth
	dim lBrosYear
	dim lBrosDate
	InstCode = Request.Form("hidInst")
	InstStatus = Request.form("hidstatus")
	lBrosMonth = Request.Form("hidStartMonth")
	lBrosday = Request.Form("hidStartDate")
	lBrosYear = Request.Form("hidStartYear")
	lBrosDate = lBrosday + " / " +  lBrosMonth +  " / " + lBrosYear
	'Response.Write InstCode
	'Response.Write InstStatus 
	'Response.Write lBrosdate
	'Response.Write lBrosMonth
	'Response.Write lBrosYear
	'Response.Write lBrosDate
	dim strResponse 
	dim objConMain
	set objConMain = server.CreateObject("Mac.ContractMaintenanceMgr")
	'strResponse = objConMain
	'set objConMain = server.CreateObject ("CLEARANDSETTLEMENTLib.ClearSettlement") 
	'set objConMain = server.CreateObject("ClearAndSettlement.ClearSettlement")
	'strResponse  = objConMain.exchangeDownload ("MZE0006000","2001-11-22","1900-01-01:00:00:00.000000","V")
	'Response.Write strResponse
	'Qstr = "SELECT UPER_USERID ,GEL_LEVEL_NO ,GEL_WARNING_TIME ,GEL_WARNING_PRCNT  ,GEL_LIMIT_VALUE ,GEL_VALUE From GEL_TCM Order By GEL_WARNING_TIME "
	'set rsupdate = objreport.GetReport(Qstr) 
	'strResponse=objMktMon.MktMonView("BOOE")'Sending the output the strResponse
	'Dim strLn  'used for finding the line
	Dim strFld 'Used for finding the Columns
	'strLn = Split(strResponse, "EOL") 'here EOL is used to find the End Of File(VbCrlf)
	'Dim i 
	'Dim FstPpPos  'used to find the First Pipe Character Position
	'FstPpPos = InStr(1, strResponse, "|")
	'Dim fstPpChar 'is used to find the character between start and Fist Character
	'fstPpChar = Mid(strResponse, 1, FstPpPos - 1)
	'If Trim(fstPpChar) = 0 Then
	'	For i = 0 To UBound(strLn)
	'	    strFld = Split(strLn(i), "|")
	'	    Dim j 
	'	    If i = 0 Then
		    
	'	    else
		    
	'	    End If
	'	Next 	
	'else
	'	Response.Write "Error Occurred"
	'end if
	
	
	
	
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
	function validateDate()
	{
		lSDate	= document.frmDownLoadASP.StartDate.value ;
		lSMonth	= document.frmDownLoadASP.StartMonth.value;
		lSYear	= document.frmDownLoadASP.StartYear.value;
		lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
		if ((validDate(lSMonth,lSDate,lSYear))== false )
	{
			document.frmDownLoadASP.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;
	}
	return true;
	}
	function funbrowse()
	{
	alert("Records Not Available");
	document.frmDownLoadASP.action ="DownLoadASP.asp";
	document.frmDownLoadASP.method = "post"
	}
	function funDownLoad()	
	{
	alert("Records Not Available");
	document.frmDownLoadASP.action ="DownLoadASP.asp";
	document.frmDownLoadASP.method = "post"
	}
	</script>
		
	<form method="post"  name="frmDownLoadASP"  >
	<table width="100%" border="1" cellpadding="1"  cellspacing="1" align="center">
	<tr class=tdbgdark height=10 align="middle">
		<td>
			<font class=whitetext1 >Contract Code - </font><%=InstCode%>
 		</td>
 		<td>
			<font class=whiteboldtext1 >Contract Status - </font><%if trim(ucase(InstStatus))= "N" then
					                                Response.Write "Active" 
					                             elseif trim(ucase(InstStatus))= "P" then
					                                 Response.Write "Suspended"
					                             else
					                                 Response.Write "Invalid"
					                             end if	%>
 		</td>
 		<td>
			<font class=whiteboldtext1 >First Listed Date - </font><%=lBrosdate%>
 		</td>
 	</tr>
 	
	</table>
	
	<br>
	<table align="center" width="100%" border="1" cellspacing="1" cellpadding="1">
		<TR>
			<td width="10%"><font class=Whitetext1>Contract Code</font></td>
			<td class=tdbgdark width="5%"><font class=WhiteBoldtext>Status</font></td>
			<td class=tdbgdark width="10%"><font class=WhiteBoldtext>Starting Date</font></td>
			<td class=tdbgdark width="5%"><font class=WhiteBoldtext>Trade Volume</font></td>
			<td class=tdbgdark width="5%"><font class=WhiteBoldtext>Trade Value</font></td>
			<td class=tdbgdark width="5%"><font class=WhiteBoldtext>Market Lot</font></td>
			<td class=tdbgdark width="10%"><font class=WhiteBoldtext>Cr Filter %</font></td>
			<td class=tdbgdark width="10%"><font class=WhiteBoldtext>S.cr Filter % </font></td>
			<td class=tdbgdark width="5%"><font class=WhiteBoldtext>Tick Price</font></td>
			<td class=tdbgdark width="5%"><font class=WhiteBoldtext>OCP</font></td>
			<td class=tdbgdark width="10%"><font class=WhiteBoldtext>Suspended by</font></td>
			<td class=tdbgdark width="10%"><font class=WhiteBoldtext>Suspended From</font></td>
			<td class=tdbgdark width="10%"><font class=WhiteBoldtext>Suspended To</font></td>
		</TR>
	</table>
	
 
<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
	<tr class=tdbglight>
		 <TD width="15%" align="middle">
			<TT><font class=blacktext2><%'Strfld(0)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(1)%></TT></FONT>
		</TD>
		<TD width="15%" align="middle">
			<TT><font class=blacktext2><%'Strfld(2)%></TT></FONT>
		</TD>
		<TD width="15%" align="middle">
			<TT><font class=blacktext2><%'Strfld(3)%></TT></FONT>
		</TD>
		<TD width="15%" align="middle">
			<TT><font class=blacktext2><%'Strfld(4)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(5)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(6)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(7)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(8)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(9)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(10)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(11)%></TT></FONT>
		</TD>
		<TD width="10%" align="middle">
			<TT><font class=blacktext2><%'Strfld(12)%></TT></FONT>
		</TD>
	</tr>
</table>
<%
'rsupdate.MoveNext
'loop %>
<%'else %>
<!--table width="70%" align=center >
			<tr><td>&nbsp;</td></tr>
			<tr class=tdbgdark><td colspan=2 class="whiteboldtext1">Latest Prices</td></tr>
			<tr class="tdbglight"> 
				<td colspan=2 class="blacktext">Price Statistics Details Not Available </td></tr>
			<tr><td>&nbsp;</td></tr>
		</table-->
		<%'lCheckRecord	= false %>
<%'end if%>
	<table align="center" border="1">
	<tr>
		<td>Suspend From</td>
		<td><input type=text name="txtSuspFrm"></td>
		<td>To</td>
		<td><input type="text" name="txtSuspTo"></td>
	</tr>
	</table>
	<br>
	<table  align="center">
	 <tr class=tdbglight height=30 align="center">
		<td>
			
				<input type="submit" name="subNext" value="Next">			
				<input type="submit" name="subprevious" value="Previous">
				<input type="submit" name="subDownLoad" Value="Suspend">&nbsp;
				<input type="Reset" name="Reset" value="Cancel">
				
				<input type=hidden name="hidStartDate" value=<%=lStartDate%>>
				
			
		</td>
	</tr>
	</table>
	</form>
	<%'<!-- #include file = "../Includes/footer.inc" --%>
	</body>	
    </HTML>