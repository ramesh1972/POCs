<%@ Language=VBScript %>
<HTML>
<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
    </head>
    

<BODY>


<!--#include file="../includes/header.inc"-->
		<br>
<!--- #include file="../includes/MAClinks.inc" --->
	<br>
	<form name="frmMrktView" action="frmmktviewres.asp" method="post">

<%
'Response.Write dtmFrom


%>
<%
strCntorDate=trim(Request.Form("hdnContDate"))
strContCode =trim(Request.Form("hdnContCode"))
'Response.Write strContCode


if trim(Request.Form("hidStatus"))="" then
	strStatus="B"
else
	strStatus = trim(Request.Form("hidStatus"))
end if

if (trim(Request.Form("hidNext"))="" and strStatus = "B") or (trim(Request.Form("hidNext"))="" and strStatus = "N") then
	strLstModDtTme="1900-01-01:01:01:01.000001"
elseif (trim(Request.Form("hidNext"))="" and trim(Request.Form("hidPrevious")) ="" and strStatus="P") then
	strLstModDtTme="1900-01-01:01:01:01.000001"
	strStatus="B"
elseif (trim(strContCode)<>"" and trim(Request.form("hdnContDate"))="I") then
	strLstModDtTme="1900-01-01:01:01:01.000001"
else 
	if strStatus="P" then
		strLstModDtTme=trim(Request.Form("hidPrevious"))
	end if
	if strStatus="N" then
		strLstModDtTme=trim(Request.Form("hidNext"))
	end if
	'Response.Write "else part"
end if

'Response.Write Request.form("hdnContDate")
'Response.Write strCntorDate
if  strCntorDate ="I" then

	'strLstModDtTme="1900-01-01:01:01:01.000001"

elseif strCntorDate="D" then

dim dtmFrom
dim dtmTo
dtmFrom = cstr(Request.form("StartYear")) & "-" & cstr(Request.Form("StartMonth")) & "-" & cstr(Request.Form("StartDate"))
dtmTo=cstr(Request.form("EndYear")) & "-" & cstr(Request.Form("EndMonth")) & "-" & cstr(Request.Form("EndDate"))


'strLstModDtTme="1900-01-01:01:01:01.000001"
	'strLstModDtTme="1900-01-01:01:01:01.000001"
	
'elseif strContCode="All" and strCntorDate="I" then
	'Response.Write strContCode
	
'	strContCode=""
'	strLstModDtTme="1900-01-01:01:01:01.000001"
end if
if strContCode="All" and strCntorDate="I" then
	'Response.Write strContCode
	
	strContCode=""
'	strLstModDtTme="1900-01-01:01:01:01.000001"
end if
''''''''''set objMktView=server.CreateObject("project1.MarketViewMgr")
set objMktView=server.CreateObject("Mac.MarketViewMgr")
'strContCode=""
'Response.write strCntorDate & "<br>"
'Response.Write strContCode & "<br>"
'Response.Write dtmFrom & "<br>"
'Response.Write dtmTo & "<br>"
'Response.write strLstModDtTme & "<br>"
'Response.write strStatus & "<br>"

lResult=objMktView.DoBrowse(strCntorDate, strContCode, dtmFrom, dtmTo, strLstModDtTme, strStatus,"MAS0001000",lRespStr, lRecCount)

'lResult=objMktView.DoBrowse("MZE0006000", "I", strContCode, "", "", strLstModDtTme, strStatus, lRespStr, lRecCount)
'Response.Write lResult &"          "& lRecCount &"                  " & lRespStr &"<br>"
'Response.Write "Contract Code is  :" & strContCode & "<br>"
'Response.Write "Type whether contract or DAte :" & strCntorDate & "<br>"
'Response.Write "Time Stamp :"  & strLstModDtTme & "<br>"
'Response.Write "Browsing status :" & strStatus & "<br>"
'Response.Write "From DAte :" & dtmFrom & "<br>"
'dim k
'k=mid(dtmFrom,6,2)
'Response.Write k
'''''Response.Write "To DAte :" & dtmTo & "<br>"

select case lResult
	case "0":
	
