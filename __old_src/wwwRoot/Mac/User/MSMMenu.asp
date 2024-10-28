<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading											      *
	'* File name	:	UsrCompMenu.asp										  *
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
	<body border="1" cellspacing="1" cellpadding"1" topmargin="1" bottommargin="1">
	<!---#include file="../includes/header.inc"--->
	<br><!--#include file="../Includes/MACLinks.inc" ----><br>
	<form name=frmUsrCompMenu method=post  >
	<br>
	<%'if lUserType="M" then %>
		<table width="85%" align="center" border=1>
			<tr class=tdbgdark height=10 align=middle>
				<td colspan=2 align="left"><font class=whiteboldtext1>Market Session Management</font></FONT></td>
			</tr>
			<tr class=tdbglight height=20 align=left>
				<td><A href="MSMView.asp"><font class=blacktext><li>Browse</font></LI></a></td>
				<td><a href="Javascript:document.frmUsrCompMenu.lMode.value='V';document.frmUsrCompMenu.action='UsrCompDetView.asp';document.frmUsrCompMenu.submit();"> <font class=blacktext><li>Add</font></li></a></td>
			</tr>
  			<tr class=tdbglight height=20 align=left>
	    		<td ><a href="Javascript:document.frmUsrCompMenu.lMode.value='U';document.frmUsrCompMenu.action='MSMView.asp';document.frmUsrCompMenu.submit();"> <font class=blacktext><li>Update</font></li></a></td>
				<td><A href="ChargeView.asp?Mode=D"><font class=blacktext><li>Halt</font></LI></a></td>
			</tr>
			<input type=hidden name=lMode>
		</table>
	<br><br>
	<%'end if%>
	</form> 
	</body>
	</HTML>


