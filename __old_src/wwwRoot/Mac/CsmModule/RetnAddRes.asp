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

	dim lObjRetnUpdate
	dim lUserId
	dim lRetAmt
	dim lRetPenAmt
	dim lResult
	dim lResponse
	set lObjRetnUpdate	= server.CreateObject("Mac.RetentionMgr")

	lUserId	        = trim(Request.Form("optUserId"))
	lRetAmt	        = trim(Request.Form("txtRetAmt"))
	lRetPenAmt  	= trim(Request.Form("txtRetPenAmt"))
		   
	lResult	=	lObjRetnUpdate.DoInsert(trim(lUserId),cdbl(lRetAmt)*100,cdbl(lRetPenAmt)*100)	
	Response.Write lResult
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
	case "8227"
		lResponse = "Duplicate Record not allowed in the same day"
End Select%>

<Table width="40%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Retention Master Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%> Click <a href="RetnAdd.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
		
	
<P>&nbsp;</P>

	<!---#include file="../includes/footer.inc"--->
	<br>
	
	
</BODY>
</HTML>


