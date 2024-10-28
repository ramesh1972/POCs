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
	<!---#include file="../includes/header.inc"--->	
	
	<br><br>
	
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
	lAcctype	= trim(Request.Form("selAccounttype"))
 	lbankcode= trim(Request.Form("OptBnKCode"))
	lBranchcode= trim(Request.Form("OptBrnCode"))
 	lAccno= trim(Request.Form("txtAccountNo"))
	lAccOpenYear= trim(Request.Form("StartYear"))
	lAccOpenmonth= trim(Request.Form("StartMonth"))
	lAccOpenday= trim(Request.Form("StartDate"))
	ldate =lAccOpenYear& "-" & lAccOpenmonth& "-" & lAccOpenday
	lResult = lObjUsrBankDetail.DoUsrBnkAdd(lUsrID,lbankcode,lBranchcode,lAcctype, lAccno,ldate)
	
	select case(lResult)
		   case "0":
				lResponse = "The Record has been Added Successfully :"
		   case "1800":
				lResponse = "The System Date doesn't match"
		   case "1100":
				lResponse = "The Record already exists"
		   case "9598":
				lResponse = "The Connection to the Server cannot be established"
		   case "57309":
				lResponse = "Record Already Exists"
		   case "-8227":
				lResponse ="Record Already Exists "
		   case "-8426":
				lResponse ="U had not select the date :"
	End Select%>

<Table width="40%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>User Bank Details </font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse %> Click <a href="ubnkAdd.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
		
		

<P>&nbsp;</P>

<!---#include file="../includes/footer.inc"--->
	<br>
	
	
</BODY>
</HTML>


