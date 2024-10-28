<%@ Language=VBScript%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
</HEAD>
<BODY marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
<center>
	<!---#include file="../includes/header.inc"--->	<br>
	<br><br>
	<%
	dim lUsrID
	set lObjUsrBankDetail	= server.CreateObject("Mac.UserBankMgr")
	lUsrID	= trim(Request.Form("selUsrId"))
	'response.write "Userid=" & lUsrID
 	lResult = lObjUsrBankDetail.DoUsrBnkDelete(lUsrID)
	Response.Write "Responsecode=" & lResult 
	'Response.Write  "Result = " & lResult
	select case(lResult)
	case "0":
		lResponse = "The Record has been deleted"
		case "100"
		lResponse ="Deletion failed Record Does't Exit "
		
	case "1800":
		lResponse = "The System Date doesn't match"
	End Select%>

<Table width="40%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>User Bank Details </font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%> Click <a href="UbnkDeldilog.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
<P>&nbsp;</P>
<!---#include file="../includes/footer.inc"--->
<br>
</BODY>
</HTML>


