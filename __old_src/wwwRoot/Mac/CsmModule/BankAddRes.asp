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
	dim lObjBnkUpdate
	dim lBankCode
	dim lBranchCode
	dim lBranchname
	dim lAddress1
	dim lAddress2
	dim lAddress3
	dim lResult
	dim lResponse
	
	
		lBankCode	= trim(Request.Form("txtBnkCode"))
		lBranchCode	= trim(Request.Form("txtBrnCode"))
		lBranchname	= trim(Request.Form("txtBrnname"))
		lAddress1	= trim(Request.Form("txtBrnAdd1"))
		lAddress2	= trim(Request.Form("txtBrnAdd2"))
		lAddress3	= trim(Request.Form("txtBrnAdd3"))
		
		'Response.Write "BANK CODE" & TRIM(lBankCode)
						
		set lObjBnkUpdate	= server.CreateObject("Project1.BankMasterMgr")
		lResult	=	lObjBnkUpdate.DoAdd(lBankCode,lBranchCode,lBranchname,lAddress1,lAddress2,lAddress3)
		select case(lresult)
			case "0":
				lResponse = "The Record has been Added"
			case "1800":
				lResponse = "The System Date doesn't match"
			case "1100":
				lResponse = "The Record already exists"
			case "9598":
				lResponse = "The Connection to the Server cannot be established"
			default
				lResponse = "Connection Failed.. Please try again later."
			
			End Select%>
	
	<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Bank Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="BankMenu.asp">here</a> to view the previous page</font>
	</td></tr>
</table>
	

<P>&nbsp;</P>

	<!---#include file="../includes/footer.inc"--->
	<br>
	
	
	
</BODY>
</HTML>
