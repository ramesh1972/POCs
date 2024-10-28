<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	LogPwdMaintenance.asp							      *
	'* Purpose		:	This is used for Password Maintenance.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for Password Maintenance.								  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   27/11/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		
option explicit 
	
dim lObjComgGrp 
dim lObjRsComgGrp
dim lObjRsContCode
dim lObjRsTcmId
dim lObjRsIcmId
dim lObjRsClientB
dim lObjRsClientS
dim lSplitRes
dim lQty
dim lPrice
dim lOrderB
dim lOrderS

'added for 	contract code selection drop down list box. 
set lObjComgGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsComgGrp=server.CreateObject("adodb.recordset")
set lObjRsContCode=server.CreateObject("adodb.recordset")
set lObjRsTcmId=server.CreateObject("adodb.recordset")
set lObjRsIcmId=server.CreateObject("adodb.recordset")
set lObjRsClientB=server.CreateObject("adodb.recordset")
set lObjRsClientS=server.CreateObject("adodb.recordset")

'Populating values into corresponding recordsets
set lObjRsContCode =lObjComgGrp.GetContractCodes ()
set lObjRsTcmId = lObjComgGrp.GetTcmds ()
set lObjRsIcmId = lObjComgGrp.GetUsers ()
set lObjRsClientB = lObjComgGrp.GetUsers ()
set lObjRsClientS = lObjComgGrp.GetUsers ()
%>
	
	<script language="Javascript">
	
	function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
		if(document.frmReportCross.txtQty.value==""){
			alert("Enter Quantity")
			document.frmReportCross.txtQty.focus()
			return false;}
		if(document.frmReportCross.txtQty.value<0){
			alert("Type quantity Cannot be Negative")
			document.frmReportCross.txtQty.focus()
			return false;}
		if (isNaN(document.frmReportCross.txtQty.value)==true){
			alert("Type quantity Should have only Numerals");
			return false;}
		if(document.frmReportCross.txtPrice.value==""){
			alert("Enter Price")
			document.frmReportCross.txtPrice.focus()
			return false;}
		if(document.frmReportCross.txtPrice.value<0){
			alert("Price Cannot be Negative")
			document.frmReportCross.txtPrice.focus()
			return false;}
		if (isNaN(document.frmReportCross.txtPrice.value)==true){
			alert("Price Should have only Numerals");
			return false;}
		if(document.frmReportCross.txtOrderB.value==""){
			alert("Enter Buy Order Reference Number")
			document.frmReportCross.txtOrderB.focus()
			return false;}
		if(document.frmReportCross.txtOrderB.value<0){
			alert("Buy Order Reference Number Cannot be Negative")
			document.frmReportCross.txtOrderB.focus()
			return false;}
		if(document.frmReportCross.txtOrderS.value==""){
			alert("Enter Sell Order Reference Number")
			document.frmReportCross.txtOrderS.focus()
			return false;}
		if(document.frmReportCross.txtOrderS.value<0){
			alert("Sell Order Reference Number Cannot be Negative")
			document.frmReportCross.txtOrderS.focus()
			return false;}
		else{
			document.frmReportCross.action="ReportCrossResult.asp";
			document.frmReportCross.method="post";
			document.frmReportCross.submit(); }}
		else if(i==2) {
			document.frmReportCross.action="ComtMenu.asp";
			document.frmReportCross.submit(); }
	}
	</script>

	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		<title>Welcome to the Bombay Commodity Exchange Limited</title>

	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	
	<form name="frmReportCross" method="post"  onsubmit="return validateDate();">
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1">Report Crossing</font></td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Trade Quantity </font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight"> 
				<input type=text style="HEIGHT: 22px; WIDTH: 150px"  maxlength="10" name="txtQty" >
	        </td>
		</tr>

	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Trade Price </font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight"> 
				<input type=text style="HEIGHT: 22px; WIDTH: 150px"  maxlength="10" name="txtPrice">
	        </td>
		</tr>

		<TR class=tdbglight>
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Contract Code</font>
	        </td>
	        <td>
			<select size="1" name="OptContCode" style="HEIGHT: 22px; WIDTH: 150px" >
			<option selected value="">Select Cont Code</option>
	<%
	if not lObjRsContCode.EOF and trim(Request.Form("txtContCode"))="" then
		do while not lObjRsContCode.EOF %>
			<option value=<%=lObjRsContCode(0)%> ><%=lObjRsContCode(0)%></option>
			<%lObjRsContCode.MoveNext 
		loop
	else
		do while not lObjRsContCode.EOF %>
			<option value=<%=lObjRsContCode(0)%> ><%=lObjRsContCode(0)%></option>
			<%lObjRsContCode.MoveNext 
		loop
	end if
	%>
	</select></td>
	</tr>	
			
		<TR class=tdbglight>
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> TCM Id</font>
	        </td>
	        <td>
			<select size="1" name="OptTcmId" style="HEIGHT: 22px; WIDTH: 150px" >
			<option selected value="">Select TCM</option>
	<%
	if not lobjRsTcmId.EOF and trim(Request.Form("txtTcmId"))="" then
		do while not lobjRsTcmId.EOF %>
			<option value = <%=lobjRsTcmId(0)%> > <%=lobjRsTcmId(0)%> </option>
			<%lobjRsTcmId.MoveNext 
		loop
	else
		do while not lObjRsComgGrp.EOF %>
			<option value = <%=lobjRsTcmId(0)%> > <%=lobjRsTcmId(0)%> </option>
			<%lobjRsTcmId.MoveNext 
		loop
	end if
	%>
	</select></td>
	</tr>	
			
		<TR class=tdbglight>
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> ICM Id</font>
	        </td>
	        <td>
			<select size="1" name="OptIcmId" style="HEIGHT: 22px; WIDTH: 150px" >
			<option selected value="">Select ICM</option>
	<%
	if not lObjRsIcmId.EOF and trim(Request.Form("txtIcmId"))="" then
		do while not lObjRsIcmId.EOF %>
			<option value=<%=lObjRsIcmId(0)%> ><%=lObjRsIcmId(0)%></option>
			<%lObjRsIcmId.MoveNext 
		loop
	else
		do while not lObjRsIcmId.EOF %>
			<option value=<%=lObjRsIcmId(0)%> ><%=lObjRsIcmId(0)%></option>
			<%lObjRsIcmId.MoveNext 
		loop
	end if
	%>
	</select></td>
	</tr>	
			
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Buyer Order Ref No </font>
	        </td>
	        <td  align="left" height="16"  width="10%" class="tdbglight"> 
				<input type=text  maxlength="10" style="HEIGHT: 22px; WIDTH: 150px" name="txtOrderB">
	        </td>
		</tr>
			
		<TR class=tdbglight>
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Buyer Client Id</font>
	        </td>
	        <td>
			<select size="1" name="OptClientB" style="HEIGHT: 22px; WIDTH: 150px" >
			<option selected value="">Select Buyer Client</option>
	<%
	if not lObjRsClientB.EOF and trim(Request.Form("txtClientB"))="" then
		do while not lObjRsClientB.EOF %>
			<option value=<%=lObjRsClientB(0)%> ><%=lObjRsClientB(0)%></option>
			<%lObjRsClientB.MoveNext 
		loop
	else
		do while not lObjRsClientB.EOF %>
			<option value=<%=lObjRsClientB(0)%> ><%=lObjRsClientB(0)%></option>
			<%lObjRsClientB.MoveNext 
		loop
	end if
	%>
	</select></td>
	</tr>	

	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Seller Order Ref No </font>
	        </td>
	        <td  align="left" height="16"  width="10%" class="tdbglight"> 
				<input type=text maxlength="10" style="HEIGHT: 22px; WIDTH: 150px" name="txtOrderS">
	        </td>
		</tr>

		<TR class=tdbglight>
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Seller Client Id</font>
	        </td>
	        <td>
			<select size="1" name="OptClientS" style="HEIGHT: 22px; WIDTH: 150px" >
			<option selected value="">Select Seller Client</option>
	<%
	if not lObjRsClientS.EOF and trim(Request.Form("txtClientSId"))="" then
		do while not lObjRsClientS.EOF %>
			<option value=<%=lObjRsClientS(0)%> ><%=lObjRsClientS(0)%></option>
			<%lObjRsClientS.MoveNext 
		loop
	else
		do while not lObjRsClientS.EOF %>
			<option value=<%=lObjRsClientS(0)%> ><%=lObjRsClientS(0)%></option>
			<%lObjRsClientS.MoveNext 
		loop
	end if
	%>
	</select></td>
	</tr>	
	<input type=hidden name="hidActionValue">	
		<tr class="tdbglight"> 
			<td colspan=2 valign="center" align=middle height="27">
				<input type="button" name=btnSubmit value="Submit" onclick ="btnClick(1);">
				<input type="reset" name="btnCancel" value="Cancel" onclick ="btnClick(2);">
			</td>
		</tr>
	</table>
	</form>
	<br><!---#include file="../includes/footer.inc"--->
	<body>
	</html>
	
	