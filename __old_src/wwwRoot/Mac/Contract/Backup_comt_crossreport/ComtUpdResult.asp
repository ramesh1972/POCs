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
'dim lObjCharge
dim lObjCharge
dim lResult	
dim lResponse
dim lResultValues
dim lComgCode
dim lContCode
dim lShortDesc
dim lQty
dim lMaop
 
set lObjCharge	=	server.CreateObject("Project1.ComTypeMgr")
lComgCode	= trim(Request.Form("txthidComgCode"))
lContCode	= trim(Request.Form("txthidContCode"))
lShortDesc  = trim(Request.Form ("txthidShortDesc") )
lQty        = trim(Request.Form ("txthidQty") )
lMaop		= trim(Request.Form ("txthidMaop") )
if lComgCode = "" then
lComgCode = 0
end if
if lContCode = "" then
lContCode = 0 
end if
'Response.Write "<BR>Before calling component"
'Response.Write "<BR>Commodity code = " & lComgCode
'Response.Write "<BR>Commodity type = " & lContCode
'Response.Write "<BR>Short desc     = " & lShortDesc
'Response.Write "<BR>Qty            = " & lQty
'Response.Write "<BR>Maop           = " & lMaop

lResult = lObjCharge.DoUpdate ("I",lComgCode,"Short Desc",100,10,lContCode,lContCode)
select case(lResult)
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
	End Select%>
<center>
<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Commodity Type  Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="ComtMenu.asp">here</a> to view previous page</font>
	</td></tr>
</table>
</center>		
<br><br>
<!---#include file="../includes/footer.inc"--->
</form>
</body>
</HTML>

















