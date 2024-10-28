<%@Language=VBSCRIPT%>
<%
'Option Explicit
'dim strFld
	

%>
<%	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		  	:	Mac Module		  					              *
	'* File name		:	ContractBrowse.asp 							      *
	'* Purpose			:	This page is used to Display on all Contract Info * 
	'* Prepared by	    :	
	'* Date			    :	24.10.2001			 								  *
	'* Copyright		:	(C) SSI Technologies,India						  *
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
	'*	1		   		   							           First Baseline      *
	'*																		  *
	'**************************************************************************
%>	
	
<%'<!--#include file="../Includes/LogonCheck.asp" ---->	%>
<%
	dim lResponse
	dim lObjContMain
	dim butAction
	dim gTimeStamp
	dim gTimeStampPrev
	dim gTimeStampNext
	dim Bstatus
	
		
	dim lStartDate
	dim lStartDay
	dim lStartMonth
	dim lStartYear
	
	
		
	dim lResult
	dim lContCode
	dim lContStatus
	dim lRec
	dim lRecCount
	lRecCount=0
	
	
	if Request.Form("hidSContCode")="C" then
	   lContCode=Request.Form("optContCode")
	   lContStatus=" "
	   lStartDate=" "
	end if
	   
	if Request.Form("hidSOther")="O" then 
	   lContStatus=Request.Form("optStatus")
	   Response.Write Request.Form("StartDate")
	   
	   if Request.Form("StartDate")="" then
		   lStartDate	=	Request.Form("hidStartDate")
		else
		   lStartDay	=	cstr(Request.Form("StartDate"))
		'end if 
		
		if len(lStartDay) <=1  then
		   lStartDay	=	0	&	lStartDay
		end if
			lStartMonth	=	cstr(Request.Form("StartMonth")) 
		if len(lStartMonth)<=1 then
			lStartMonth	=	0 & lStartMonth
		end if
		
		lStartYear	=	cstr(Request.Form("StartYear"))
		lStartDate	=	cstr(lStartYear & "-" & lStartMonth & "-" & lStartDay)
    	end if
    	
    	lContCode=" "
    end if	

	set lObjContMain	= server.CreateObject("Mac.ContractMaintenanceMgr")
	
		if Request.Form("hidBstatus") ="" then
		   Bstatus = "B"
	
		else
			Bstatus = Request.Form("hidBstatus")
			Response.Write("Status = "& Bstatus & "<BR>")
			lContCode=Request.Form("hidContCode")
			lStatus=Request.Form("hidSatus")
			lStartDate=lStartDate  
		end if 
		if trim(Request.Form("hidtimeStamp"))="" or Bstatus="B" then
		   gTimeStamp="1900-01-01:01:01:01.000001"
		   
	    else
			gTimeStampNext=trim(Request.Form("hidtimeStamp"))
			gTimeStampPrev=trim(Request.Form("hidtimeStampPrev"))
		end if
		if trim(Request.Form("hidResCode")) ="100" then
		  gTimeStamp="1900-01-01:01:01:01.000001"
		  Bstatus = "B"
	   end if
	
	select case Bstatus
		case "N":
			butAction= mid(gTimeStampNext,1,26)
		case "P":
			butAction=MID(gTimeStampPrev,1,26)
	    case "B":
		    butAction=gTimeStamp
		case else:
			butAction=gTimeStamp
	end select
	if Bstatus="B" THEN
	   Response.Write lContCode & "<br>"
	   Response.Write lStatus & "<br>"
	   Response.Write butAction & "<br>"
	   Response.Write Bstatus
	   lResult = lObjContMain.DoBrowse(lContCode,lStatus,lStartDate,butAction,Bstatus,"MAS0001000",lRec,lResponse)
	   Response.Write lResult
	   'Response.Write lRec
	   Response.Write  trim(lResponse)
	END IF 
	
	if Bstatus ="N"  or Bstatus ="P" THEN 
       lResult = lObjContMain.DoBrowse(Request.Form("hidContCode"),Request.Form("hidStatus"),lStartDate,butAction,Bstatus,lRec,lResponse)
	END IF 
	

%>
   <HTML>
   <HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
   </HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	
    <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>

	<form method="post" name="frmContractBrowse">
	
