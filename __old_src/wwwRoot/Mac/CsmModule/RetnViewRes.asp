<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	MAC		    										  *
	'* Module		:	MAC module										      *
	'* File name	:	RetnViewRes.asp										  *
	'* Purpose		:	This page will display the menu for MAC User	      * 
	'* Prepared by	:	Obula Reddy         							      *
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
	'*	1		   16.11.2001	Obula Reddy	  First Baseline                  *
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
		document.frmChrgView.action="RetnDelRes.asp";
		document.frmChrgView.method="post";
		document.frmChrgView.submit(); }
	else if(i==2) {
		document.frmChrgView.action="RetnMenu.asp";
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
	dim lObjRetn
	dim lResult	
	dim lResultValues
	dim lUserId
	DIM lRec
	DIM Res
	dim strlen
	dim lResponse
	dim lRetpenamount
   
    lUserId	= trim(Request.Form("OptUserId"))
    set lObjRetn	= server.CreateObject("Mac.RetentionMgr")
	lResult = lObjRetn.DoView(trim(lUserId),"V","1900-01-01:00:00:00.000001","2001-01-01","2002-02-28",cdbl(lRec),lResponse)
    lResultValues = split(lResponse,"|")
	lRetpenamount=split(lResultValues(3),"$")
	if lResult=0 then
  
%>	

<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="100">
	
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Retention Master View</td>
		
	</tr>

	<tr>
      <td class=tdbglight width=50% height="25"><font class=blacktext>User ID</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lResultValues(1)%>
    </tr>
    <tr>
      <td class=tdbglight width=50% height="25"><font class=blacktext>Retention Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lResultValues(2)/100%>
    </tr>
    <tr>
      <td class=tdbglight width=50% height="25"><font class=blacktext>Retention Penality Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lRetpenamount(0)/100%>
       </tr>
    
<% if Request.Form("txthidMode")="D" then%>
	<tr>
      <td  colspan=2 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtDelChrg"   value="Delete    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
    </tr>
 <input type=hidden name=txthidUserId value=<%=trim(Request.Form("optUserId"))%>>
<%end if%>
</table>			
<%else%>
<center>
		<table width="80%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Comg  Master View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Commodity Groups  Details available for the selected cirteria. Click <a href="ChargeView.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















