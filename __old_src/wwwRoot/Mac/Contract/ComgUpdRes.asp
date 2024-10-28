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
	    if(document.frmComgUpd.txtComgDesc.value==""){
			alert("Enter Commodity Group Description")
			document.frmComgUpd.txtComgDesc.focus()
			return false;}
		if(document.frmComgUpd.txtShortComgDesc.value==""){
			alert("Enter Commodity Group Short Description")
			document.frmComgUpd.txtShortComgDesc.focus()
			return false;}
		else{
	   		document.frmComgUpd.action="ComgUpdResult.asp";
			document.frmComgUpd.method="post";
			document.frmComgUpd.submit(); }}
		else if(i==2) {
			document.frmComgUpd.action="ComgMenu.asp";
			document.frmComgUpd.submit(); }
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
	<form name=frmComgUpd action="ComgUpdResult.asp" method=post>
	<!---#include file="../includes/header.inc"--->
	<br>
<!---#include file="../includes/MACLinks.inc"--->
	<br>
<%
dim lObjComg
dim lResult	
dim lResultValues
dim lComgCode
dim lComgDesc
dim lComgShortDesc
dim lExchange
lComgCode	= trim(Request.Form("optComgCode"))
set lObjComg	=	server.CreateObject("Mac.COMgroupMgr")
lResult = lObjComg.DoView("V",lComgCode,lComgDesc,lComgShortDesc,"N",lExchange)

if lResult=0 then
%>	

<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Commodity Group Master View</td>
		
	</tr>

	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Comg Grp Code</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lComgCode%>
    </tr>

         

    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Commodity Group Description</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=txtComgDesc value=<%=lComgDesc%>>
    </tr>
    
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Commodity Short Description</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=txtShortComgDesc value=<%=lComgShortDesc%>>
      </tr>
   	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Exchange</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=optExchange value=<%=lExchange%>>
        
     </tr>

    <tr>
    <td  colspan=2 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtUpdChrg"   value="Update    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
	</tr>

</table>	
<input type=hidden name=opthidComgCode value=<%=trim(Request.Form("optComgCode"))%>>
<input type=hidden name=txthidComgDesc value=<%=trim(Request.Form("txtComgDesc"))%>>
<input type=hidden name=txthidComgShortDesc value=<%=trim(Request.Form("txtComgShortDesc"))%>>
<input type=hidden name=opthidExchange value=<%=trim(Request.Form("optExchange"))%>>

<%else%>
<center>
		<table width="80%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Commodity Group Master  View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Commodity Group available for the selected cirteria. Click <a href="ComgView.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</form>
	</body>
	</HTML>


