<%	
Dim strLn  'used for finding the line
Dim strFld  'Used for finding the Columns
strLn = Split(lResponse,"$")  'here EOL is used to find the End Of File(VbCrlf)

if (trim(lResult)=0 and  lRec>0) then %>
	<table width="516" border="2" cellpadding="1"  cellspacing="1" align="center" height="31">
	</table>
	<table align="center" width="100%" border="1" cellspacing="1" cellpadding="1">
		<TR>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Contract Code</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Status</font></td>	
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Starting Date</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Trade Volume</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Trade Value</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Market Lot</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Cr Filter %</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>S.cr Filter % </font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Tick Price</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>OCP</font></td>
			<!--td class=tdbgdark width="15%"><font class=WhiteBoldtext>Suspended by</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Suspended From</font></td>
			<td class=tdbgdark width="15%"><font class=WhiteBoldtext>Suspended To</font></td>-->
		</TR>
	</table>
	
 

<%
	
for i=0 to ubound(strLn)-1
strFld=split(strLn(i),"|")

%>
	
<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
	<tr class=tdbglight>
	     <TD width="15%" align="middle"><font class=blacktext2><a href="ContMainSuspend.asp?Contcode=<%=StrFld(0)%>"><%=StrFld(0)%></a></FONT></TD>
	     <TD width="15%" align="middle"><font class=blacktext2><%=StrFld(2)%></FONT></TD>
	    <TD width="15%" align="middle"><font class=blacktext2><%=StrFld(3)%></TT></FONT></TD>
		<TD width="15%" align="middle"><font class=blacktext2><%=StrFld(4)%></FONT></TD>
		<TD width="15%" align="middle"><font class=blacktext2><%=StrFld(5)%></FONT></TD>
		<TD width="15%" align="middle"><font class=blacktext2><%=StrFld(6)%></FONT></TD>
		<TD width="15%" align="middle"><font class=blacktext2><%=StrFld(7)%></FONT></TD>
		<TD width="15%" align="middle"><font class=blacktext2><%=StrFld(8)%></FONT></TD>
		<TD width="15%" align="middle"><font class=blacktext2><%=StrFld(9)%></FONT></TD>
		<TD width="15%" align="middle"><font class=blacktext2><%=StrFld(10)%></FONT></TD>
		</tr>
</table>

		
<% 
	IF I=0  then 
	   gTimeStampPrev=strFld(0)
	 end if 
	
	 IF I=9  then 
	    gTimeStampNext=strFld(0)
	 end if 
	 lRecCount=lRecCount+1
next
%>

<input type="hidden" name="hidtimeStampPrev" value="<%=gTimeStampPrev%>" >
<input type="hidden" name="hidtimeStamp" value="<%=gTimeStampNext%>">
<input type="hidden" name="hidstatus">
<input type="hidden" name="hidResCode" value="<%=fstPpChar%>">
<input type ="hidden" name="hidContCode" value=<%=lContCode%>>
<br>
<%=lreccount%>
 <table align="center">
	 <tr class=tdbglight height=30 align="center">
		<td>
			<center>
			<input type="button" name="subprevious" Value="Previous" 
		        <%if  lRecCount<1 then Response.write "disabled"%>
   				   onclick="document.frmContractBrowse.hidstatus.value ='P';
				            document.frmContractBrowse.method='post';
				            document.frmContractBrowse.action='ContractBrowse.asp';
		                    document.frmContractBrowse.submit();">
				<input type="button" name="subNext" value="Next" 
				<%if  lRecCount>0 and lRecCount<10 then Response.write "disabled"%>
				onclick="document.frmContractBrowse.hidstatus.value ='N';
				document.frmContractBrowse.method='post';
				document.frmContractBrowse.action='ContractBrowse.asp';
		        document.frmContractBrowse.submit();">
			</center>
		</td>
			   
	 </tr>
</table>
<%else%>
<Table width="60%" border="1" cellspacing="1" cellpadding="1" align=center>
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Contract  Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1>Contract Details not avaliable Click <a href="ConMainSelection.asp">here</a> to view previous page</font>
	</td></tr>
</table>
<%end if%> 
	</form>
	<!---#include file="../includes/footer.inc"--->
		</body>	
    </HTML>