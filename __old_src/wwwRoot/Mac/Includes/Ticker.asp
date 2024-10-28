<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading												  *
	'* File name	:	Ticker.asp										      *
	'* Purpose		:	This is used to display Market Info to the Browser    *
	'* Prepared by	:	Vijay Venkataraman G.								  *	
	'* Date			:	03.04.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to go to the Login Page deponds on the user.Here TCM,	  *
	'* ICM, SubBroker & Client can go to their appropriate Login Page.		  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.-Date		 - By					- Explanation	   		  *
	'*	1		   03.04.2001  Vijay Venkataraman G.   First Baseline		  *
	'*												  						  *
	'**************************************************************************


dim ldate
ldate=now()
ldate=formatdatetime(ldate,vblongdate)
set objReport=server.CreateObject("Ticker.clsTicker")
set rsTicker=server.CreateObject("ADODB.Recordset")
set objOcp=server.CreateObject("Report.clsReport")
rsOcp=objOcp.GetPhase()
set rsTicker=objReport.MarketInformation()

if not (rsTicker.EOF and rsTicker.BOF) then
	if rsOcp = "CTNG" then
		if rsTicker.Fields.Count > 3 then
		while not rsTicker.EOF 
		
		strTicker=rsTicker.Fields("inst_code")
		strTickerPrice=rsTicker("mps_price_last")
		strTickerYCP=rsTicker("mps_price_close_prev")
		strTickerDiff=rsTicker("price_diff")
	
		if (cint(strTickerDiff) > 0) then	strTickerDiff="+" + cstr(strTickerDiff)
		strspace="     "
		strTickerres=strTickerres+strspace+strTicker+" : "+cstr(strTickerPrice)+" ("+  cstr(strTickerDiff)+") " 
		rsTicker.MoveNext 
	
		wend
		else
		while not rsTicker.EOF 
		strspace="     "
		strTicker=rsTicker.Fields("inst_code")
		strTickerYCP=rsTicker.Fields("mps_price_close_prev")
		strTickerres=strTickerres+strspace++strTicker+" : "++cstr(strTickerYCP)
		rsTicker.MoveNext
		wend
		end if
		
	else
		while not rsTicker.EOF 
		strspace="     "
		strTicker=rsTicker.Fields("inst_code")
		strTickerYCP=rsTicker.Fields("mps_price_close")
		strTickerres=strTickerres+strspace++strTicker+" : "++cstr(strTickerYCP)
		rsTicker.MoveNext
		wend
	end if
end if

	if strTickerres="" then 
		Response.Write "Quotes not Available" 
	else
		Response.Write "Prices as on "& ldate & strTickerres &"    ** end of Marketquote **    "
	end if	
%>



