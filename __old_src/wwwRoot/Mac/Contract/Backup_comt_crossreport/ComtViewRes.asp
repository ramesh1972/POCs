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
		document.frmChrgView.action="ComtDelRes.asp";
		document.frmChrgView.method="post";
		document.frmChrgView.submit(); }
	else if(i==2) {
		document.frmChrgView.action="ComtMenu.asp";
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
	dim lResponse
	dim lResultValues
	
 dim lComgCode
 dim lContCode
 dim lChrgType
 dim lShortDesc
 dim lQty
 dim lMaop
 lComgCode	= trim(Request.Form("optComgCode"))
 lContCode	= trim(Request.Form("optContCode"))
set lObjCharge	=	server.CreateObject("Project1.ComTypeMgr")
if lComgCode = "" then
lComgCode = 0
end if
if lContCode = "" then
lContCode = 0 
end if
lResult = lObjCharge.DoBrowse  ("I",lComgCode,lContCode,lContCode,lShortDesc,lMaop,lQty)
select case(lResult)
	case "1000":
		lResponse = "Invalid Type"
	case "1100":
		lResponse = "Invalid Group"
	case "1498":
		lResponse = "Type can not be deleted."
	case "1499":
		lResponse = "Invalid Exchange"
	case "1800":
		lResponse = "The System Date doesn't match"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	case else
		lResponse = "Error in record browse"
End Select%>

<%
lResultValues = split(lResult,"|")
'Response.Write "<br>" & lResultValues(1)

if lResultValues(0)=0 then
%>	

<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Commodity Type View</td>
		
	</tr>

	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Comg Grp Code</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lComgCode%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Commdity Type Name</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lContCode%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Short Description</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lShortDesc%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Quantity</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lQty%>
    </tr>

    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>MAOP</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lMaop%>
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
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Commodity Type View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Type Details available for the selected cirteria. Click <a href="ComtView.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















