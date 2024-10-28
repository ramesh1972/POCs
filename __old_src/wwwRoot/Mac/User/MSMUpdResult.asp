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
	<br>
	
<%
	dim uRecNo
	dim uResponse
	dim uEventType
	dim uEventCode
	dim uEvent
	dim uEventTime
	dim uNextSession
    dim uRandomDelay
    dim uStatus
    dim uOldTime
    dim uTotalRec
    dim uTimeStamp

	uRecNo=Request.Form("hidRecNo")
	uResponse=Request.Form("hidResponse")
	uEventType=Request.Form("lEventType")
	uEvent=Request.Form("lEvent") 
	uEventCode=Request.Form("lEventCode")
	uEventTime=Request.Form("lEventTime")
	uNextSession=Request.Form("lNextSession")
	uRandomDelay=Request.Form("lRandomDelay")
	uStatus=Request.Form("lStatus")
	uOldTime=Request.Form("hidEventTime")
	uTotalRec=Request.Form("hidTotalRecNo")
	uTimeStamp=Request.Form("hidTimeStamp")
	
	dim ObjUpdate
    set ObjUpdate=Server.CreateObject("Mac.MSMMgr")
    lResult=ObjUpdate.DoUpdate("MZE0006000"," ",uEventType,uEventCode,"2002-04-01",uEvent,uEventTime,uOldTime,uTimeStamp,uNextSession,trim(uRandomDelay),uStatus," ",uResponse,uRecNo,uTotalRec)
   
	select case(lResult)
			case "0":
				lResponse = "The Record has been Updated"
			case "9641" OR "9645":
				lResponse = "Check the Event time"
			case "9613":
				lResponse = "The Record already exists"
			case "9598":
				lResponse = "The Connection to the Server cannot be established"
			default
				lResponse = "Connection Failed.. Please try again later."
			
	End Select%>
	
	<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Market Session Management details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%>. Click <a href="MSMMenu.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
	
	<P>&nbsp;</P>

	<!---#include file="../includes/footer.inc"--->
	<br>
	
	</BODY>
	</HTML>
 
 