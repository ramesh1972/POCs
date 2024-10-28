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
		<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>

	
<%

dim lObjUsrbnkView
 dim lUsrID
 dim lAcctype
 dim lbankcode
 dim lBranchcode
 dim lAccno
 dim lAccOpenYear
 dim lAccOpenmonth
 dim lAccOpenday
 dim lResult
 dim lResultValues
 dim lDisValue
 dim ldate
 
 
	set lObjUsrBankDetail	= server.CreateObject("Mac.UserBankMgr")
	lUsrID	= trim(Request.Form("selUsrId"))
	'response.write lUsrID &"<br>"
 	lAcctype	= trim(Request.Form("selAccounttype"))
 	'response.write lAcctype &"<br>"
 	lbankcode= trim(Request.Form("selBankCode"))
	'response.write lbankcode &"<br>"
 	lBranchcode= trim(Request.Form("selBranchCode"))
 	'response.write lBranchcode &"<br>"
	lAccno= trim(Request.Form("txtAccno"))
	'response.write lAccno &"<br>"
	
	lAccOpenYear= trim(Request.Form("StartYear"))
	'response.write "Year =" & lAccOpenYear
	lAccOpenmonth= trim(Request.Form("StartMonth"))
	'response.write "month= " & lAccOpenmonth
	lAccOpenday= trim(Request.Form("StartDate"))
	'response.write "day= " & lAccOpenday
	
	ldate =lAccOpenYear& "-" & lAccOpenmonth& "-" & lAccOpenday
	'response.write "Date = " & ldate
	lResult = lObjUsrBankDetail.DoUsrBnkUpdate(lUsrID,lbankcode, lBranchcode, lAcctype, lAccno,ldate)
	'Response.write "RespondCode=" &lResult
	select case(lResult)
	case "0":
		lResponse = "The Record has been updated "
	case "1800":
		lResponse = "The System Date doesn't match"
	case "100":
		lResponse = "Updation Failed "
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	
End Select%>

<Table width="40%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="80%"><td class=tdbgdark><font class=whiteboldtext>User Bank Details </font></td></tr>
	<tr width="80%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%> Click <a href="UbnkMenu.asp">here</a> to view the previous page </font>
	</td></tr>
	</table>
	<P>&nbsp;</P>
	<br>
    <!--#include file="../Includes/footer.inc"> -->
   	
</BODY>
</HTML>


