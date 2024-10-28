<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Mac Module  									      *
	'* File name	:	ContBuildUpd.asp									  *
	'* Purpose		:	This page will display the menu for Contract Details  * 
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
	'*	1		   16.11.2001	Obula Reddy	              First Baseline      *
	'*																		  *
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
	<table width="85%" align="center" border=1>
		<tr class=tdbgdark height=10 align=middle>
			<td colspan=2 align="left"><font class=whiteboldtext1>Contract Information </font></FONT></td>
		</tr>
	
		<tr class=tdbglight height=20 align=left>
			<td><A href="ContractBuilder.asp?Mode=A"><font class=blacktext><li>Add  Contract Information</font></LI></a></td>
			<td><A href="ContBuildView.asp?Mode=V"><font class=blacktext><li>View   Contract Information</font></LI></a></td>
		</tr>
  	
  		<tr class=tdbglight height=20 align=left>
	   		<td><A href="ContBuildUpd.asp?Mode=U"><font class=blacktext><li>Update   Contract Information</font></LI></a></td>
			<td><A href="ContBuildView.asp?Mode=D"><font class=blacktext><li>Delete   Contract Details</font></LI></a></td>
		</tr>
	</table>
	<br><br>
	<%'end if%>
	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















