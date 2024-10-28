<%@Language=VBScript %>

<% Option Explicit

    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Contract											  *
	'* File name	:	ReportCrossingResult.asp       					      *
	'* Purpose		:	This pages shows the result of crossing.			  *	
	'* Prepared by	:	Majo												  *		
	'* Date			:	3.1.2002			 								  *
	'* Copyright	:	(c) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page shows the result of crossing.								  *
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
<%
'dim lObjCharge
dim lObjCharge
dim lResult	
dim lResponse
dim lResultValues
dim lQty
dim lPrice
dim lContCode
dim lTcmId
dim lIcmId
dim lOrderB
dim lClientB
dim lOrderS
dim lClientS
dim lprefixno
dim linstrno 

set lObjCharge	=	server.CreateObject("Mac.RptCrossMgrImpl")
lQty		= trim(Request.Form ("txtQty") )
lPrice		= trim(Request.Form ("txtPrice") )
lContCode	= trim(Request.Form ("OptContCode") )
lTcmId		= trim(Request.Form ("OptTcmId") )
lIcmId		= trim(Request.Form ("OptIcmId") )
lOrderB		= trim(Request.Form ("txtOrderB") )
lClientB	= trim(Request.Form ("OptClientB") )
lOrderS		= trim(Request.Form ("txtOrderS") )
lClientS	= trim(Request.Form ("OptClientS") )

lPrice		= lPrice * 100
'lResult = lObjCharge.DoMatch (10, 22000, 6, "1000000", "1111111", "TSH0029000", "TSH0029000", "TSH0029000", "TSH0029000", "TSH0029000", "TSH0029000", lprefixno, linstrno)
'lResult = lObjCharge.DoMatch (5, 5, 2, 4, 4, "CPR0001000", "CPR0001000", "TNA0001000", "TNA0001000", "IKA0001000", "IKA0001000", lprefixno, linstrno)
lResult = lObjCharge.DoMatch (lQty,lPrice,lContCode,lOrderB,lOrderS,lClientB,lClientS,lTcmId,lTcmId,lIcmId,lIcmId, lprefixno, linstrno)
'lResult = lObjCharge.DoMatch (lQty,lPrice,6,"111111","111112","TSH0029000","TSH0029000","TSH0029000","TSH0029000","TSH0029000","TSH0029000",lprefixno, linstrno)
'Response.Write "<BR>Response = " & lResult
'Response.Write "<BR>Prefix = " & lprefixno
'Response.Write "<BR>Instrument No = " & linstrno
select case(lResult)
	case "0":
		lResponse = "The Trade has been Accepted"
	case "100":
		lResponse = "The Record does not Exist"
	case "9818":
		lResponse = "Maop Violation"
	case "9038":
		lResponse = "Circuit filter violation"
	case "9009":
		lRespones = "Invalid Price"
	case "9143":
		lResponse = "Order Rejected"
	case "9130":
		lResponse = "Settlement circuit filter violation"
	case "9134":
		lResponse = "Circuit filter violation"
	case "9002":
		lResponse = "Invalid Trading Session"
	case "9008":
		lResponse = "Invalid Quantity"
	case "9005":
		lResponse = "Invalid Book Type"
	case "9582":
		lResponse = "Invalid Trading Session"
	case "9139":
		lResponse = "Invalid ICM"
	case "9019":
		lResponse = "Unknown Company"
	case "9099":
		lResponse = "Internal Problem"				
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
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Report Crossing Details</font></td></tr>
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


















