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
    <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
		
<center>
<%
dim mrkBul
dim lResult
DIM lRespStr
dim strInstCode
set mrkBul = server.CreateObject("Mac.MarketContractMgr")
strInstCode = Request.Form("optMkrAdd")
lResult  = mrkBul.MarketContractAdd(strInstCode,"MNA0003000",lRespStr,2)
Dim strFld 'Used for finding the Columns
strFld = Split(lRespStr, "|")
select case lresult
case "0":
	lResponse = "The Record has been Added"
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
End Select%>
    
	<%if lResult = 0  then%>
	<br>
		<table width="80%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr width="80%"  class=tdbgdark height=5 align="middle">
		<td  colspan=4>
			<font class=whiteboldtext1>Trade Information</font>
		</td>
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Market Lot</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
		<td width="10%" align="left">
		  <INPUT name="txtmrL" style="WIDTH: 100px" value="<%=strFld(5)%>">   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Tick Size in Rupees</font> 
		</td>
		<td width="10%" align="left">
			<INPUT name="txtTSR" style="WIDTH: 100px" value="<%=strFld(4)%>" >	
		</td>		
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
 		<td width="30%">
			<font class=blackboldtext1>Circuit Filter %</font>  
		</td>
		<td width="10%" align="left" >
			<INPUT name="txtCF" style="WIDTH: 100px"  value="<%=strFld(1)%>">
		</td> 
		<td width="30%">
			<font class=blackboldtext1>	OCP Trade Count</font>
		</td>	
		<td width="10%" align="left">
			<INPUT name="txtOCP" style="WIDTH: 100px"   value="<%=strFld(10)%>">
		</td>
	</tr>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Settlement Filter %	</font>
		</td>
		<td width="10%" align="left">
		 <INPUT name="txtSF" style="WIDTH: 100px" value="<%=strFld(2)%>" >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>OCP  Trade Duration[min]</font>
		</td>
		<td width="10%" align="left">	
			<INPUT name="txtOcpTd" style="WIDTH: 100px" value="<%=strFld(3)%>" >
		</td>
	<tr width="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Min Drip Qty % </font>
		</td>
		<td width="10%" align="left">	
		<INPUT name="txtMNQ"  style="WIDTH: 100px"  value="<%=strFld(12)%>"  >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Contract Status</font>
		</td>	
		<td width="10%" align="left">	
			<INPUT name="txtCS" style="WIDTH: 100px" value="<%=strFld(11)%>"  >
		</td>
	</tr>
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>Trading Start Date</font>
		</td>
		<td width="10%" align="left">	
		<INPUT name="txtTSD" style="WIDTH: 100px" value="<%=strFld(6)%>" >   
		</td>
		<td width="30%">
			<font class=blackboldtext1>Trading End Date</font>
		</td>	
		<td width="10%" align="left">	
		<INPUT name="txtTED" style="WIDTH: 100px"   value="<%=strFld(7)%>" >
		</td>
	</tr>
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td width="30%">
			<font class=blackboldtext1>	Delivery Start Date</font>   
		</td>
		<td width="10%" align="left">	
			<INPUT name="txtDSD" style="WIDTH: 100px"    value="<%=strFld(13)%>" >
		</td>
		<td width="30%">
			<font class=blackboldtext1>	Delivery End Date</font>
		</td>
		<td width="10%" align="left">		
			<INPUT name="txtDED" style="WIDTH: 100px"  value="<%=strFld(14)%>"  >
		</td>
	</tr>
	<%else
	end if
	%>
</table>
<br>
<Table width="40%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Market Contract Details</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1><%=lResponse%> Click <a href="MktContAdd.asp">here</a> to view the previous page</font>
		</td></tr>
</table>
<br>
<!---#include file="../includes/footer.inc"--->
	
	
</BODY>
</HTML>


