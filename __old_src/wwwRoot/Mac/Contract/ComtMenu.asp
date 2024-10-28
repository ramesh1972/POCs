<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:   Mac Module											  *
	'* File name	:	ComtMenu.asp               							  *
	'* Purpose		:	This page will display the main menu for commodity    * 
	'                   type.												  *
	'* Prepared by	:	Majo												  *		
	'* Date			:	3.1.2002			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page displays all the options (add/mod/del/view) on commodity     *
	'* type.																  *	
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
		<table width="85%" align="center" border=1>
			<tr class=tdbgdark height=10 align=middle>
				<td colspan=2 align="left"><font class=whiteboldtext1>Commodity Type Master</font></FONT></td>
			</tr>
			<tr class=tdbglight height=20 align=left>
				<td><A href="ComtAdd.asp"><font class=blacktext><li>Add Commodity Type</font></LI></a></td>
				<td><A href="ComtView.asp?Mode=V"><font class=blacktext><li>View Commodity Type</font></LI></a></td>
			</tr>
  			<tr class=tdbglight height=20 align=left>
	    		<td><A href="ComtUpd.asp"><font class=blacktext><li>Update Commodity Type</font></LI></a></td>
				<td><A href="ComtView.asp?Mode=D"><font class=blacktext><li>Delete Commodity Type</font></LI></a></td>
			</tr>
		</table>
	<br><br>
	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















