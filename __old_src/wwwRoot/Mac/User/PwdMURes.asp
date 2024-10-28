<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	PwdMURes.asp									      *
	'* Purpose		:	This is used for			.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for										  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   27/11/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		
<%	dim lExchgcode
	dim lUserType 
	dim lUserId 
	dim lCompanyId
	dim lPwd
	dim lStartMonth
	dim lStartDate
	dim lStartYear
	dim lEndMonth
	dim lEndDate
	dim lEndYear
	dim lStartDay
	dim lEndDay
	dim lObjPwdUpdate
	dim lAccessType

	lExchgcode = trim(Request.Form("hidExchgcode"))
	lUserType = trim(Request.Form("hidUserType")) 
	lUserId  = trim(Request.Form("hidUserId"))
	lCompanyId = trim(Request.Form("hidCompanyId"))
	lPwd = trim(Request.Form("txtPwd"))
	lStartMonth = trim(Request.Form("StartMonth"))
	lStartDate = trim(Request.Form("StartDate"))
	lStartYear = trim(Request.Form("StartYear"))
	lEndMonth = trim(Request.Form("EndMonth"))
	lEndDate = trim(Request.Form("EndDate"))
	lEndYear = trim(Request.Form("EndYear"))
	lAccessType	= trim(Request.Form("optAccessType"))

	if len(lStartMonth) <=1 then
		lStartMonth	=	"0" & lStartMonth
	end if
	if len(lStartDate) <=1 then
		lStartDate	=	"0" & lStartDate
	end if
	if len(lEndMonth) <=1 then
		lEndMonth	=	"0" & lEndMonth
	end if
	if len(lEndDate) <=1 then
		lEndDate	=	"0" & lEndDate
	end if
	lStartDay	= lStartYear & "-" & lStartMonth & "-" & lStartDate
	lEndDay		= lEndYear & "-" & lEndMonth & "-" & lEndDate
	
	set lObjPwdUpdate	= server.CreateObject("Mac.LogonPasswordMaintenanceMgr")
	lintResult = lObjPwdUpdate.LogonPasswordUpdate(lExchgcode,lUserType,lUserId,lCompanyId, _
									lPwd,"","",lStartDay,lEndDay,lAccessType,lUserId)
%>

	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	</head>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%"  height="27"><font class="whiteboldtext1"> Password Change </font></td>
		</tr>
	        
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="50%"> <font align="left" class="blacktext">
			<%select case(trim(lintResult))
				case 0	:	%>Information has been updated successfully</font></td>
		
			<%end select%>	        
	   	</tr>
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="50%"> <font align="left" class="blacktext">
					Click<a href="../User/PwdMaint.asp"> here </a> to see the Logon Password Maintenance screen.</td>
		</tr>
			
	</table>	
	<br><br><!---#include file="../includes/footer.inc"--->
	</body>
	</html>