<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC Module      								      *
	'* File name	:	ComtDelRes.asp										  *	
	'* Purpose		:	This page will display the result					  *	
	'					for commodity type delete							  *	
	'* Prepared by	:	Majo												  *		
	'* Date			:	3.1.2002			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to display the result for commodity type delete			  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
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
dim lObjCharge
dim lResult	
dim lResultValues
dim lResponse
dim lComgCode
dim lContCode
 
set lObjCharge	=	server.CreateObject("Mac.comtMgr")
lComgCode = trim( Request.Form("txthidComgCode") )
lContCode = trim( Request.form("txthidContCode") )
if lComgCode = "" then
lComgCode = 0
end if
if lContCode = "" then
lContCode = 0 
end if
lResult = lObjCharge.DoDelete ("D",lComgCode, lContCode)
select case(lResult)
	case "0":
		lResponse = "The Record has been Deleted"
	case "100":
		lResponse = "The Record does not Exist"
	case "1800":
		lResponse = "The System Date doesn't match"
	case "1000":	
		lResponse = "Commodity Type does not Exist"	
	case "1100":
		lResponse = "Commodity Group does not Exist"	
	case "1498":
		lResponse = "Type can not be deleted."
	case "1499":
		lResponse = "Invalid Exchange"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	default
		lResponse = "Connection Failed.. Please try again later."
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


















