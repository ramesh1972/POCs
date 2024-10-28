<%@ Language=VBScript %>
<% option explicit
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	UsrCompUpd.asp										  *
	'* Purpose		:	This is used for		.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for		.								  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   15/12/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		

	dim lUserId
	dim lUserType
	dim lCoyCode
	dim lExchCode
	dim lAppNo
	dim lFName
	dim lMName
	dim lLName
	dim lGender
	dim lDMonth
	dim lDDate
	dim lDYear
	dim lPAdd1
	dim lPAdd2
	dim lPAdd3
	dim lPhone
	dim lFax
	dim lEmailId
	dim lPanNo
	dim lCAdd1
	dim lCAdd2
	dim lCAdd3
	dim lCPName
	dim lSTNo
	dim lCSTNo
	dim lRegFee
	dim lEFee
	dim lDeposit
	dim lPMonth
	dim lPDate
	dim lPYear
	dim lObjUserCompUpd
	dim lActionValue
	dim lDOB
	dim lStartDate	
	dim	lSYear
	dim lSMonth 
	dim lSDate
	dim lEndDate	
	dim lEYear 
	dim lEMonth
	dim lEDate
	dim lResult

	lActionValue= trim(Request.Form("hidActionValue"))
	lUserId		= trim(Request.Form("optUserId"))
	lUserType	= trim(Request.Form("optUserType"))
	lCoyCode	= trim(Request.Form("optCoyCode"))
	lExchCode	= trim(Request.Form("optExchCode"))
	lAppNo	= trim(Request.Form("txtAppNo"))
	lFName	= trim(Request.Form("txtFName"))
	lMName	= trim(Request.Form("txtMName"))
	lLName	= trim(Request.Form("txtLName"))
	lGender	= trim(Request.Form("optGender"))
	lDMonth	= trim(Request.Form("optDMonth"))
	lDDate	= trim(Request.Form("optDDate"))
	lDYear	= trim(Request.Form("optDYear"))
	lPAdd1	= trim(Request.Form("txtPAdd1"))
	lPAdd2	= trim(Request.Form("txtPAdd2"))
	lPAdd3	= trim(Request.Form("txtPAdd3"))
	lPhone	= trim(Request.Form("txtPhone"))
	lFax	= trim(Request.Form("txtFax"))
	lEmailId= trim(Request.Form("txtEmailId"))
	lPanNo	= trim(Request.Form("txtPanNo"))
	lCAdd1	= trim(Request.Form("txtCAdd1"))
	lCAdd2	= trim(Request.Form("txtCAdd2"))
	lCAdd3	= trim(Request.Form("txtCAdd3"))
	lCPName	= trim(Request.Form("txtCPName"))
	lSTNo	= trim(Request.Form("txtSTNo"))
	lCSTNo	= trim(Request.Form("txtCSTNo"))
	lRegFee	= trim(Request.Form("txtRegFee"))
	lEFee	= trim(Request.Form("txtEFee"))
	lDeposit= trim(Request.Form("txtDeposit"))
	lPMonth	= trim(Request.Form("optPMonth"))
	lPDate	= trim(Request.Form("optPDate"))
	lPYear	= trim(Request.Form("optPYear"))
	
	if len(lDMonth) <=1 then
		lDMonth = "0" & lDMonth
	end if
	if len(lDDate) <=1 then
		lDDate = "0" & lDDate
	end if
	if len(lPMonth) <=1 then
		lPMonth = "0" & lPMonth
	end if
	if len(lPDate) <=1 then
		lPDate = "0" & lPDate
	end if
	lDOB		= lDYear & "-" & lDMonth & "-" & lDDate
	lStartDate	= lSYear & "-" & lSMonth & "-" & lSDate
	lEndDate	= lEYear & "-" & lEMonth & "-" & lEDate

	set lObjUserCompUpd	=	server.CreateObject("Mac.UserAndCompanyDetailsMgr")
	 
	lResult	= lObjUserCompUpd.UserUpdate(lActionValue,lExchCode,lUserId,lUserType,lCoyCode, _
					lAppNo,lFName,lMName,lLName,"2001-12-12" ,lGender,lPhone,lEmailId, _
					lFax,lCAdd1,lCAdd2,lCAdd3,lPAdd1,lPAdd2,lPAdd3,lCPName,lSTNo,lCSTNo, _
					"2001-12-05","2001-12-20",lRegFee,lEFee,lDeposit,1000,lPanNo,"MNA0003000")
'	Response.Write "Result = " & lResult
	%>
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	</head>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br><br>
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%"  height="27"><font class="whiteboldtext1"> Password Change </font></td>
		</tr>
	        
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="50%"> <font align="left" class="blacktext">
	<%
	select case(trim(lResult))
		case 0			:%> User and Company details has been updated successfully</font></td>
		<%case 1000		:%> Invalid User Id</font></td>
		<%case 1500		:%> Invalid Password</font></td>
		<%case 1600		:%>Invalid User Type</font></td>
		<%default		:%> Please try after some time</font></td>
	<%end select%>
		</tr>
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="50%"> <font align="left" class="blacktext">
					Click<a href="../User/UsrCompMenu.asp"> here </a> to see the User Company details Menu screen.</td>
		</tr>
	</table>	
	<br><br><!---#include file="../includes/footer.inc"--->
	</body>
	</html>
