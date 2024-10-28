<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Mac Module											  *
	'* File name	:	ComgMenu.asp										  *
	'* Purpose		:	This page will display the menu for Commodity Group   * 
	'* Prepared by	:	Obula Reddy         							      *
	'* Date			:	12.12.2001			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to display menu for Commodity Groups       				  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   12.12.2001	Obula Reddy	              First Baseline      *
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
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>
	
	<%'if lUserType="M" then %>
		<table width="85%" align="center" border=1>
			<tr class=tdbgdark height=10 align=middle>
				<td colspan=2 align="left"><font class=whiteboldtext1>Commodity Group</font></FONT></td>
			</tr>
			<tr class=tdbglight height=20 align=left>
				<td><A href="ComgAdd.asp"><font class=blacktext><li>Add Commodity Group</font></LI></a></td>
				<td><A href="ComgView.asp?Mode=V"><font class=blacktext><li>View Commodity Group</font></LI></a></td>
			</tr>
  			<tr class=tdbglight height=20 align=left>
	    		<td><A href="ComgUpd.asp"><font class=blacktext><li>Update Commodity Group</font></LI></a></td>
				<td><A href="ComgView.asp?Mode=D"><font class=blacktext><li>Delete Commodity Group</font></LI></a></td>
			</tr>
			<!--tr class=tdbglight height=20 align=left>
	    		<td><A href="ViewComgs.asp"><font class=blacktext><li>View All Commodity Groups</font></LI></a></td>
				<td>&nbsp;</td>
			</tr>-->
		</table>
	<br><br>
	<%'end if%>
	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















