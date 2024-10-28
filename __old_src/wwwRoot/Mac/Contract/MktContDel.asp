<%@ Language=VBScript %>
<%
dim mCDelRs
Dim mCDelObj
dim lContType


set mCDelObj = server.CreateObject("MacWebCon.clsMacWebCon")
set mCDelRs = server.CreateObject("ADODB.Recordset") 
set mCDelRs  = mCDelObj.GetContractCodes()

dim mrkBul
dim lResult
DIM lRespStr
dim strInstCode
Response.Write strInstCode 
dim lstatus
set mrkBul = server.CreateObject("Mac.MarketContractMgr")
strInstCode = Request.Form("optMkrDel")
lResult  = mrkBul.MarketContractDelete(strInstCode,"MNA0003000",lstatus)
'lResult = mrkBul.MarketContractDelete("RBDPAM0102","MNA0003000",lstatus)
'Response.Write "ss"
'Response.Write lResult  
Response.Write optMkrDel
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
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' onload="">
	
	<script language =javascript>
	function IntChange()
	{
		document.frmMarketContract.hidInst.value=document.frmMarketContract.optMkrDel.options[document.frmMarketContract.optMkrDel.selectedIndex].value;
	}
	function instChk()
	{
		if (document.frmMarketContract.optMkrDel.value =="")
		{
			alert("Select A Contract");
			return false;
		}
	
	}
	function funExit()
	{	 
	 document.frmMarketContract.action ="MarketMenu.asp";
	 document.frmMarketContract.method ="Post";
	 document.frmMarketContract.submit();		
	}
	function Addasucc()
	{
	
	document.frmMarketContract.action ="mktContDel.asp";
	document.frmMarketContract.method ="post";
	document.frmMarketContract.submit();
	}
	</script>
	<form name="frmMarketContract" method="post" >
	<input type="hidden" name ="hidInst" >
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
		<SELECT style="WIDTH: 180px" class=tdbglight name="optMkrDel" onchange="IntChange()" >
			<OPTION value="" selected>Select one</OPTION>
			<%
			if not(mCDelRs.BOF and mCDelRs.EOF) then
				while not mCDelRs.EOF %>
					<%if trim(Request.Form("hidInst"))= mCDelRs("inst_code") then%>
   						<option value=<%=mCDelRs("INST_CODE")%> selected> <%=mCDelRs("INST_CODE")%></option>
					<%else%>
						<option value=<%=mCDelRs("INST_CODE")%>> <%=mCDelRs("INST_CODE")%></option>
					<%end if
						mCDelRs.MoveNext 
				wend
			end if
			%>
		</SELECT>
		</td>
	</tr>
</table>
<br>
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
		  <INPUT name="txtmrL" style="WIDTH: 100px"  >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Tick Size in Rupees</font> 
		</td>
		<td width="10%" align="left">
			<INPUT name="txtTSR" style="WIDTH: 100px" >	
		</td>		
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Circuit Filter %</font>  
		</td>
		<td width="10%" align="left" >
			<INPUT name="txtCF" style="WIDTH: 100px"  >
		</td> 
		<td width="30%">
			<font class=blackboldtext1>	OCP Trade Count</font>
		</td>	
		<td width="10%" align="left">
			<INPUT name="txtOCP" style="WIDTH: 100px"   >
		</td>
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Settlement Filter %	</font>
		</td>
		<td width="10%" align="left">
		 <INPUT name="txtSF" style="WIDTH: 100px"  >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>OCP  Trade Duration[min]</font>
		</td>
		<td width="10%" align="left">	
			<INPUT name="txtOcpTd" style="WIDTH: 100px"  >
		</td>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Min Drip Qty % </font>
		</td>
		<td width="10%" align="left">	
		<INPUT name="txtMNQ"  style="WIDTH: 100px"    >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Contract Status</font>
		</td>	
		<td width="10%" align="left">	
			<INPUT name="txtCS" style="WIDTH: 100px"   >
		</td>
	</tr>
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Trading Start Date</font>
		</td>
		<td width="10%" align="left">	
		<INPUT name="txtTSD" style="WIDTH: 100px"  >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Trading End Date</font>
		</td>	
		<td width="10%" align="left">	
		<INPUT name="txtTED" style="WIDTH: 100px"    >
		</td>
	</tr>
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>	Delivery Start Date</font>   
		</td>
		<td width="10%" align="left">	
			<INPUT name="txtDSD" style="WIDTH: 100px"     >
		</td>
		<td width="30%">
			<font class=blackboldtext1>	Delivery End Date</font>
		</td>
		<td width="10%" align="left">		
			<INPUT name="txtDED" style="WIDTH: 100px"    >
		</td>
	</tr>
	<br>
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td colspan=4 align="center">
			<INPUT style="WIDTH: 80px" type="button" value="Delete" name=btnAdd onclick="Addasucc();">&nbsp;&nbsp;
			<INPUT style="WIDTH: 80px" type="button" value="Cancel"  name=btnExit onclick="funExit();">
		</td>
	</tr>
	</table>
<INPUT id=text1 name=text1 style="WIDTH: 5px" width="5">
</form></FONT>
</body>
</HTML>



 