<%@ Language=VBScript %>
<%
dim mCDelRs
Dim mCDelObj
set mCDelObj = server.CreateObject("MacWebCon.clsMacWebCon")
set mCDelRs = server.CreateObject("ADODB.Recordset") 
set mCDelRs  = mCDelObj.GetContractCodes()
'******Builder
dim mrkBul
dim lResult 
dim lstatus
dim lContType
'if  Request.Form("optctrtype") = "" then
'	Response.Write "records"
'else
 '   lContType = Request.Form("hidcont")
'end if
set mrkBul = server.CreateObject("Project1.MarketContractMgr")
lResult  = mrkBul.MarketContractBorwse("RFSFOL0302","MNA0003000",lRespStr,2)
'Response.Write lResult 
'Response.Write lRespStr & " " & lRespStatus
'Response.Write lRespStr
Dim strFld 'Used for finding the Columns
strFld = Split(lRespStr, "|")
	   'Response.Write strFld(0)  & " <br> "       
	   'Response.Write strFld(1)  & " <br> "
	   'Response.Write strFld(2)  & " <br> "
	   'Response.Write strFld(3)  & " <br> "
	   'Response.Write strFld(4)  & " <br> "
	   'Response.Write strFld(5)  & " <br> "
	   'Response.Write strFld(6)  & " <br> "
	   'Response.Write strFld(7)  & " <br> "
	   'Response.Write strFld(8)  & " <br> "
	   'Response.Write strFld(9)  & " <br> "
	   'Response.Write strFld(10) & " <br> "
	   'Response.Write strFld(11) & " <br> "
	   'Response.Write strFld(12) & " <br> "
	   'Response.Write strFld(13) & " <br> "
	   'Response.Write strFld(14) & " <br> "
	   'Response.Write strFld(15) & " <br> "
	   'Response.Write strFld(16) & " <br> "
	
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
	
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
	<form name="frmMarketContract" >
	<!---#include file="../includes/header.inc"--->
	<script language =javascript>
	function funBrowse()
	{
	document.frmMarketContract.hidcont.value=document.frmMarketContract.optctrtype.options[document.frmMarketContract.optctrtype.selectedIndex].value;
	alert("browse");
	document.frmMarketContract.action ="MarketContractvu.asp";
	document.frmMarketContract.method ="post";
	document.frmMarketContract.submit();
	}
	function funExit()
	{	 
	 document.frmMarketContract.action ="MarketMenu.asp";
	 document.frmMarketContract.method ="Post";
	document.frmMarketContract.submit();		
	 alert("Exit");
	}
	</script>
	<table width="80%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr align="middle" class="tdbgdark">
		<TD>
			<font class="whiteBoldtext">Contract Builder And Maintenace</font>
		</TD>
	</tr>
	<tr align="middle" class="tdbglight">
		<td><font class="blackboldtext">
		Market Contract Builder </font>
		</td>
	</tr>
	</table>
	<br>
	<table width="40%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr align="middle" class="tdbgdark">
		<font class=whiteBoldtext>Contract Infomation
	</tr>
	<tr>
		<td WIDTH="20%" class=tdbglight align="middle">
		<font class=blackBoldtext>Contract Code </font>
		</td>
		<td WIDTH="20%" class=tdbglight align="middle">
		<SELECT style="WIDTH: 180px" class=tdbglight name="optctrtype" >
			<OPTION value="c" selected>Select one</OPTION>
		<%
		if not(mCDelRs.BOF and mCDelRs.EOF) then
				while not mCDelRs.EOF %>
					<option value="<%=mCDelRs("INST_CODE")%>"> <%=mCDelRs("INST_CODE")%></option>
						<% mCDelRs.MoveNext %>
						<%
				wend
		end if
			%>
		</SELECT>
		</td>
	</tr>
</table>
<br>
<input type ="text" name="hidcont">
<% 'if Request.Form("optctrtype")= "" then
    '  Response.Write"no records"
 'else
 %>
<table width="80%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr width="80%"  class=tdbgdark height=5 align="middle">
		<td  colspan=4>
			<font class=whiteboldtext1>Trade Infomation</font>
		</td>
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Market Lot</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
		<td width="10%" align="left">
		  <INPUT name="txtmrL" style="WIDTH: 100px" value="<%=strFld(7)%>">   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Tick Size in Rupees</font> 
		</td>
		<td width="10%" align="left">
			<INPUT name="txtTSR" style="WIDTH: 100px" value="<%=strFld(6)%>" >	
		</td>		
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Circuit Filter %</font>  
		</td>
		<td width="10%" align="left" >
			<INPUT name="txtCF" style="WIDTH: 100px"  value="<%=strFld(3)%>">
		</td> 
		<td width="30%">
			<font class=blackboldtext1>	OCP Trade Count</font>
		</td>	
		<td width="10%" align="left">
			<INPUT name="txtOCP" style="WIDTH: 100px"   value="<%=strFld(12)%>">
		</td>
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Settlement Filter %	</font>
		</td>
		<td width="10%" align="left">
		 <INPUT name="txtSF" style="WIDTH: 100px" value="<%=strFld(4)%>" >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>OCP  Trade Duration[min]</font>
		</td>
		<td width="10%" align="left">	
			<INPUT name="txtOcpTd" style="WIDTH: 100px" value="<%=strFld(5)%>" >
		</td>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Min Drip Qty % </font>
		</td>
		<td width="10%" align="left">	
		<INPUT name="txtMNQ"  style="WIDTH: 100px"  value="<%=strFld(14)%>"  >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Contract Status</font>
		</td>	
		<td width="10%" align="left">	
			<INPUT name="txtCS" style="WIDTH: 100px" value="<%=strFld(13)%>"  >
		</td>
	</tr>
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Trading Start Date</font>
		</td>
		<td width="10%" align="left">	
		<INPUT name="txtTSD" style="WIDTH: 100px" value="<%=strFld(8)%>" >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Trading End Date</font>
		</td>	
		<td width="10%" align="left">	
		<INPUT name="txtTED" style="WIDTH: 100px"   value="<%=strFld(9)%>" >
		</td>
	</tr>
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>	Delivery Start Date</font>   
		</td>
		<td width="10%" align="left">	
			<INPUT name="txtDSD" style="WIDTH: 100px"    value="<%=strFld(15)%>" >
		</td>
		<td width="30%">
			<font class=blackboldtext1>	Delivery End Date</font>
		</td>
		<td width="10%" align="left">		
			<INPUT name="txtDED" style="WIDTH: 100px"  value="<%=strFld(16)%>"  >
		</td>
	</tr>
	<%'end if %>
	<tr WIDTH="80%" class=tdbglight height=10 align="center">
		<td colspan=4 >
		<INPUT style="WIDTH: 80px" type="button" value="Browse"  name=btnBrowse onclick="funBrowse();" >&nbsp;&nbsp; 
		<INPUT style="WIDTH: 80px" type="button" value="Cancel"  name=btnExit onclick="funExit();" >
		</td>
	</tr>
	</table>
	</form>
	</FONT>
</body>
</HTML>



 