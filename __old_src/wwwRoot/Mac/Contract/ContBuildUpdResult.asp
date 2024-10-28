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
   Dim lObjConBuldr      'Contract Buildeer Component Instance
   Set lObjConBuldr = Server.CreateObject("Project1.InstrumentMgr")
   Dim lRespCode
   
   dim lConCode
   dim lContBasePrice
   dim lDesc
   dim lConStatus
   dim lConGrp
   dim lConUnit
   dim lConType
   dim lTrdStDate
   dim lTrdEndDate
   dim lDlvdStDate
   dim lDlvEndDate
   dim lMktLot
   dim lOCPTrdCount
   dim lTickSize 
   dim lOCPTrdDuration
   dim lCirFilter
   dim lMinDripQty
   dim lSettleFilter
   
   lConCode			= Request.Form("txtConCode")
   'Response.Write    lConCode	
   lConType			= Request.Form("txtConType")
   lConGrp			= Request.Form("txtConGrp")
   lDesc			= Request.Form("txtDesc")
   lCirFilter		= Request.Form("txtCirFilter")
   lOCPTrdDuration	= Request.Form("txtOCPTrdDuration")
   lTickSize		= Request.Form("txtTickSize")
   lTrdStDate		= Request.Form("txtTrdStDate")
   lTrdEndDate		= Request.Form("txtTrdEndDate")
   lContBasePrice	= Request.Form("txtContBasePrice")
   lConStatus		= Request.Form("lstConStatus")
   lConUnit			= Request.Form("lstConUnit")
   lDlvdStDate		= Request.Form("txtDlvdStDate")
   lDlvEndDate		= Request.Form("txtDlvEndDate") 
   'Response.Write  lDlvEndDate
   lMktLot			= Request.Form("txtMktLot")
   lOCPTrdCount		= Request.Form("txtOCPTrdCount")
   lMinDripQty		= Request.Form("txtMinDripQty") 
   lSettleFilter	= Request.Form("txtSettleFilter")  

   'lRespCode = lObjConBuldr.DoModify(trim(lConCode),trim(lConType),trim(lConGrp),trim(lDesc),trim(lCirFilter),eval(lOCPTrdDuration),eval(lTickSize),eval(lMktLot),lTrdStDate,lTrdEndDate,0,lDlvdStDate,lDlvdEndDate,0,eval(lOCPTrdCount),10,"N",eval(lSettleFilter),eval(lMinDripQty),eval(lContBasePrice),"BOOE","MAC0000000")
   lRespCode =lObjConBuldr.DoModify(lConCode,lConType,40,lDesc,lCirFilter,lOCPTrdDuration,lTickSize,lMktLot,lTrdStDate,lTrdEndDate,10,lDlvdStDate,lDlvEndDate,1000,lOCPTrdCount,10,"N",lSettleFilter,lMinDripQty,lContBasePrice,"BOOE","MAS0001000")
    'lRespCode =lObjConBuldr.DoModify("GNTCOL0502",lConType,40,lDesc,lCirFilter,lOCPTrdDuration,lTickSize,lMktLot,lTrdStDate,lTrdEndDate,10,lDlvdStDate,lDlvdEndDate,1000,lOCPTrdCount,10,"N",lSettleFilter,lMinDripQty,lContBasePrice,"BOOE","MAS0001000")
   
   Response.Write      lRespCode 
   select case(lRespCode)
	      case "0":
				lResponse = "The Record has been Updated "
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
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Contract Information </font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="ContBuildMenu.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
	<P>&nbsp;</P>
	<!---#include file="../includes/footer.inc"--->
	<br>
	</BODY>
	</HTML>

      
