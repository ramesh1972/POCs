<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Mac Module  									      *
	'* File name	:	ContBuildDelRes.asp										  *
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
   Dim lRespCode
   Dim lConCode
   Dim lObjConBuldr
   Set lObjConBuldr = Server.CreateObject("Project1.InstrumentMgr")
   lConCode			= Request.Form("OptContCode")
   lRespCode = lObjConBuldr.DoDelete(lConCode,"MAS0001000")
   select case(lRespCode)
	case "0":
		lRespCode = "The Record has been Deleted"
	case "100":
		lRespCode = "The Record does not Exist"
	case "1800":
		lRespCode = "The System Date doesn't match"
	case "1000":	
		lRespCode = "Branch Code does not Exist"	
	case "1100":
		lRespCode = "The Record already exists"
	case "9598":
		lRespCode = "The Connection to the Server cannot be established"
End Select%>
<center>
<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Contract  Details </font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lRespCode%>. Click <a href="ContBuildMenu.asp">here</a> to view previous page</font>
	</td></tr>
</table>
</center>		
<br><br>
<!---#include file="../includes/footer.inc"--->
</form>
</body>
</HTML>

















