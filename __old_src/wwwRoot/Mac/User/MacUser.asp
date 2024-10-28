<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading											      *
	'* File name	:	MacUser.asp											  *
	'* Purpose		:	This page will display the menu for MAC User	      * 
	'* Prepared by	:	V.Christopher Britto   							      *
	'* Date			:	16.11.2001			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to display menu for MAC User	         				  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   16.11.2001	V.Christopher Britto	  First Baseline      *
	'*																		  *
	'**************************************************************************
	dim lUserType
	lUserType=Request.Cookies("UserType")
	%>	

	<HTML>
	<HEAD>
		<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<title>Welcome to the bombay oilseeds and oils exchange limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
	</HEAD>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<!---#include file="../includes/header.inc"--->
	<br><!--#include file="../Includes/MACLinks.inc" ----><br>
	<%'if lUserType="M" then %>
		<table width="85%" align="center" border=1>
			<tr class=tdbgdark height=10 align=middle>
				<td colspan=2 align="left"><font class=whiteboldtext1>User</font></FONT></td>
			</tr>
			<tr class=tdbglight height=20 align=left>
				<td><A href="UsrCompMenu.asp"><font class=blacktext><li>User and company Maintenance</font></LI></a></td>
				<td><A href="PwdMaint.asp"><font class=blacktext><li>Logon and Password Maintenance </font></LI></a></td>
			</tr>
  			<tr class=tdbglight height=20 align=left>
	    		<td><A href="UsrCompBrowse.asp"><font class=blacktext><li>User and Company Browse</font></LI></a></td>
				<td><A href="MacPwdChange.asp"><font class=blacktext><li>User Password Change</font></LI></a>
				</td>
			</tr>
		</table>
	<br><br>
	<%'end if%>
	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>
