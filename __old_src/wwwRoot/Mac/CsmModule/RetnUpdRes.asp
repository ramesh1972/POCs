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
	
	    if(document.frmRetnUpd.txtRetAmt.value==""){
			alert("Enter Retention Amount")
			document.frmRetnUpd.txtRetAmt.focus()
			return false;}
		if(document.frmRetnUpd.txtRetAmt.value<0){
			alert("Charge Fee Cannot be Negative")
			document.frmRetnUpd.txtRetAmt.focus()
			return false;}
		if (isNaN(document.frmRetnUpd.txtRetAmt.value)==true){
			alert("Retention Amount  Fee Should have only Numerals");
			return false;}
		if (isNaN(document.frmRetnUpd.txtRetPenAmt.value)==true){
			alert("Retention Penality Amount Should have only Numerals");
			return false;}
		if(document.frmRetnUpd.txtRetPenAmt.value==""){
			alert("Enter Retention Penality Amount")
			document.frmRetnUpd.txtRetPenAmt.focus()
			return false;}
		if(document.frmRetnUpd.txtRetPenAmt.value<0){
			alert("Retention Penality  Amount Cannot be Negative")
			document.frmRetnUpd.txtRetPenAmt.focus()
			return false;}
		else{
			document.frmRetnUpd.action="RetnUpdResult.asp";
			document.frmRetnUpd.method="post";
			document.frmRetnUpd.submit(); }}
		else if(i==2) {
			document.frmRetnUpd.action="RetnMenu.asp";
			document.frmRetnUpd.submit(); }
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
	<form name=frmRetnUpd action="RetnUpdResult.asp" method=post>
	<!---#include file="../includes/header.inc"--->
	<br>
<!---#include file="../includes/MACLinks.inc"--->
	<br>
<%
dim lObjRetn
dim lResult	
dim lResultValues
dim lUserId
dim lRec
dim lResponse
dim strlen
dim lRetPenAmount
	
	lUserId	= trim(Request.Form("optUserId"))
	set lObjRetn	=	server.CreateObject("Mac.RetentionMgr")
	lResult = lObjRetn.DoView(trim(lUserId),"V","1900-01-01:00:00:00.123456","2002-01-01","2002-02-28",cdbl(lRec),lResponse)
	
	lResultValues = split(lResponse,"|")
	lRetPenAmount =split(lResultValues(3),"$")
 if lResult=0 then
 %>	

<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Retention  Master View</td>
		
	</tr>

	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>User Id & Name</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lResultValues(1)%>
    </tr>

         

    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Retention Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=txtRetAmt value=<%=lResultValues(2)/100%>>
    </tr>
    
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Retention Penality Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=txtRetPenAmt value=<%=lRetPenAmount(0)/100%>>
      </tr>
   	
    
    <tr>
    <td  colspan=2 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtUpdChrg"   value="Update    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
	</tr>

</table>	
<input type=hidden name=opthidUserId value=<%=lResultValues(1)%>>
<input type=hidden name=txthidRetAmt value=<%=lResultValues(2)%>>
<input type=hidden name=txthidRetPenAmt value=<%=lRetPenAmount(0)%>>

<%else%>
<center>
		<table width="80%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Charge Master View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Users  available for the selected cirteria. Click <a href="RetnView.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</form>
	</body>
	</HTML>


















