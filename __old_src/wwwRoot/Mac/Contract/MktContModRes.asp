<%@ Language=VBScript%>
<HTML>
<HEAD>
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
	</HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' onload="">
	<!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
    <br>
<center>

<%
dim lpstrzero
dim lpstr1
dim lpstr2
dim lpstr3
dim lpstr4
dim lpstr5
dim lpstr6
dim lpstr7
dim lpstr8
dim lpstr9
dim lpstr10
dim lpstr11
dim lpstr12
dim lpstr13
dim lpstr14
dim lpstr15 
dim lpstr16
dim lResstatus
DIM lRespStr
dim mrkBul
dim lResult
dim strInstCode

lpstrzero = Request.Form("hidstrfldzero")
lpstr1    = Request.Form("hidstrfld1")
lpstr2 = Request.Form("hidstrfld2")
lpstr3 = Request.Form("txtstr3")
lpstr4 = Request.Form("txtstr4")
lpstr5 = Request.Form("txtstr5")
lpstr6 = Request.Form("txtstr6")
lpstr7 = Request.Form("txtstr7")
lpstr8 = Request.Form("txtstr8")
lpstr9 = Request.Form("txtstr9")
lpstr10 = Request.Form("hidstrfld10")
lpstr11 = Request.Form("hidstrfld11")
lpstr12 = Request.Form("txtstr12")
lpstr13= Request.Form("txtstr13")
lpstr14 = Request.Form("txtstr14")
lpstr15 = Request.Form("txtstr15")
lpstr16 = Request.Form("txtstr16")
'**
set mrkBul = server.CreateObject("Mac.MarketContractMgr")
strInstCode = Request.Form("optMkrView")
lResult  = mrkBul.MarketContractUpdate(lpstrzero,lpstr1,lpstr2,lpstr3,lpstr4,lpstr5,lpstr6,lpstr7,lpstr8,lpstr9,lpstr10,lpstr11,lpstr12,lpstr13,lpstr14,lpstr15,lpstr16,"MNA0003000",lResstatus,lRespStr)
select case lresult
case "0":
	lResponse = "The Record has been Updated"
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
	<font class=colorboldtext1><%=lResponse%> Click <a href="MktctnMod.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
	<P>&nbsp;</P>
	<br>
	<!---#include file="../includes/footer.inc"--->
	</BODY>
	</HTML>


