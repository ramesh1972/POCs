<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading											      *
	'* File name	:	MacContract.asp										  *
	'* Purpose		:	This page will display the menu for MAC User	      * 
	'* Prepared by	:	V.Christopher Britto   							      *
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
				<td colspan=2 align="left"><font class=whiteboldtext1>Contract</font></FONT></td>
			</tr>
			<tr class=tdbglight height=20 align=left>
				<td><A href="TradeView.asp"><font class=blacktext><li>Contract Builder</font></LI></a></td>
				<td><A href="MarketMenu.asp"><font class=blacktext><li>Contract Maintenance </font></LI></a></td>
			</tr>
  			<tr class=tdbglight height=20 align=left>
	    		<td><A href="MarketMenu.asp"><font class=blacktext><li>Market contracts</font></LI></a></td>
				<td><A href="ReportCrossing.asp"><font class=blacktext><li>Report Crossing</font></LI></a>
				</td>
			</tr>
			<tr class=tdbglight height=20 align=left>
	    		<td><A href="ComgMenu.asp"><font class=blacktext><li>Commodity Group Master</font></LI></a></td>
				<td><A href="ComtMenu.asp"><font class=blacktext><li>Commodity Type Master</font></LI></a>
				</td>
			</tr>
			<!--tr class=tdbglight height=20 align=left>
	    		<td><A href="DownLoadManual.asp"><font class=blacktext><li>Unit Of Measurement</font></LI></a></td>
				<td><A href="Tradedetails.asp"><font class=blacktext>&nbsp;</font></a>
				</td>
			</tr-->
			
		</table>
	<br><br>
	<%'end if%>
	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>
