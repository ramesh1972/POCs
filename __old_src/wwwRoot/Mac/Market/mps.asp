<%@language="vbscript"%>
<%
dim objMac
dim objRsMps
set objMac=server.CreateObject("MacWebCon.clsMacWebCon")
set objRsMps=server.CreateObject("ADODB.Recordset")
set objRsMps=objMac.GetContractCodes()
if objRsMps.BOF =false then
	objRsMps.MoveFirst 
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE>Market Price Statistics</TITLE>
<link rel="stylesheet" href="../Includes/Theme.css">
<script language="javascript">
	function sel_Change()
	{
		document.frmMPS.hidselValue.value=document.frmMPS.selContract.options[document.frmMPS.selContract.selectedIndex].value;
	}
	function fn_finalChk()
	{
		if (document.frmMPS.selContract.value =="")
		{
			alert("Select A Contract");
			return false;
		}
	
	}
</script>
</HEAD>
<BODY>
<Center>
<!--#include file="../includes/header.inc"-->
		<br>
<!--- #include file="../includes/MAClinks.inc" --->
	<br>

<form name="frmMPS" method="post" action="mps.asp">
	<table width="347" align="center" border="1"  cellpadding=1 cellspacing=1 >
		<tr class=tdbgdark height=30 align=middle><td align=left width="337"><font class=whiteboldtext1>Market Price Statistics</font></td></tr>
			<tr class=tdbglight height=30 align=left><td width="337">&nbsp; Contract Code 
	      :&nbsp;&nbsp;&nbsp; <SELECT  name="selContract" style="height: 23; width: 210" onchange="sel_Change()"> 
		      <OPTION  value="" selected>----------    AllContract Codes    ----------</OPTION>
		      <%while not objRsMps.EOF%>
					<%if trim(Request.Form("hidselValue"))= objrsMps("inst_code") then%>
						<OPTION value=<%=objrsMps("inst_code")%> selected><%=objrsMps("inst_desc")%></OPTION>
					<%else%>
					<OPTION value=<%=objrsMps("inst_code")%>><%=objrsMps("inst_desc")%></OPTION>
					<%end if%>
					<%objRsMps.MoveNext 
					wend
					objRsMps.Close 
					set objrsMps=nothing
					%>
			<%else%>
				<%objRsMps.Close 
				set objrsMps=nothing%>			
			<%end if%>
	      </SELECT></td></tr>
	</table>
	<input type="hidden" name ="hidselValue" ><br>
	<CENTER>
	
<%
dim objMPS
Dim lRecordCount
Dim lRespStr
Dim lResult
dim strContCode
dim strStatus
dim strNPTopLn
dim strNPBotLn
dim strLstModDtTme
strContCode=Request.Form("selContract")
'if strContCode="ALL" then
'	strContCode=""
'end if
if trim(Request.Form("hidStatus"))="" then
	strStatus="B"
else
	strStatus = trim(Request.Form("hidStatus"))
end if

if (trim(Request.Form("hidNext"))="" and strStatus = "B") or (trim(Request.Form("hidNext"))="" and strStatus = "N") then
	strLstModDtTme="1900-01-01:11:11:11.234565"
else
	if strStatus="P" then
		strLstModDtTme=trim(Request.Form("hidPrevious"))
	end if
	if strStatus="N" then
		strLstModDtTme=trim(Request.Form("hidNext"))
	end if
	'Response.Write "else part"
