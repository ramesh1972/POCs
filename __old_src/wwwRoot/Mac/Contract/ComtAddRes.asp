<%@ Language=VBScript%>
<%
    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Contract											  *
	'* File name	:	ComtMasterUpdate.asp           					      *
	'* Purpose		:	This page displays commodity type update screen.	  *
	'* Prepared by	:	Majo												  *		
	'* Date			:	3.1.2002			 								  *
	'* Copyright	:	(c) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page displays update operation on commodity type				  *
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
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
 <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
</HEAD>
<BODY marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
<center>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->
	<br><br>
	
<%
dim lObjComtAdd
dim lSplitComgCode
dim lComgCode
dim lContType
dim lQty
dim lMaop
dim lResult
dim lResponse


set lObjComtAdd		= server.CreateObject("Mac.ComtMgr")
lSplitComgCode		= split(Request.Form("optComgCode"),"|")
lComgCode			= lSplitComgCode(0)
lComtType			= trim(Request.Form("txtComtType"))
lQty				= trim(Request.Form("txtQty"))
lMaop   			= trim(Request.Form("txtMaop"))
lResult				= lObjComtAdd.DoInsert("I",lComgCode,lComtType,lMaop,lQty,"test",lContCode)
Response.Write lResult	
Response.Write lContCode
select case(lResult)
	case "0":
		lResponse = "The Record has been Added"
	case "1000":
		lResponse = "Invalid Type"
	case "1100":
		lResponse = "Invalid Group"
	case "1498":
		lResponse = "Some unexpired instruments are available"
	case "1499":
		lResponse = "Invalid Exchange"
	case "1800":
		lResponse = "The System Date doesn't match"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	case "57309":
		lResponse = "Record Already Exists"
	case default:
		lResponse = "Error in record addition"
End Select%>

<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Commodity Type Details</font></td></tr>

	<tr width="40%">
	<td class=tdbglight>
	<font style="color:blue;">The System Generated Commodity type code is <%=lContCode%></font>
	</td>
	</tr>

	<tr width="40%">
	<td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="ComtMenu.asp">here</a> to view the previous page</font>
	</td>
	</tr>
	
</table>
		

<P>&nbsp;</P>

	<!---#include file="../includes/footer.inc"--->
	<br>
	
	
</BODY>
</HTML>


