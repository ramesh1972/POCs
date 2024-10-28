<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading											      *
	'* File name	:	Activities.asp										  *
	'* Purpose		:	This page will display the menu for Activities	      * 
	'* Prepared by	:	V.Christopher Britto   							      *
	'* Date			:	16.11.2001			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page will display the menu for Activities         				  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		  16.11.2001  V.Christopher Britto        First Baseline      *
	'*																		  *
	'**************************************************************************
	dim lUserType
	
	lUserType=Request.Cookies("UserType")
	Response.Write lUserType
	%>	
	
	<HTML>
	<HEAD>
	<style>
		a {text-decoration:none}
		a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
	</HEAD>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--#include file="../Includes/MACLinks.inc" ---->
	<br>
	<%'If lUserType="M" then %>
		<table width="40%" align="center" border="1"  cellspacing="1" cellpadding="1" >
		<tr class=tdbgdark height=10 align=middle>
			<td  align="left"><font class=whiteboldtext1>Activities</font></FONT></td>
		</tr>
		<tr class=tdbglight height=20 align=left>
			<td align="left" width="40%"><A href="auditLog.asp"><font class=blacktext><li>Audit Log</font></LI></a></td>
		</tr>
		<tr class=tdbglight height=20 align=left>
			<td align="left" width="40%"><A href="AuditTrailView.asp" ><font class=blacktext><li>Audit Trial</font></LI></a></td>
		</tr>
		<tr class=tdbglight height=20 align=left>
			<td><A href="TradeView.asp"><font class=blacktext><li>Download</font></LI></a></td>
		</tr>
		</table>
	<br><br>
	<%'end if%>
	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


