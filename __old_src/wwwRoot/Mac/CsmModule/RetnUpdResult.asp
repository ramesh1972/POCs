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
	dim lObjRetn
	dim lUserID
	dim lRetAmt
	dim lRetPenAmt
	dim lResult	
	dim lResultValues
	dim lResponse
	
	lUserId	  = trim(Request.Form("opthidUserId"))
	lRetAmt	  = trim(Request.Form("txtRetAmt"))
	lRetPenAmt= trim(Request.Form("txtRetPenAmt"))
		
 	set lObjRetn	=	server.CreateObject("Mac.RetentionMgr")
	lResult =lObjRetn.DoUpdate(trim(lUserId),lRetAmt*100,lRetPenAmt*100)	 
	
	select case(lresult)
		   case "0":
				lResponse = "The Record has been Updated"
		  case "100":
				lResponse = "The Record does not Exist"
		  case "1800":
			    lResponse = "The System Date doesn't match"
		 case "1000":	
				lResponse = "Branch Code does not Exist"	
		case "1100":
			lResponse = "The Record already exists"
		case "9598":
			lResponse = "The Connection to the Server cannot be established"
		default
			lResponse = "Connection Failed.. Please try again later."
	End Select%>
<center>
<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Retention Master  Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="RetnMenu.asp">here</a> to view previous page</font>
	</td></tr>
</table>
</center>		
<br><br>
<!---#include file="../includes/footer.inc"--->
</form>
</body>
</HTML>

















