<%@ Language=VBScript%>
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
dim lObjChgUpdate
dim lSplitComgCode
dim lComgCode
dim lContCode
dim lChrgType
dim lChrgBase
dim lChrgFee
dim lChrgAmt
dim lResult
dim lResponse
	
set lObjChgUpdate	= server.CreateObject("Mac.ChargeMasterMgr")
lSplitComgCode	= split(Request.Form("optComgCode"),"|")
lComgCode=lSplitComgCode(1)
lContCode	= trim(Request.Form("optContCode"))
lChrgType	= trim(Request.Form("optChrgType"))
lChrgBase	= trim(Request.Form("optChrgBase"))
lChrgFee	= trim(Request.Form("txtChrgFee"))
lChrgAmt	= trim(Request.Form("txtChrgAmt"))
lChrgFee=lChrgFee*100
lChrgAmt=lChrgAmt*100
		 
lResult	=	lObjChgUpdate.ChargeMasterAdd(cstr(lComgcode),lContCode,lChrgType,lChrgBase,lChrgFee,lChrgAmt,Request.Cookies("Userid"))
Response.Write "lresult=" & lResult
select case(lResult)
	case "0":
		lResponse = "The Record has been Added"
	case "1800":
		lResponse = "The System Date doesn't match"
	case "1100":
		lResponse = "The Record already exists"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	case "57309":
		lResponse = "Record Already Exists"
End Select%>

<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Charge  Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="ChargeMaster.asp">here</a> to view the previous page</font>
	</td></tr>
</table>
		

<P>&nbsp;</P>

	<!---#include file="../includes/footer.inc"--->
	<br>
	
	
</BODY>
</HTML>


