<%@ Language=VBScript %>
<%'response.buffer=true%>
	<%
	'on error resume next
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading												  *
	'* File name	:	ValidateLogon.asp								      *
	'* Purpose		:	This is used to validate TCM, ICM, SubBroker & Client *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	03/04/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to validate TCM, ICM, SubBroker & Client.				  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date			By					  Explanation			  *
	'*	1		   05/04/2001	V.Christopher Britto  First Baseline		  *
	'*	2		   05/05/2001	V.Christopher Britto  SubBroker coding part   *
	'*												  removed				  *
	'*																		  *
	'**************************************************************************			
	option explicit
	
	dim lUserId
	dim lPassword
	dim lstrLogin
	dim lObjLogon
	dim lResponse
	
	if Request.Form("txtUserId") <>"" then
		lUserId		=	cstr(trim(Request.Form("txtUserId")))
'	else
'		lUserId		=	cstr(trim(Request.Form("hidUserId")))
	end if
	lPassword	=	cstr(trim(Request.Form("txtPassword")))
'	lUserType	=	cstr(trim(Request.Form("hidUserType")))
	lUserId		=	replace(lUserId,"'","''")
	'lPassword	=	replace(lPassword,"'","''")
	'lUserType	=	replace(lUserType,"'","''")
	server.ScriptTimeout = 90
	set lObjLogon	=	server.CreateObject("Mac.LogonMgr")

	lstrLogin		=	lObjLogon.LogonChecking(lUserId,lPassword,lResponse)
	
	Dim lAccessFlag 
    Dim lErrorCode
    If lstrLogin = 0 then
		lAccessFlag = lResponse
		Response.Cookies("UserId")=ucase(lUserId)
		Response.Cookies("AccessFlag")= lAccessFlag
		Response.Redirect "..\csmmodule\MacClearingSettlement.asp"
	Else
        lErrorCode = lstrLogin
        
	end if
 
  	%>
	<HTML>
	<HEAD>
	<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
	</HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<!--#include file="../Includes/header.inc" ----><br><br><br><br>
	<table width="40%" align="center" border=1 cellpadding=1 cellspacing=1>
		<tr class=tdbgdark><td colspan=2 class="whiteboldtext1">Logon Result</td></tr>
		<tr class=tdbglight align=left><td colspan=2><font class=blacktext>
		
		<%select case(lErrorCode)
			case	1002	:	Response.Write "Invalid UserId"
			case	1003	:	Response.Write "Invalid Password"
			case	1004	:	Response.Write "User Halted"
			case	1005	:	Response.Write "Procedural Suspension"
			case	1006	:	Response.Write "Disiplinary Suspension"
			case	1007	:	Response.Write "Password Expired"
			case	1800	:	Response.Write "Invalid System Date"
			default
			       Response.Write "Unable to connect to host"        
		end select
		
		 %></font></td>
	</table>
	<br><br><br><br><!-- #include file="../Includes/footer.inc"--></center>
	<form name=frmForgetPwd action="ForgetPwd.asp" method="post" >
	<input type=hidden name="hidUserId" value="">
	<input type=hidden name="UserId">
	</form>
	<form name=frmTryAgain action="UserLogon.asp" method="post">
	<input type=hidden name="hidUserType" value="">
	<input type=hidden name="lUserType">
	</form>
	</body>
	</html>







