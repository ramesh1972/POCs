<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading											      *
	'* File name	:	MacMarket.asp										  *
	'* Purpose		:	This page will display the menu for MAC User	      * 
	'* Prepared by	:	V.Christopher Britto  							      *
	'* Date			:	16.11.2001			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to display menu for MAC Contracts         				  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   16.11.2001	V.Christopher Britto	  First Baseline      *
	'*																		  *
	'**************************************************************************
'	dim lUserType
'	lUserType=Request.Cookies("UserType")
	%>	
		<script language="Javascript">
	
	function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
		document.frmChrgView.action="ChargeDelRes.asp";
		document.frmChrgView.method="post";
		document.frmChrgView.submit(); }
	else if(i==2) {
		document.frmChrgView.action="ChargeMenu.asp";
		document.frmChrgView.submit(); }
	}
	</script>

	<HTML>
	<HEAD>
		<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
	</HEAD>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="frmChrgView" method="post">
	<!---#include file="../includes/header.inc"--->
	<br>
<!---#include file="../includes/MACLinks.inc"--->
	<br>
	<%
	dim lObjCharge
	dim lResult	
	dim lResultValues
	
 dim lComgCode
 dim lContCode
 dim lChrgType
 dim lChargeBase
 dim lCharge
 dim lAmount
 lComgCode	= trim(Request.Form("optComgCode"))
 lContCode	= trim(Request.Form("optContCode"))
 lChrgType  = trim(Request.Form("optChrgType"))
 
set lObjCharge	=	server.CreateObject("Mac.ChargeMasterMgr")
lResult = lObjCharge.ChargeMasterView(lComgCode,lContCode,lChrgType,Request.Cookies("UserId"),lChargeBase,lCharge,lAmount)
'Response.Write  "Result = " & lResult
 
'lResultValues = split(lResult,"|")
'Response.Write "<br>" & lResultValues(1)

if lResult=0 then
%>	

<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Charge Master View</td>
		
	</tr>

	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Comg Grp Code</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lComgCode%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Contract Name</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lContCode%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge Type</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <%if trim(ucase(lChrgType))="IC" then 
			Response.Write "Internet Charges"
		elseif trim(ucase(lChrgType))="TC" then 
			Response.Write "Transaction Charges"
		elseif trim(ucase(lChrgType))="CF" then 
			Response.Write "Clearing Fee"
		elseif trim(ucase(lChrgType))="ST" then 
			Response.Write "Stamp Duty"
		elseif trim(ucase(lChrgType))="OC" then 
			Response.Write "Other Charges"
		end if%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge Base</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <%if trim(ucase(lChargeBase))="Q" then 
			Response.Write "Quantity"
		elseif trim(ucase(lChargeBase))="V" then 
			Response.Write "Value"
		elseif trim(ucase(lChargeBase))="T" then 
			Response.Write "Transaction"
		end if%>
	
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge Fee</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=(lCharge/100)%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=(lAmount/100)%>
    </tr>

<% if Request.Form("txthidMode")="D" then%>
	<tr>
      <td  colspan=2 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtDelChrg"   value="Delete    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
    </tr>
    <input type=hidden name=txthidComgCode value=<%=trim(Request.Form("optComgCode"))%>>
<input type=hidden name=txthidContCode value=<%=trim(Request.Form("optContCode"))%>>
<input type=hidden name=txthidChrgType value=<%=trim(Request.Form("optChrgType"))%>>
<%end if%>
</table>			
<%else%>
<center>
		<table width="80%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Charge Master View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Charge Details available for the selected cirteria. Click <a href="ChargeView.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















