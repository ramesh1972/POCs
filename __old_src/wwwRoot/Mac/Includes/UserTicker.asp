<%@ Language=VBScript %>
<%

lUserId=Request.Cookies("UserId")
lUserType=Request.Cookies("UserType")


set objTicker=server.CreateObject("Ticker.clsTicker")
set rsTicker=server.CreateObject("ADODB.Recordset")
set rsMargin=server.CreateObject("ADODB.Recordset")
set rsUser=server.CreateObject("ADODB.Recordset")
set rsTicker=objTicker.MarketNews()
set rsMargin=objTicker.ShowMargViolation(lUserId,lUserType)
set rsUser=objTicker.ShowUserSusp(lUserId,lUserType)

if not (rsMargin.EOF and rsMargin.BOF) then 
	
	while not rsMargin.EOF
	strMargin=rsMargin("WarningPrcnt")
	strMargval=rsMargin("MarginValue")
	strWarningTime=rsMargin("WarningTime")
	rsMargin.MoveNext 
	wend
	
end if
	
	Response.Cookies("lMarginPct") =strMargin

if not(rsTicker.EOF and rsTicker.BOF) then

	while not rsTicker.EOF 
	strTicker=rsTicker.Fields("MKTN_ANNOUNCEMENT")

	strspace="     "
	strTickerres=strTickerres+strspace+strTicker 
	rsTicker.MoveNext 

	wend

end if

if not (rsUser.EOF and rsUser.BOF) then 
	
	while not rsUser.EOF
	strUser=rsUser("BRK_SUSP_STATUS")
	strFrmdatetime=rsUser("BRK_SUSP_FRMDATETIME")
	strTodatetime=rsUser("BRK_SUSP_TODATETIME")
	rsUser.MoveNext 
	wend
	
end if


	if (strMargin="0" or strMargval="0") then strMargin="" 

	if strTickerres="" and strMargin="" then 
	Response.Write "Welcome to BceIndia.Com "
	end if
	if strTickerres<>"" then
	Response.Write strTickerres & "** end of Market Quote **    "
	end if
	
	if strMargin<>"" then 

	Response.Write "You have Crossed " & strMargin &" % Margin ("& strMargval &") at " &strWarningTime
	end if
	
	if strUser<>"" then
	response.write "You are Suspended from Trading from "&strFrmdatetime& "to"& strTodatetime
	end if

	if	strMargin<>"" then Session("MarginFlag")="T" else Session("MarginFlag")=""

set objTicker=Nothing
set rsTicker=Nothing
set rsMargin=Nothing
set rsUser=Nothing

	
%>