if lRecCount > 0 then	%>
	<TABLE border="1"  cellpadding=1 cellspacing=1 >
		<TR class=tdbgdark>
			<TD><font class=whiteboldtext>Contract Number</font></TD>
			<TD><font class=whiteboldtext>Contract Code</font></TD>
			<TD><font class=whiteboldtext>First Effective Date</font></TD>
			<TD><font class=whiteboldtext>Suspension Status</font></TD>
			<TD><font class=whiteboldtext>MAOP</font></TD>
			<TD><font class=whiteboldtext>Tick Size</font></TD>
			<TD><font class=whiteboldtext>Min Drip(%)</font></TD>
			<TD><font class=whiteboldtext>Min Order Size</font></TD>
			<TD><font class=whiteboldtext>Max Order Size</font></TD>
			<TD><font class=whiteboldtext>Circuit Filter(%)</font></TD>
			<TD><font class=whiteboldtext>Settlement Circuit Filter(%)</font></TD>
			<TD><font class=whiteboldtext>Phase</font></TD>
			<TD><font class=whiteboldtext>Close Calculation Depth Interval</font></TD>
			<TD><font class=whiteboldtext>Close Calculation Depth Trade Count</font></TD>
			<TD><font class=whiteboldtext>CTNG Filter Base Price</font></TD>
			<TD><font class=whiteboldtext>Last Effective Date</font></TD>
		</TR>
	<%dim strLn
	dim strFld
	dim intLnNO'used for the line nos
	dim intFldNO
	strLn = split(lRespStr,"$")
	'Response.Write ubound(strLn)
	if strStatus <> "P" then
	
		for intLnNo = 0 to ubound(strLn)-1
			strFld=split(strLn(intLnNo),"|")
			if intLnNO = 0 then %>
			
				<tr class=tdbglight>
					<td><font class=blacktext><%=strFld(0)%></td>
					<td><font class=blacktext><%=strFld(1)%></td>
					<td><font class=blacktext><%=mid(strFld(3),9,2) & "-" & mid(strFld(3),6,2) & "-" & mid(strFld(3),1,4)%></td>
					<td><font class=blacktext><%=strFld(5)%></td>
					<td><font class=blacktext><%=strFld(6)%></td>
					<td><font class=blacktext><%=cdbl(strFld(7)/1000)%></td>			
					<td><font class=blacktext><%=cdbl(strFld(8)/100)%></td>
					<td><font class=blacktext><%=strFld(9)%></td>
					<td><font class=blacktext><%=strFld(10)%></td>
					<td><font class=blacktext><%=cdbl(strFld(11)/100)%></td>
					<td><font class=blacktext><%=cdbl(strFld(12)/100)%></td>
					<td><font class=blacktext><%=strFld(13)%></td>
					<td><font class=blacktext><%=strFld(14)%></td>
					<td><font class=blacktext><%=strFld(15)%></td>
					<td><font class=blacktext><%=strFld(16)%></td>
					<td><font class=blacktext><%=mid(strFld(17),9,2) & "-" & mid(strFld(17),6,2) & "-" & mid(strFld(17),1,4)%></td>
				</tr>
				<%strNPTopLn=strFld(2)%>
			<%else%>
					<tr class=tdbglight>
						<td><font class=blacktext><%=strFld(0)%></td>
						<td><font class=blacktext><%=strFld(1)%></td>
						<td><font class=blacktext><%=mid(strFld(3),9,2) & "-" & mid(strFld(3),6,2) & "-" & mid(strFld(3),1,4)%></td>
						<td><font class=blacktext><%=strFld(5)%></td>
						<td><font class=blacktext><%=strFld(6)%></td>
						<td><font class=blacktext><%=cdbl(strFld(7)/1000)%></td>			
						<td><font class=blacktext><%=cdbl(strFld(8)/100)%></td>
						<td><font class=blacktext><%=strFld(9)%></td>
						<td><font class=blacktext><%=strFld(10)%></td>
						<td><font class=blacktext><%=cdbl(strFld(11)/100)%></td>
						<td><font class=blacktext><%=cdbl(strFld(12)/100)%></td>
						<td><font class=blacktext><%=strFld(13)%></td>
						<td><font class=blacktext><%=strFld(14)%></td>
						<td><font class=blacktext><%=strFld(15)%></td>
						<td><font class=blacktext><%=strFld(16)%></td>
						<td><font class=blacktext><%=mid(strFld(17),9,2) & "-" & mid(strFld(17),6,2) & "-" & mid(strFld(17),1,4)%></td>
					</tr>
					<%strNPBotLn=strFld(2)
			end if%>
			
		<%next%>
	<%else
	
		for intLnNO= ubound(strLn)-1 to 0 step-1
			strFld=split(strLn(intLnNO),"|")
			'Response.Write "strfild" & ubound(strFld)
			if intLnNO = ubound(strLn)-1 then %>
				<tr class=tdbglight>
					<td><font class=blacktext><%=strFld(0)%></td>
					<td><font class=blacktext><%=strFld(1)%></td>
					<td><font class=blacktext><%=mid(strFld(3),9,2) & "-" & mid(strFld(3),6,2) & "-" & mid(strFld(3),1,4)%></td>
					<td><font class=blacktext><%=strFld(5)%></td>
					<td><font class=blacktext><%=strFld(6)%></td>
					<td><font class=blacktext><%=cdbl(strFld(7)/1000)%></td>			
					<td><font class=blacktext><%=cdbl(strFld(8)/100)%></td>
					<td><font class=blacktext><%=strFld(9)%></td>
					<td><font class=blacktext><%=strFld(10)%></td>
					<td><font class=blacktext><%=cdbl(strFld(11)/100)%></td>
					<td><font class=blacktext><%=cdbl(strFld(12)/100)%></td>
					<td><font class=blacktext><%=strFld(13)%></td>
					<td><font class=blacktext><%=strFld(14)%></td>
					<td><font class=blacktext><%=strFld(15)%></td>
					<td><font class=blacktext><%=strFld(16)%></td>
					<td><font class=blacktext><%=mid(strFld(17),9,2) & "-" & mid(strFld(17),6,2) & "-" & mid(strFld(17),1,4)%></td>
				</tr>
				<%strNPTopLn=strFld(2)%>
			<%else%>
				<tr class=tdbglight>
					<td><font class=blacktext><%=strFld(0)%></td>
					<td><font class=blacktext><%=strFld(1)%></td>
					<td><font class=blacktext><%=mid(strFld(3),9,2) & "-" & mid(strFld(3),6,2) & "-" & mid(strFld(3),1,4)%></td>
					<td><font class=blacktext><%=strFld(5)%></td>
					<td><font class=blacktext><%=strFld(6)%></td>
					<td><font class=blacktext><%=cdbl(strFld(7)/1000)%></td>			
					<td><font class=blacktext><%=cdbl(strFld(8)/100)%></td>
					<td><font class=blacktext><%=strFld(9)%></td>
					<td><font class=blacktext><%=strFld(10)%></td>
					<td><font class=blacktext><%=cdbl(strFld(11)/100)%></td>
					<td><font class=blacktext><%=cdbl(strFld(12)/100)%></td>
					<td><font class=blacktext><%=strFld(13)%></td>
					<td><font class=blacktext><%=strFld(14)%></td>
					<td><font class=blacktext><%=strFld(15)%></td>
					<td><font class=blacktext><%=strFld(16)%></td>
					<td><font class=blacktext><%=mid(strFld(17),9,2) & "-" & mid(strFld(17),6,2) & "-" & mid(strFld(17),1,4)%></td>
				</tr>
				<%strNPBotLn=strFld(2)

			end if
		next%>


		<%end if%>			


