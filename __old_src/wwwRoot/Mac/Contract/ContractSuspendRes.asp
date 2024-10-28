<%@Language=VBScript %>

<% Option Explicit

	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC Module										      *
	'* File name	:	ContractSuspendRes.asp  							  *	
	'* Purpose		:	This page will display the result					  *	
	'					for commodity type delete							  *	
	'* Prepared by	:	Majo												  *		
	'* Date			:	3.1.2002			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to display the result for commodity type delete			  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*																		  *
	'**************************************************************************
%>	
<HTML>
<HEAD>
<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
	</HEAD>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<!---#include file="../includes/header.inc"--->
	<br>
<!---#include file="../includes/MACLinks.inc"--->
	<br>
<%
dim lObjContSuspend
dim lResult	
dim lResponse
dim lContCode
dim lFmonth
dim lFday
dim lFyear
dim lFdate
dim lTmonth
dim lTDay
dim lTYear
dim lTdate

dim lSBstatus
dim lRBstatus
   
	lSBstatus=Request.Form("hidSBstatus")
	lRBstatus=Request.Form ("hidRBstatus")
	
	lFmonth=Request.Form("hidFSmonth")
	lFday=Request.Form("hidFSday")
	lFyear=Request.Form("hidFSyear")
	
	lTmonth=Request.Form("hidTSmonth")
	lTday=Request.Form("hidTSday")
	lTyear=Request.Form("hidTSyear")
	
	if len(lFmonth) <=1  then
		lFmonth	=	0	&	lFmonth
	end if
	if len(lFday)<=1 then
		lFday	=	0 & lFday
	end if
	
	if len(lTmonth) <=1  then
		lTmonth	=	0	&	lTmonth
	end if
	
	if len(lTday)<=1 then
		lTday	=	0 & lTday
	end if
	
	set lObjContSuspend	=	server.CreateObject("Mac.ContractMaintenanceMgr")
	lContCode = trim( Request.Form("hidContCode"))
	
if  lSBstatus="S" THEN  
	lFdate=lFyear & "-" & lFmonth & "-" & lFday 
	lTdate=lTyear & "-" & lTmonth & "-" & lTday 
    lResult = lObjContSuspend.DoSuspend(lContCode,"test", "MAS0001000", "S",lFdate,lTdate,"MAS0001000")
	select case(lResult)
	case "0":
		lResponse = "Contract  has been Suspended"
	case "100":
		lResponse = "The Record does not Exist"
	case "1800":
		lResponse = "The System Date doesn't match"
	case "1000":	
		lResponse = "Contract does not Exist"	
	case "1100":
		lResponse = "Contract code does not Exist"	
	case "1498":
		lResponse = "Contract can not be Suspended"
	case "1499":
		lResponse = "Invalid Exchange"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	default
		lResponse = "Connection Failed.. Please try again later."
	End Select
END IF

if  lRBstatus="R" THEN  
	lResult = lObjContSuspend.DoResume(lContCode,"MAS0001000")
	select case(lResult)
	case "0":
		lResponse = "Contract  has been Resume"
	case "100":
		lResponse = "The Record does not Exist"
	case "1800":
		lResponse = "The System Date doesn't match"
	case "1000":	
		lResponse = "Contract does not Exist"	
	case "1100":
		lResponse = "Contract code does not Exist"	
	case "1498":
		lResponse = "Contract can not be Resume"
	case "1499":
		lResponse = "Invalid Exchange"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
	default
		lResponse = "Connection Failed.. Please try again later."
	End Select
END IF


	%>
<center>
<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Contract Suspended/Resume  Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="ContMainMenu.asp">here</a> to view previous page</font>
	</td></tr>
</table>
</center>		
<br><br>
<!---#include file="../includes/footer.inc"--->
</form>
</body>
</HTML>


















