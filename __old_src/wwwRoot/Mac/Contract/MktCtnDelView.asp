<%@ Language=VBScript %>
<%
dim mCDelRs
Dim mCDelObj
dim mrkBul
dim lResult 
dim lstatus
dim lContType
dim strInstCode

set mCDelObj = server.CreateObject("MacWebCon.clsMacWebCon")
set mCDelRs = server.CreateObject("ADODB.Recordset") 
set mCDelRs  = mCDelObj.GetContractCodes()
strInstCode = Request.Form("optMkrView")
set mrkBul = server.CreateObject("Mac.MarketContractMgr")
lResult  = mrkBul.MarketContractBrowse(strInstCode,"MNA0003000",lRespStr,"V")
Dim strFld 'Used for finding the Columns
strFld = Split(lRespStr, "|")
%>
<HTML>
   <HEAD>
	<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
    <br>
	<!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>
	<script language =javascript>
		function IntChange()
		{
		    document.frmMarketContract.btnDelete.disabled=true;
			document.frmMarketContract.hidInst.value=document.frmMarketContract.optMkrView.options[document.frmMarketContract.optMkrView.selectedIndex].value;
		}
		function instChk()
		{
			if (document.frmMarketContract.optMkrView.value =="")
			{
				alert("Select A Contract");
				return false;
			}
	
		}
		function FunctionCancel()
		{	 
		document.frmMarketContract.action ="MarketMenu.asp";
		document.frmMarketContract.method ="Post";
		document.frmMarketContract.submit();		
		}
		function FunctionDelete()
		{
		
		var confDel;
		confDel = document.frmMarketContract.optMkrView.value;
		if(confDel == "")
			{
			alert("Select Contract Code");
			return false;
			
			}
		else 
		{  document.frmMarketContract.action ="mktContDelRes.asp";
			document.frmMarketContract.method ="post";
			document.frmMarketContract.submit();
			return true;
		}
		}
	</script>
	
	</HEAD>
	
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
	<form name="frmMarketContract" method="post">
	<input type="hidden" name ="hidInst" >
	<br>
	<table width="50%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr align="middle" class="tdbgdark">
		<td colspan=2>
		<font class=whiteBoldtext>Contract Information
		</td>
	</tr>
	<tr>
		<td WIDTH="30%" class=tdbglight align="middle">
		   <font class=blackBoldtext>Select Contract Code </font>
		</td>
		<td WIDTH="20%" class=tdbglight align="middle">
		<SELECT style="WIDTH: 180px" class=tdbglight name="optMkrView" onchange="IntChange()">
			<OPTION value="" selected>Select Contract Code</OPTION>
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
	<input type ="hidden" name="hidcont">
	<% 
		if strInstCode = "" then
	%> 
	<%		
   else
     if lResult<>0 then
		select case lresult
		case "100":
			lResponse = "No Records"
			%>
			<Table align ="center" width="40%" border="1" cellspacing="1" cellpadding="1">
				<tr width="40%"><td class=tdbglight>
				<font class=colorboldtext1>Related Details Not Available</font>
				</td></tr>
			</table>
			<%
		case "1800":
			lResponse = "The System Date doesn't match"
		case "1100":
			lResponse = "The Record already exists"
		case "9598":
			lResponse = "The Connection to the Server cannot be established"
		case "57309":
			lResponse = "Record Already Exists"
		case "-8227":
			lResponse = "Record Already Exists"
		case else%>
			<Table align ="center" width="40%" border="1" cellspacing="1" cellpadding="1">
				<tr width="40%"><td class=tdbglight>
				<font class=colorboldtext1>Related Details Not Available</font>
				</td></tr>
			</table>
		<%End Select%>
		
	 <%else
		
	 	 		
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
	<%end if
	end if %>
	<br>
	
	
	<center>
	<tr WIDTH="80%" class=tdbglight height=10 align="center">
		<td colspan=4 >
		<INPUT style="WIDTH: 80px" type="submit" value="View"  name=btnView>&nbsp;&nbsp; 
		<INPUT style="WIDTH: 80px" type="button" value="Delete" name=btnDelete onclick="FunctionDelete();">&nbsp;&nbsp;
		<INPUT style="WIDTH: 80px" type="button" value="Cancel"  name=btnCancel onclick="FunctionCancel();" >
		</td>
	</tr>
	</table>
	</center>
	</form>
	</FONT>
	<!---#include file="../includes/footer.inc"--->
	
</body>
</HTML>



 