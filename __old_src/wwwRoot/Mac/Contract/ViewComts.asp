<%@Language=VBScript %>

<% Option Explicit

    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Contract											  *
	'* File name	:	ViewComts.asp			       					      *
	'* Purpose		:	This page shows all commodity types					  *
	'* Prepared by	:	Majo												  *		
	'* Date			:	3.1.2002			 								  *
	'* Copyright	:	(c) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page shows all commodity types									  *	
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.- Date		- By				   - Explanation	   	  *
	'*	1		                -Majo                    First Baseline       *
	'**************************************************************************
%>	
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
	<!---#include file="../includes/header.inc"--->
	<br>
<!---#include file="../includes/MACLinks.inc"--->
	<br>
<%
dim lObjCharge
dim lResult
set lObjCharge	=	server.CreateObject("Mac.ComTypeMgr")
'lResult = lObjCharge.ChargeMasterNormalView("MZE0006000",Request.Form("optComgCode"),Request.Form("optComgType"),Request.Form("optChrgType"))
%>
<table width="85%" align="center" border=1>
	<tr class=tdbgdark height=10 align=middle>
		<td colspan=2 align="left"><font class=whiteboldtext1>Types View</font></FONT></td>
	</tr>
	<tr class=tdbglight height=20 align=left>
		<!--td colspan=2><A href="ChargeMaster.asp"><font class=blacktext>Charges View is Under Construction</font></a></td-->
		<td colspan=2><A href="ComtMaster.asp"><font class=blacktext>View all Commodity Types</font></a></td>
	</tr>
</table>
<br><br>
<!---#include file="../includes/footer.inc"--->
</body>
</HTML>


















