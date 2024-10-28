<%@Language=VBSCRIPT%>
<%
'Option Explicit
%>
<%	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Mac Module			  					              *
	'* File name	:	ChargeBrowse.asp    							      *
	'* Purpose		:	This page is used to Display on all Charges       	  * 
	'* Prepared by	:	Obula reddy
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
	'*	1		   		   P.Obula Reddy               First Baseline         *
	'*																		  *
	'**************************************************************************
%>		
<%'<!--#include file="../Includes/LogonCheck.asp" ---->	%>
<%
	dim lResponse
	dim lObjCharge
	dim butAction
	dim gTimeStamp
	dim gTimeStampPrev
	dim gTimeStampNext
	dim Bstatus
	dim lComgCode
	dim lContCode
	dim rs
	dim lCmgGrpCode
	dim lCntGrpCode
	dim pComgCode
	dim pContCode	
	dim lRecCount
	lRecCount=0
	lComgCode=Request.Form(trim("OptComgCode"))
	lContCode=Request.Form (trim("OptContCode"))
   
   if trim(lContCode)="ALL" THEN
	   lContCode=" "
	end if 	   
	
	lComgCode=split(lComgCode,"|")
	set lObjCharge = server.CreateObject("Mac.ChargeMasterMgr")
		if Request.Form("hidstatus") ="" then
		   Bstatus = "V"
		   lCmgGrpCode=lComgCode(1) 
	
		else
			Bstatus = Request.Form("hidstatus")
			lCmgGrpCode=Request.Form("hidlComgGrpCode")
			lContCode=Request.Form("hidlContGrpCode")  
		end if 
		if trim(Request.Form("hidtimeStamp"))="" or Bstatus="V" then
		   gTimeStamp="  1900-01-01:00:00:00.000000"
		   
	    else
			gTimeStampNext=trim(Request.Form("hidtimeStamp"))
			gTimeStampPrev=trim(Request.Form("hidtimeStampPrev"))
		end if
		if trim(Request.Form("hidResCode")) ="100" then
		  gTimeStamp="  1900-01-01:00:00:00.000000"
		  Bstatus = "V"
	   end if
	
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
	   lComgGrpCode=lComgCode(1)
	   lContGrpCode=lContCode
	   lResult = lObjCharge.ChargeMasterBrowse (lCmgGrpCode,lContGrpCode,trim(Bstatus),butAction,"MZE0006000",lResponse,lRec)
	END IF 
	
	if Bstatus ="N"  or Bstatus ="P" THEN 
       lResult = lObjCharge.ChargeMasterBrowse ( Request.Form("hidlComgGrpCode"),Request.Form("hidlContGrpCode"),trim(Bstatus),butAction,"MZE0006000",lResponse,lRec)
	END IF 
	
	
	Dim strLn  'used for finding the line
	Dim strFld 'Used for finding the Columns
	strLn = Split(lResponse,"$") 'here EOL is used to find the End Of File(VbCrlf)
	Dim i 
	Dim FstPipePos  'used to find the First Pipe Character Position
	FstPipePos = InStr(1,lResponse, "|")
	
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
	
	<!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>
    
	<form method="post" name="frmChargeBrowse">
	
	<table border=0 width="90%" align = center >
		<TR>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Contract Code</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Charge Type</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Charge Base on</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Charge Fee</font></th>
			<th class=tdbgdark width="15%"><font class=WhiteBoldtext>Charge Amount</font></th>
			
		</TR>
	</table>
	
<%
If trim(lRec) >= 0  Then
   For i = 0 To UBound(strLn)-1
       strFld = Split(strLn(i), "|")
%>

	<table align="center" width="90%" border="1"  cellspacing="1" cellpadding="1">
		<tr class=tdbglight>
			 <TD width="15%" align="middle">
				<font class=blacktext2><%Response.Write  strFld(2)%></FONT>
				</TD>
				<TD width="15%" align="middle">
					<font class=blacktext2><%if trim(ucase(strFld(3)))= "TC" then
					                                Response.Write "Transaction Charges" 
					                             elseif trim(ucase(strFld(3)))= "CF" then
					                                 Response.Write "Clearing Charges"
					                             elseif trim(ucase(strFld(3)))= "IC" then
					                                 Response.Write "Internet Charges"
					                             elseif trim(ucase(strFld(3)))= "ST" then
					                                 Response.Write "Stamp Duty"
					                             elseif trim(ucase(strFld(3)))= "OC" then
					                                 Response.Write "Other Charges"    
					                             else
					                                 Response.Write "Invalid"
					                             end if
					                                 %></FONT>
				</TD>
				<TD width="15%" align="middle">
					<font class=blacktext2><%if trim(ucase(strFld(4)))= "Q" then
					                                Response.Write "Quantity" 
					                             elseif trim(ucase(strFld(4)))= "V" then
					                                 Response.Write "Value"
					                             elseif trim(ucase(strFld(4)))= "T" then
					                                 Response.Write "Transaction"
					                             
					                             else
					                                 Response.Write "Invalid"
					                             end if%></FONT>
				</TD>
				<TD width="15%" align="middle">
					<font class=blacktext2><%Response.Write  (strFld(5)/100)%></FONT>
				</TD>
				<TD width="15%" align="middle">
					<font class=blacktext2><%Response.Write  (strFld(6)/100)%></FONT>
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
	Next%>
	<%else%>	
	<table width="70%" align=center>
		<tr><td>&nbsp;</td></tr>
			<tr class=tdbgdark><td colspan=2 class="whiteboldtext1">Charge Details</td></tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">Not Available For the Selected Criteria......Click
					<A href=""><b>here</b></A> to view Selection Criteria Page</td></tr>
			<tr><td>&nbsp;</td></tr>
	     </table>
<%
end if%>
<%set lObjCharge=nothing%>
<input type="hidden" name="hidtimeStampPrev" value="<%=gTimeStampPrev%>" >
<input type="hidden" name="hidtimeStamp" value="<%=gTimeStampNext%>">
<input type="hidden" name="hidstatus">
<input type="hidden" name="hidResCode" value="<%=fstPpChar%>">
<input type ="hidden" name="hidlComgGrpCode" value=<%=lCmgGrpCode%>>
<input type="hidden" name="hidlContGrpCode" value=<%=lContGrpCode%>>

<br>
 <table align="center">
	 <tr class=tdbglight height=30 align="center">
		<td>
			<center>
			<input type="button" name="subprevious" Value="Previous" 
			 <%if  lRecCount<1 then Response.write "disabled"%>
   				   onclick="document.frmChargeBrowse.hidstatus.value ='P';
				            document.frmChargeBrowse.method='post';
				            document.frmChargeBrowse.action='ChargeBrowse.asp';
		                    document.frmChargeBrowse.submit();">
		        
								
				<input type="button" name="subNext" value="Next" 
				<%if  lRecCount>0 and lRecCount<10 then Response.write "disabled"%>
				onclick="document.frmChargeBrowse.hidstatus.value ='N';
				document.frmChargeBrowse.method='post';
				document.frmChargeBrowse.action='ChargeBrowse.asp';
		        document.frmChargeBrowse.submit();">
		      </center>
		</td>
			   
	 </tr>
	</table>
	</form>
	<!---#include file="../includes/footer.inc"--->
		</body>	
    </HTML>