<%@Language=VBSCRIPT%>
<%
'Option Explicit
'dim strFld
	

%>
<%	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		  	:	Mac Module			  					              *
	'* File name		:	ubnkbrowse.asp    							      *
	'* Purpose			:	This page is used to Display on all Charges       	  * 
	'* Prepared by	:	
	'* Date			:	24.10.2001			 								  *
	'* Copyright		:	(C) SSI Technologies,India							  *
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
	dim lObjUbnk
	dim butAction
	dim gTimeStamp
	dim gTimeStampPrev
	dim gTimeStampNext
	dim Bstatus
	dim lUserid
	dim lacctype
	dim lBankcode
	dim lBranchcode
	dim laccno
	dim opendate
	dim lRec
	dim lRecCount
	lRecCount=0
	
	lBankCode=Request.Form("optBnkCode")
	lBranchcode=Request.Form(trim("optBrncode"))
     
	set lObjubnk	= server.CreateObject("Mac.UserBankMgr")
	
		if Request.Form("hidstatus") ="" then
		   Bstatus = "V"
	
		else
			Bstatus = Request.Form("hidstatus")
			lBankCode=Request.Form("hidBnkCode")
			lBranchcode=Request.Form("hidBrnCode")  
		end if 
		if trim(Request.Form("hidtimeStamp"))="" or Bstatus="V" then
		   gTimeStamp="  1900-01-01:00:00:00.000000"
		   
	    else
			gTimeStampNext=trim(Request.Form("hidtimeStamp"))
			gTimeStampPrev=trim(Request.Form("hidtimeStampPrev"))
		end if
		'if trim(Request.Form("hidResCode")) ="100" then
		 ' gTimeStamp="  1900-01-01:00:00:00.000000"
		 ' Bstatus = "V"
	   'end if
	
	select case Bstatus
		case "N":
			butAction= mid(gTimeStampNext,1,26)
			
			
		case "P":
			butAction=MID(gTimeStampPrev,1,26)
	    case "V":
		    butAction=gTimeStamp
		case else:
			butAction=gTimeStamp
	end select
	
	if Bstatus="V" THEN
	   lResult = lObjUbnk.DoUsrBnkBrowse(trim(lBankCode),trim(lBranchcode),butAction, Bstatus, lResponse, lRec)
	END IF 
	
	if Bstatus ="N"  or Bstatus ="P" THEN 
       lResult = lObjUbnk.DoUsrBnkBrowse(Request.Form("hidBnkCode"),Request.Form("hidBrnCode"),butAction,trim(Bstatus),lResponse,lRec)
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

	<form method="post" name="frmubnkBrowse">
	
<%	
Dim strLn  'used for finding the line
Dim strFld  'Used for finding the Columns
strLn = Split(lResponse,"$")  'here EOL is used to find the End Of File(VbCrlf)
if trim(lResult)=0 then%>
	<table width="516" border="2" cellpadding="1"  cellspacing="1" align="center" height="31">
	<tr class=tdbgdark height=10 align="middle" >
 		<td width="516" height="25">
		 <font class="WhiteBoldtext" align="center">User Bank Details</font>
 		</td>
 	</tr>
	</table>
	<table border=1 width="516" align = center height="26" >
		<TR>
			<th class=tdbgdark width="93" align="left" height="22"><font class="WhiteBoldtext">Userid</font></th>
			<th class=tdbgdark width="126" align="left" height="22"><font class=WhiteBoldtext>Account Type</font></th>
			<th class=tdbgdark width="126" align="left" height="22"><font class=WhiteBoldtext>Account No</font></th>
			<th class=tdbgdark width="143" align="left" height="22"><font class=WhiteBoldtext>A/c Open Date</font></th>
		</TR>
	</table>

	
<%
for i=0 to ubound(strLn)-1
	strFld=""
	strFld=split(strLn(i),"|")
	
	%>
	
		<table align="center" width="516" border="1"  cellspacing="1" cellpadding="1" height="24">
			<tr class=tdbglight>
				 <TD width="93" align="middle" height="18">
					<font class=blacktext2><%Response.Write  strFld(0)%></FONT>
				</TD>
				<TD width="126" align="middle" height="18">
					<font class=blacktext2><%Response.Write  strFld(1)%></FONT>
				</TD>
		<TD width="126" align="middle" height="18">
		<font class=blacktext2><%Response.Write  strFld(2)%></FONT>
		</TD>
			
		<TD width="143" align="middle" height="18">
			<font class=blacktext2><%Response.Write  mid(strFld(3),1,10)%></FONT>
		</TD>
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
end if%>

<input type="hidden" name="hidtimeStampPrev" value="<%=gTimeStampPrev%>" >
<input type="hidden" name="hidtimeStamp" value="<%=gTimeStampNext%>">
<input type="hidden" name="hidstatus">
<!--input type="hidden" name="hidResCode" value="<%=fstPpChar%>">-->
<input type ="hidden" name="hidBnkCode" value=<%=lBankCode%>>
<input type="hidden" name="hidBrnCode" value=<%=lBranchcode%>>
<br>
<%=lreccount%>
 <table align="center">
	 <tr class=tdbglight height=30 align="center">
		<td>
			<center>
			<input type="button" name="subprevious" Value="Previous" 
		        <%if  lRecCount<1 or Bstatus="V" then Response.write "disabled"%>
   				   onclick="document.frmubnkBrowse.hidstatus.value ='P';
				            document.frmubnkBrowse.method='post';
				            document.frmubnkBrowse.action='ubnkbrowse.asp';
		                    document.frmubnkBrowse.submit();">
				<input type="button" name="subNext" value="Next" 
				<%if  lRecCount>0 and lRecCount<10 then Response.write "disabled"%>
				onclick="document.frmubnkBrowse.hidstatus.value ='N';
				document.frmubnkBrowse.method='post';
				document.frmubnkBrowse.action='ubnkbrowse.asp';
		        document.frmubnkBrowse.submit();">
			</center>
		</td>
			   
	 </tr>
</table>

	</form>
	<!---#include file="../includes/footer.inc"--->
		</body>	
    </HTML>