end if
'Response.Write "Contract Code:" & strContCode & "<br>"
'Response.Write "Mod Date:" & strLstModDtTme & "<br>"
'Response.Write "Status:" & strStatus & "<br>"
'''''''set objMPS=server.CreateObject("project1.MarketPriceStatsMgr")
set objMPS=server.CreateObject("Mac.MarketPriceStatsMgr")
lResult = objMPS.DoBrowse(strContCode, strLstModDtTme, strStatus,"MAS0001000",lRespStr, lRecordCount)
'Response.write lResult & " " & lRecordCount & " " & lRespStr
'Response.write lrecordcount
select case lResult
case "0":%>
<TABLE border="1"  cellpadding=1 cellspacing=1 >
		<TR class=tdbgdark>
			<TD><font class=whiteboldtext1>Contract Code</font></TD>
			<TD><font class=whiteboldtext1>Last Traded Price</font></TD>
			<TD><font class=whiteboldtext1>Last Traded Date</font></TD>
			<TD><font class=whiteboldtext1>Last Traded Volume</font></TD>
			<TD><font class=whiteboldtext1>Opening Price</font></TD>
			<TD><font class=whiteboldtext1>Closing Price</font></TD>
			<TD><font class=whiteboldtext1>Previous Closing Price</font></TD>
			<TD><font class=whiteboldtext1>High Price</font></TD>
			<TD><font class=whiteboldtext1>Low Price</font></TD>
			<TD><font class=whiteboldtext1>Cummulative Trade Volume</font></TD>
			<TD><font class=whiteboldtext1>Cummulative Trade Value</font></TD>
			<TD><font class=whiteboldtext1>No.Of Trades</font></TD>
		<TR>
	<%dim strLn
	dim strFld
	dim intLnNO'used for the line nos
	dim intFldNO
	
	strLn=split(lRespStr,"$")
	
	'Response.write "Line" & UBOUND(strLn)
	if strStatus <> "P" then

		for intLnNO= 0 to ubound(strLn) -1
		
			strFld=split(strLn(intLnNO),"|")
			'Response.Write "strfild" & ubound(strFld)
			if intLnNO = 0 then %>
				<tr class=tdbglight>
					<td><%=strFld(0)%></td>
					<td><%=cdbl(strFld(1))/100 &".00"%></td>
					<td><%=mid(strFld(2),1,10)%></td>
					<td><%=strFld(3)%></td>
					<td><%=CDBL(strFld(4))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(5))/100 & ".00"%></td>			
					<td><%=CDBL(strFld(6))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(7))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(9))/100 & ".00"%></td>
					<td><%=strFld(11)%></td>			
					<td><%=cdbl(strFld(12))/100 & ".00"%></td>			
					<td><%=strFld(13)%></td>						
						
				</tr>
				<%strNPTopLn=strFld(14)%>
			<%else%>
				<tr class=tdbglight>
					<td><%=strFld(0)%></td>
					<td><%=cdbl(strFld(1))/100 &".00"%></td>
					<td><%=mid(strFld(2),1,10)%></td>
					<td><%=strFld(3)%></td>
					<td><%=CDBL(strFld(4))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(5))/100 & ".00"%></td>			
					<td><%=CDBL(strFld(6))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(7))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(9))/100 & ".00"%></td>
					<td><%=strFld(11)%></td>			
					<td><%=cdbl(strFld(12))/100 & ".00"%></td>			
					<td><%=strFld(13)%></td>						
						
				</tr>
				<%strNPBotLn=strFld(14)
			end if%>
			
		<%next%>			
	<%else
		for intLnNO= ubound(strLn)-1 to 0 step-1
			strFld=split(strLn(intLnNO),"|")
			'Response.Write "strfild" & ubound(strFld)
			if intLnNO = ubound(strLn)-1 then %>
				<tr class=tdbglight>
					<td><%=strFld(0)%></td>
					<td><%=cdbl(strFld(1))/100 &".00"%></td>
					<td><%=mid(strFld(2),1,10)%></td>
					<td><%=strFld(3)%></td>
					<td><%=CDBL(strFld(4))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(5))/100 & ".00"%></td>			
					<td><%=CDBL(strFld(6))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(7))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(9))/100 & ".00"%></td>
					<td><%=strFld(11)%></td>			
					<td><%=cdbl(strFld(12))/100 & ".00"%></td>			
					<td><%=strFld(13)%></td>						
				</tr>
				<%strNPTopLn=strFld(14)%>
				<%'Response.Write "P IF PART   " & "   "& strFld(0) & "   "& strNPBotLn%>		
			<%else%>
				<tr class=tdbglight>
					<td><%=strFld(0)%></td>
					<td><%=cdbl(strFld(1))/100 &".00"%></td>
					<td><%=mid(strFld(2),1,10)%></td>
					<td><%=strFld(3)%></td>
					<td><%=CDBL(strFld(4))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(5))/100 & ".00"%></td>			
					<td><%=CDBL(strFld(6))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(7))/100 & ".00"%></td>			
					<td><%=cdbl(strFld(9))/100 & ".00"%></td>
					<td><%=strFld(11)%></td>			
					<td><%=cdbl(strFld(12))/100 & ".00"%></td>			
					<td><%=strFld(13)%></td>						
				</tr>
				<%strNPBotLn=strFld(14)
				'Response.Write "P ELSE PART   " &"   "& strFld(0) & "   " & strNPTopLn
			end if%>
			
		<%next%>			
	<%end if%>
<%case "100":
	Response.Write "Select A Contract from the List and Click Browse Button"
end select
%>	

	<tr>
	</tr>
	</TABLE>
	
	<TABLE>
		<tr class=tdbglight height=30 align="center">
			   <td>
		   <INPUT name="subMktView" type="submit" value="Browse">
		   <input type="button" name="btnPrev" 
		   value ="Previous" onclick="document.frmMPS.hidStatus.value='P';
		   document.frmMPS.method='post';
		   document.frmMPS.action='mps.asp';
		   document.frmMPS.submit();"
		   <%if lRecordCount=1 and strStatus ="B" then%>
		   disabled
		   <%end if%>
		   >
		   <input type ="button" name="btnNext" 
		   value ="    Next    " onclick="document.frmMPS.hidStatus.value='N';
		   document.frmMPS.method='post';
		   document.frmMPS.action='mps.asp';
		   document.frmMPS.submit();"
		   <%if lRecordCount=1 and strStatus ="B" then%>
		   disabled
		   <%end if%>
		   <%if lRecordCount <10 and strStatus ="N" and lResult ="0" then%>
		   disabled
		   <%end if%>
		   >
		   <input type ="reset" name ="rstClear" value="Clear">
		   </td>
	    </tr>
	</TABLE>
	<input type="hidden" name="hidStatus">
	<input type="hidden" name="hidNext" value=<%=strNPBotLn%>>
	<input type="hidden" name="hidPrevious" value=<%=strNPTopLn%>>
	</CENTER>
</form>

</BODY>
</HTML>
	