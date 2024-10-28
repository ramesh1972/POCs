<%@ Language=VBScript %>
<%
dim ldate

ldate=now()
ldate=formatdatetime(ldate,vblongdate)

set objOcp=server.CreateObject("Report.clsReport")
rsOcp=objOcp.GetPhase()

set objReport=server.CreateObject("Ticker.clsTicker")
set rsTicker=server.CreateObject("ADODB.Recordset")
if rsOcp = "CTNG" then 
set rsTicker=objReport.MarketTicker()
if not (rsTicker.EOF and rsTicker.BOF) then

	while not rsTicker.EOF 
	strTicker=rsTicker.Fields("inst_code")
	strTickerPrice=rsTicker("mps_price_last")
	strTickerYCP=rsTicker("mps_price_close_prev")
	strTickerDiff=rsTicker("price_diff")
	
	if (cint(strTickerDiff) > 0) then	strTickerDiff="+" + cstr(strTickerDiff)
	strspace="     "
	'strTickerres=strTickerres+strspace+strTicker+" "+" ("+  cstr(strTickerDiff)+") " +" "+cstr(strTickerPrice)
	strTickerres=strTickerres+strspace+strTicker+" : "+cstr(strTickerPrice)+" ("+  cstr(strTickerDiff)+") " 
	rsTicker.MoveNext 
	
	wend
end if

else
	'rsTicker.MoveFirst 
	set rsTicker=objReport.MarketClseTicker()
	if not (rsTicker.EOF and rsTicker.BOF) then
	
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
	


'set fs=server.CreateObject("Scripting.FileSystemObject")
'file=server.MapPath("Info.txt")
'fs.CreateTextFile(file)
'set nf=fs.OpenTextFile(file,8)
'nf.writeline(strg)
'nf.close



	

%>



