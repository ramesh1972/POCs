<%@ Language=VBScript %>
<%

dim lContViewObj
dim lResult 
dim lStatus
dim lResponse
dim lContType
dim lContCode

lContCode = Request.Form("hidContCode")
set lContViewObj = server.CreateObject("Mac.MarketContractMgr")
lResult  =lContViewObj.MarketContractBrowse(lContCode,Request.Cookies("UserId"),lResponse,lStatus)
Response.Write lResult
Dim strFld 'Used for finding the Columns
strFld = Split(lResponse, "|")
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
	</HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
	<form name="frmMarketContract" method="post">
	
<% 
			
	 if lContCode = "" then
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
		<INPUT style="WIDTH: 80px" type="submit" value="View"  name=btnBrowse >&nbsp;&nbsp; 
		<INPUT style="WIDTH: 80px" type="button" value="Cancel"  name=btnExit onclick="funExit();" >
		</td>
	</tr>
	</table>
	</center>
	</form>
	</FONT>
<!---#include file="../includes/footer.inc"--->
	
</body>
</HTML>



 