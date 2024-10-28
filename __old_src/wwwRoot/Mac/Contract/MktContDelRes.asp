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
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->
	<br><br>
</HEAD>
<BODY marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
<center>
<%
	dim mrkBul
	dim lResult
	DIM lRespStr
	dim strInstCode
	dim lstatus
	set mrkBul = server.CreateObject("Mac.MarketContractMgr")
	strInstCode = Request.Form("optMkrView")
	lResult  = mrkBul.MarketContractDelete(strInstCode,"MNA0003000",lstatus)
	select case lresult
	case "0":
	      lResponse = "The Record has been Deleted"
	case "1800":
		  lResponse = "The System Date doesn't match"
	case "1100":
		  lResponse = "The Record already exists"
	case "9598":
		  lResponse = "The Connection to the Server cannot be established"
    case "57309":
		 lResponse = "Record Already Exists"
	case "-8227":
		lResponse = "Record Already Exists"
	End Select%>

	<Table width="40%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Market Contract Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1>The Market Contract Details has been deleted by the system.  Click <a href="MktCtnDelView.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
	</BODY>
    <br>
	<!---#include file="../includes/footer.inc"--->
	<br>
	
</HTML>


