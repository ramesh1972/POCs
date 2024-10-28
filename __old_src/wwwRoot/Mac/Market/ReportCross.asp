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
	dim lObjRepCross
	dim lComgCode
	dim lContCode
	dim lChrgType
	dim lChrgBase
	dim lChrgFee
	dim lChrgAmt
	dim lResult
	dim lResponse
	dim hidActionvalue
	
		hidActionvalue = Request.Form("hidActionvalue")
		'Response.Write "hidActionvalue=" & hidActionvalue		
		set lObjRepCross	= server.CreateObject("")
		select case(hidActionvalue)
		
		case "1":
		    lComgCode	= Request.Form("optComgCode")
			lContCode	= trim(Request.Form("optContCode"))
			lChrgType	= trim(Request.Form("optChrgType"))
			lChrgBase	= trim(Request.Form("optChrgBase"))
			lChrgFee	= trim(Request.Form("txtChrgFee"))
			lChrgAmt	= trim(Request.Form("txtChrgAmt"))
			lChrgFee=lChrgFee*100
			lChrgAmt=lChrgAmt*100
		 
			lResult	=	lObjRepCross.chargeMasterAdd("MZE0006000",lComgcode,lContCode,lChrgType,lChrgBase,lChrgFee,lChrgAmt)
			select case(left(lresult,instr(lResult,"|")-1))
			case "0":
				lResponse = "The Record has been Added"
				Response.Write "lResponse:" & lResponse
			case "1800":
				lResponse = "The System Date doesn't match"
			case "1100":
				lResponse = "The Record already exists"
			case "9598":
				lResponse = "The Connection to the Server cannot be established"
			case "57309":
				lResponse = "Record Already Exists"
			'default
				'lResponse = "Connection Failed.. Please try again later."
			End Select%>
	
		<%case "3":
			lComgCode	= Request.Form("txtComgCode")
			lContCode	= trim(Request.Form("txtContCode"))
			Response.Write "lcomgCode=" & lContCode
			
			lChrgType	= trim(Request.Form("txtChrgType"))
			lChrgBase	= trim(Request.Form("txtChrgBase"))
			lChrgFee	= trim(Request.Form("txtChrgFee"))
			lChrgAmt	= trim(Request.Form("txtChrgAmt"))
			lChrgFee=lChrgFee*100
			lChrgAmt=lChrgAmt*100
		 
		    lResult	=	lObjRepCross.ChargeMasMod("MZE0006000",lComgcode,lContCode,lChrgType,lChrgBase,lChrgFee,lChrgAmt)
		
			select case(left(lresult,instr(lResult,"|")-1))
			case "0":
				lResponse = "The Record has been Updated"
			case "100":
				lResponse = "The Record does not Exist"
			case "1800":
				lResponse = "The System Date doesn't match"
			case "1000":	
				lResponse = "Branch Code does not Exist"	
			case "1100":
				lResponse = "The Record already exists"
			case "9598":
				lResponse = "The Connection to the Server cannot be established"
			'default
				'lResponse = "Connection Failed.. Please try again later."
			
			End Select%>
				

		<%case "4"	:
						
			lComgCode	= Request.Form("txtComgCode")
			lContCode	= trim(Request.Form("txtContCode"))
			lChrgBase	= trim(Request.Form("hidChrgBase"))
			lChrgType	= trim(Request.Form("hidChrgType"))
			lChrgBase=0		
            lChrgFee=0
            lChrgAmt=0
				    
		    lResult	=	lObjRepCross.chargeMasterDel("MZE0006000",lComgcode,lContCode,lChrgType,lChrgBase,lChrgFee,lChrgAmt)
		    select case(left(lresult,instr(lResult,"|")-1))
			case "0":
				lResponse = "The Record has been Deleted"
			case "100":
				lResponse = "The Record does not Exist"
			case "1800":
				lResponse = "The System Date doesn't match"
			case "1000":	
				lResponse = "Branch Code does not Exist"
			case "1100":
				lResponse = "The Record already exists"
			case "9598":
				lResponse = "The Connection to the Server cannot be established"
			'default
				'lResponse = "Connection Failed.. Please try again later."
			
			End Select%>
				
		<%end select
		%>
		<Table width="40%" border="1" cellspacing="1" cellpadding="1">
				<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Charge  Details</font></td></tr>
					<tr width="40%"><td class=tdbglight>
						<font class=colorboldtext1><%=lResponse%></font>
					</td></tr>
				</table>
		

<P>&nbsp;</P>

	<!---#include file="../includes/footer.inc"--->
	<br>
	
	
</BODY>
</HTML>


