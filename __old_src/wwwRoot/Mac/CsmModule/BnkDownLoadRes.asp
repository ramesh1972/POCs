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
	<script language =javascript>
	function FunctionPrevious()
	{
		document.FrmBnkDownLoadBrowse.hidstatus.value ="P";
		document.FrmBnkDownLoadBrowse.method="post";
		document.FrmBnkDownLoadBrowse.action="BnkDownLoadRes.asp";
		document.FrmBnkDownLoadBrowse.submit();
			}
	function FunctionNext()
	{
		document.FrmBnkDownLoadBrowse.hidstatus.value ="N";
		document.FrmBnkDownLoadBrowse.method="post";
		document.FrmBnkDownLoadBrowse.action="BnkDownLoadRes.asp";
		document.FrmBnkDownLoadBrowse.submit();
	}
	
	function FunctionDownLoad()
	{
		document.FrmBnkDownLoadBrowse.method="post";
		document.FrmBnkDownLoadBrowse.action="BnkDownLoad.asp";
		document.FrmBnkDownLoadBrowse.submit();
	}
	function FunctionCancel()
	{
		document.FrmBnkDownLoadBrowse.action="BnkDownLoadSelection.asp";
		document.FrmBnkDownLoadBrowse.submit();
	}	
	</script>
	
	<%
	dim lObjBnkDownLoad
	dim lStartMonth
	dim lStartDay
	dim lstartYear
	dim lStartDate
	dim lResponse
	dim lPrevious
	dim lNext
	dim lRec
	dim lResult
	dim gTimeStamp
	dim gTimeStampPrev
	dim gTimeStampNext
	dim Bstatus
	
    lStartMonth=Request.Form("StartMonth")
    lStartDay=  Request.Form("StartDay")
    lStartYear= Request.Form ("StartYear")  
	   if len(lStartMonth)<=1 then
	      lStartMonth= 0 & lStartMonth
	   end if 
	
       if len(lStartDay) <=1 then
	      lStartDay= 0 & lStartDay
	   end if 
	   lStartDate=lStartYear & "-" & lStartMonth & "-" & lStartDay
	   set lObjBnkDownLoad = server.CreateObject("Mac.ExchMgr")
  %>
   
  <%
	if Request.Form("hidstatus") ="" then
	   Bstatus = "V"
	   gTimeStamp="1900-01-01:00:00:00.000001"
	else
	   Bstatus = Request.Form("hidstatus")
	   gTimeStamp="1900-01-01:00:00:00.000001"
	end if 
	
	
	select case Bstatus
		   case "N":
			     butAction= trim(Request.Form("hidtimeStampNext"))
			     lStartDate=trim(Request.Form("hidStartDate"))
		   case "P":
			     butAction= trim(Request.Form("hidtimeStampPrev"))
			     lStartDate=trim(Request.Form("hidStartDate"))
	       case "V":
		         butAction=gTimeStamp
		   case else:
			     butAction=gTimeStamp
	end select
	lResult  = lObjBnkDownLoad.DoExchBrowse(lStartDate,butAction,Bstatus,lResponse,lRec,lPrevious,lNext)
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
	<form name="FrmBnkDownLoadBrowse" method="post" action="BnkDownLoadRes.asp">
	<!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>
	<%
	Dim strLn  'used for finding the line
	Dim strFld  'Used for finding the Columns
	strLn = Split(lResponse,"$")  'here EOL is used to find the End Of File(VbCrlf)
	if trim(lResult)=0 then%>
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
	for i=0 to ubound(strLn)-1
		strFld=" "
		strFld=split(strLn(i),"|")
	
	%>
   
	<table align="center" width="100%" border="1"  cellspacing="1" cellpadding="1">
		<tr class=tdbglight>
		 <TD width="10%" align="left">
		<TT><font class=blacktext2><%Response.Write  strFld(0)%></TT></FONT></TD>
		<TD width="10%" align="middle"><TT><font class=blacktext2><%Response.Write  strFld(1)%></TT></FONT>	</TD>
		<TD width="20%" align="middle"><TT><font class=blacktext2><%Response.Write  strFld(2)%></TT></FONT></TD>
		<TD width="5%" align="middle"><TT>
		<font class=blacktext2><%if trim(ucase(strFld(3)))= "M" then
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
			
		lRecordCount=lRecordCount+1	
		Next	
	end if
	Response.Write lRecordCount
%>
<br>
<table align="center">
	<tr class=tdbglight height=30 > 
	 <td><input name="btnPrevious" type="Submit" value = "Previous" 
		   <%if  lRecordCount<1 or Bstatus="V" then Response.write "disabled"%>
   			onclick ="FunctionPrevious();">
		  <input name="btnNext"     type="Submit" value = "Next    " 
		  <%if  lRecordCount>0 and lRecordCount<10 then Response.write "disabled"%>
		    onclick ="FunctionNext();">
		  <input name="btnDownLoad"   type="Submit"  value = "DownLoad"   onclick ="FunctionDownLoad();">
		  <input name="btnCancel"   type="Reset"  value = "Cancel"   onclick ="FunctionCancel();">
	</td>
	</tr>
	</TABLE>	
	
	<input type="hidden" name="hidtimeStampPrev" value=<%=lPrevious%>>
	<input type="hidden" name="hidtimeStampNext" value=<%=lNext%>>
	<input type="hidden" name="hidstatus">
	<INPUT TYPE="hidden" name="hidstartDate" value=<%=lstartDate%>>
	</CENTER>
	</form>
	
	<br>
	<!---#include file="../includes/footer.inc"--->
	
	</BODY>
	</HTML>

