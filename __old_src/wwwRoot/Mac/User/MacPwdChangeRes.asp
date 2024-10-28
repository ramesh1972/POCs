	
	<%@ Language=VBScript %>
	<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	MacPwdChangeRes.asp									  *
	'* Purpose		:	This is used for Password Maintenance.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	13/12/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for Password Maintenance.								  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   13/12/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		
	option explicit 
	
	dim  lUserType
	dim  lUserId
	dim  lOldPwd
	dim  lNewPwd
	dim  lConfirmPwd
	dim  lObjPwdChange
	dim  lResult
	dim  lDisMeassage

	lUserType	= trim(Request.Form("optUserType"))
	lUserId		= trim(Request.Form("optUserId"))
	lOldPwd		= trim(Request.Form("txtOldPwd"))
	lNewPwd		= trim(Request.Form("txtNewPwd"))

 	set lObjPwdChange	=	server.CreateObject("Mac.LogonPasswordMaintenanceMgr")
	lResult	= lObjPwdChange.LogonPasswordChange(lUserId,lUserType,lOldPwd,lNewPwd,"MNA0003000")
		
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
		case 0			:%> Password has been changed successfully</font></td>
		<%case 1000		:%> Invalid User Id</font></td>
		<%case 1500		:%> Invalid Password</font></td>
		<%case 1600		:%>Invalid User Type</font></td>
		<%default		:%> Please try after some time</font></td>
	<%end select%>
		</tr>
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="50%"> <font align="left" class="blacktext">
					Click<a href="../User/MacPwdChange.asp"> here </a> to see the previous screen.</td>
		</tr>
			
	</table>	
	<br><br><!---#include file="../includes/footer.inc"--->
	</body>
	</html>