</TABLE>
<TABLE align="center">
<tr class=tdbglight height=30 align="center">
	<td>
	 	<input type="button" name ="btnPrevious" value="Previous"
	 	onclick="document.frmMrktView.hidStatus.value='P';
	 	document.frmMrktView.method='post';
	 	document.frmMrktView.action='mktViewres.asp';
	 	document.frmMrktView.submit();"
	 	<%if lRecCount < 11 and strStatus ="B" then%>
	 		disabled
	 	<%end if%>
	 	<%if lRecCount < 11 and strStatus ="P" and lResult ="0" then%>
	 		disabled
	 	<%end if%>
	 	>
	 	<input type="button" name ="btnNext" value="    Next    "
	 	onclick="document.frmMrktView.hidStatus.value='N';
	 	document.frmMrktView.method='post';
	 	document.frmMrktView.action='mktViewres.asp';
	 	document.frmMrktView.submit();"
	 	<%if lRecCount = 1 and strStatus ="B" then%>
	 		disabled
	 	<%end if%>
	 	<%if lRecCount < 11 and strStatus ="N" and lResult ="0" then%>
	 		disabled
	 	<%end if%>
	 	>
	</td>
</tr>
</TABLE>
</center>
<input type="hidden" name="hdnContCode">
<input type="hidden" name="hidNext" value=<%=strNPBotLn%>>
<input type="hidden" name ="hidPrevious" value=<%=strNPTopLn%>>
<input type="hidden" name="hidStatus">
<input type="hidden" name="hdnContDate">

<%
else%>
<center>
<br><br>
<font class=blackboldtext>No Record Exists</font>
</center>
<br><br>
<%
end if
%>
<center>
<%case "100":
	Response.Write "Select A Contract from the List and Click Browse Button"
end select
%>		
<br>
</center>
</form>
<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>
