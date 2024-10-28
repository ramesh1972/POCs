
	<%@ Language=VBScript %>
	<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	UserCompDetails.asp									  *
	'* Purpose		:	This is used for Password Maintenance.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	05/12/2001											  *
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
	
	dim lUserType
	dim lObjUserIds
	dim lRsCompIds
	dim lCurrentDate
	dim lMonth
	dim lDate
	dim lYear
	dim lYearPrev

	lCurrentDate=now()
	lMonth= month(lCurrentDate)
	lDate=day(lCurrentDate)
	lYear=year(lCurrentDate)
	lYearPrev	= lYear -1
	lUserType = trim(Request.Form("hidUserType"))
	
	if lUserType <> "" then
		set lObjUserIds = server.CreateObject("MacWebCon.clsMacWebCon")
		set lRsCompIds = server.CreateObject("adodb.recordset")
		select case(lUserType)
			case "T"	:	set lRsCompIds = lObjUserIds.GetCompanyCodes()
			case "I"	:	set lRsCompIds = lObjUserIds.GetCompanyCodes()
			case "J"	:	set lRsCompIds = lObjUserIds.GetCompanyCodes()
			case "C"	:	set lRsCompIds = lObjUserIds.GetCompanyCodes()
			case "M"	:	set lRsCompIds = lObjUserIds.GetCompanyCodes()
			case "R"	:	set lRsCompIds = lObjUserIds.GetCompanyCodes()
			case "U"	:	set lRsCompIds = lObjUserIds.GetCompanyCodes() 
		end select
	end if
	%>
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Bombay Commodity Exchange Limited</title>
	<script language="javascript">
	function CheckAction(btnValue){
	var lActionValue	=	btnValue;
		if ((lActionValue == 1) && (CheckValues())) {
			document.frmUserCompanyDetails.hidActionValue.value ="A";
			document.frmUserCompanyDetails.action="UserCompDetRes.asp";
			document.frmUserCompanyDetails.method="post";
			document.frmUserCompanyDetails.submit();}
		else if(lActionValue == 4){
			if (document.frmUserCompanyDetails.optUserId.value ==""){
				document.frmUserCompanyDetails.optUserId.focus();
				alert("Please select User Id to view the all details");
				return false;}
			else {document.frmUserCompanyDetails.hidActionValue.value ="V";
				document.frmUserCompanyDetails.action="UserCompDetRes.asp";
				document.frmUserCompanyDetails.submit();}}}

	function CheckValues(){
	if (document.frmUserCompanyDetails.txtRegFee.value ==""){
		document.frmUserCompanyDetails.txtRegFee.focus();
		alert("Please enter the Reg. fee");
		return false;} 
	if (document.frmUserCompanyDetails.txtEFee.value ==""){
		document.frmUserCompanyDetails.txtEFee.focus();
		alert("Please enter the Equity fee");
		return false;} 
	if (document.frmUserCompanyDetails.txtDeposit.value ==""){
		document.frmUserCompanyDetails.txtDeposit.focus();
		alert("Please enter the Deposit");
		return false;} 
	if (document.frmUserCompanyDetails.txtCPName.value ==""){
		document.frmUserCompanyDetails.txtCPName.focus();
		alert("Please enter the contact person name");
		return false;} 
	if (document.frmUserCompanyDetails.txtCSTNo.value =="")	{
		document.frmUserCompanyDetails.txtCSTNo.focus();
		alert("Please enter the CST No");
		return false;} 
	if (document.frmUserCompanyDetails.txtCSTNo.value ==""){
		document.frmUserCompanyDetails.txtCSTNo.focus();
		alert("Please enter the Sales Tax No");
		return false;} 
	if (document.frmUserCompanyDetails.txtCAdd1.value ==""){
		document.frmUserCompanyDetails.txtCAdd1.focus();
		alert("Please enter the contact address");
		return false;} 
	if (document.frmUserCompanyDetails.txtCAdd2.value ==""){
		document.frmUserCompanyDetails.txtCAdd2.focus();
		alert("Please enter the contact address");
		return false;} 
	if (document.frmUserCompanyDetails.txtCAdd3.value ==""){
		document.frmUserCompanyDetails.txtCAdd3.focus();
		alert("Please enter the contact address");
		return false;} 
	if (document.frmUserCompanyDetails.txtPAdd1.value ==""){
		document.frmUserCompanyDetails.txtPAdd1.focus();
		alert("Please enter the permanent address");
		return false;} 
	if (document.frmUserCompanyDetails.txtPAdd2.value ==""){
		document.frmUserCompanyDetails.txtPAdd2.focus();
		alert("Please enter the permanent address");
		return false;}
	if (document.frmUserCompanyDetails.txtPAdd3.value ==""){
		document.frmUserCompanyDetails.txtPAdd3.focus();
		alert("Please enter the permanent address");
		return false;}
	if (document.frmUserCompanyDetails.txtPhone.value ==""){
		document.frmUserCompanyDetails.txtPhone.focus();
		alert("Please enter the Phone no.");
		return false;} 
	if (document.frmUserCompanyDetails.txtFax.value ==""){
		document.frmUserCompanyDetails.txtFax.focus();
		alert("Please enter the FAX");
		return false;}
	if (document.frmUserCompanyDetails.txtEmailId.value ==""){
		document.frmUserCompanyDetails.txtEmailId.focus();
		alert("Please enter the e-mail");
		return false;}
	if (document.frmUserCompanyDetails.txtPanNo.value ==""){
		document.frmUserCompanyDetails.txtPanNo.focus();
		alert("Please enter the PAN no.");
		return false;} 
	if (document.frmUserCompanyDetails.optUserType.value ==""){
		document.frmUserCompanyDetails.optUserType.focus();
		alert("Please select the User Type");
		return false;}
	if (document.frmUserCompanyDetails.optCoyCode.value ==""){
		document.frmUserCompanyDetails.optCoyCode.focus();
		alert("Please select the Company code");
		return false;}
	if (document.frmUserCompanyDetails.optExchCode.value ==""){
		document.frmUserCompanyDetails.optExchCode.focus();
		alert("Please select the exchange code");
		return false;}
	if (document.frmUserCompanyDetails.txtAppNo.value ==""){
		document.frmUserCompanyDetails.txtAppNo.focus();
		alert("Please enter the application no");
		return false;}
	if (document.frmUserCompanyDetails.txtFName.value ==""){
		document.frmUserCompanyDetails.txtFName.focus();
		alert("Please enter the first name");
		return false;}
	if (document.frmUserCompanyDetails.txtMName.value ==""){
		document.frmUserCompanyDetails.txtMName.focus();
		alert("Please enter the middle name");
		return false;}
	if (document.frmUserCompanyDetails.txtLName.value ==""){
		document.frmUserCompanyDetails.txtLName.focus();
		alert("Please enter the last name");
		return false;}
	if (document.frmUserCompanyDetails.optGender.value ==""){
		document.frmUserCompanyDetails.optGender.focus();
		alert("Please select the gender");
		return false;}
	if (isNaN(document.frmUserCompanyDetails.txtRegFee.value)){
		document.frmUserCompanyDetails.txtRegFee.select();
		alert("Please enter price in numbers");  
		return false;}
	if (isNaN(document.frmUserCompanyDetails.txtEFee.value)){
		document.frmUserCompanyDetails.txtEFee.select();
		alert("Please enter price in numbers");  
		return false;}
	if (isNaN(document.frmUserCompanyDetails.txtDeposit.value)){
		document.frmUserCompanyDetails.txtDeposit.select();
		alert("Please enter price in numbers");  
		return false;}
	var email = document.frmUserCompanyDetails.txtEmailId.value; 
	if (!checkEmail(email))  return false
		return true
	return true;
	}
	
	function GetDisabled(){
		document.frmUserCompanyDetails.txtRegFee.disabled =true;
		document.frmUserCompanyDetails.txtEFee.disabled =true;
		document.frmUserCompanyDetails.txtDeposit.disabled =true;
		document.frmUserCompanyDetails.txtCPName.disabled =true;
		document.frmUserCompanyDetails.txtCSTNo.disabled =true;
		document.frmUserCompanyDetails.txtCSTNo.disabled =true;
		document.frmUserCompanyDetails.txtCAdd1.disabled =true;
		document.frmUserCompanyDetails.txtCAdd2.disabled =true;
		document.frmUserCompanyDetails.txtCAdd3.disabled =true;
		document.frmUserCompanyDetails.txtPAdd1.disabled =true;
		document.frmUserCompanyDetails.txtPAdd2.disabled =true;
		document.frmUserCompanyDetails.txtPAdd3.disabled =true;
		document.frmUserCompanyDetails.txtPhone.disabled =true;
		document.frmUserCompanyDetails.txtFax.disabled =true;
		document.frmUserCompanyDetails.txtEmailId.disabled =true;
		document.frmUserCompanyDetails.txtPanNo.disabled =true;
		document.frmUserCompanyDetails.optUserType.disabled =true;
		document.frmUserCompanyDetails.optCoyCode.disabled =true;
		document.frmUserCompanyDetails.optExchCode.disabled =true;
		document.frmUserCompanyDetails.txtAppNo.disabled =true;
		document.frmUserCompanyDetails.txtFName.disabled =true;
		document.frmUserCompanyDetails.txtMName.disabled =true;
		document.frmUserCompanyDetails.txtLName.disabled =true;
		document.frmUserCompanyDetails.optGender.disabled =true;
		document.frmUserCompanyDetails.txtRegFee.disabled =true;
		document.frmUserCompanyDetails.txtEFee.disabled =true;
		document.frmUserCompanyDetails.txtDeposit.disabled =true;
		document.frmUserCompanyDetails.txtEmailId.disabled =true;
		document.frmUserCompanyDetails.btnAdd.disabled =true;
		document.frmUserCompanyDetails.btnView.disabled =true;
		document.frmUserCompanyDetails.txtSTNo.disabled =true;   
		document.frmUserCompanyDetails.optEDate.disabled =true;   
		document.frmUserCompanyDetails.optEMonth.disabled =true;
		document.frmUserCompanyDetails.optEYear.disabled =true;
		document.frmUserCompanyDetails.optSDate.disabled =true;   
		document.frmUserCompanyDetails.optSMonth.disabled =true;   
		document.frmUserCompanyDetails.optSYear.disabled =true;
		document.frmUserCompanyDetails.optDDate.disabled =true;
		document.frmUserCompanyDetails.optDMonth.disabled =true;
		document.frmUserCompanyDetails.optDYear.disabled =true;}

	function checkEmail(checkString){
	    var newstr = "";
	    var at = false;
	    var dot = false;
	    if (checkString.indexOf("@") != -1) {at = true;}
	    else if (checkString.indexOf(".") != -1){dot = true;}
	    for (var i = 0; i < checkString.length; i++) {
	        ch = checkString.substring(i, i + 1)
	        if ((ch >= "A" && ch <= "Z") || (ch >= "a" && ch <= "z")
	                || (ch == "@") || (ch == ".") || (ch == "_")
	                || (ch == "-") || (ch >= "0" && ch <= "9")) {
	                newstr += ch;
	                if (ch == "@") {
	                    at=true;}
	                if (ch == ".") {
	                    dot=true;  }}}
	    if ((at == true) && (dot == true)) {return true ;}
	    else {alert ("Please enter a valid email address....");
			document.frmUserCompanyDetails.txtEmailId.focus();
			document.frmUserCompanyDetails.txtEmailId.select();
			return false;}}
	
	function DisCompIds(){
		var lSelInd = document.frmUserCompanyDetails.optUserType.selectedIndex;
		var lSelVal = document.frmUserCompanyDetails.optUserType.options[lSelInd].value;
		document.frmUserCompanyDetails.hidUserType.value = lSelVal;
		document.frmUserCompanyDetails.submit(); }
	</script>
	</head>
	<body border="1" cellspacing="1" cellpadding"1" topmargin="1" bottommargin="1">
	<!---#include file="../includes/header.inc"--->
	<br><!--#include file="../Includes/MACLinks.inc" ----><br>
	<form name="frmUserCompanyDetails" action="UserCompDetails.asp" method=post>
	<table border="1" cellspacing="1" cellpadding="1" width="90%" align="center">
		<tr class=tdbgdark width="100%">
			<td align="left" height="25" colspan="4"> <font class=whiteboldtext1>User Company Details</font></td>
		</tr>
		<tr class=tdbglight width="100%">
			<td align="left" height="20" width="15%"> <font class=blacktext>User ID </font></td>
			<td size="15" maxlength="10" width="25%">
				<select name="optUserID" style="height: 22px; width: 199px" disabled>
					<option selected>----Select User Id----</option>
				</select></td>
			<td align="left" height="20" width="15%"> <font class=blacktext>User Type *</font></td>
			<td size="15" maxlength="10" width="25%">
				<select name="optUserType" style="height: 22px; width: 199px" onchange="DisCompIds()">
					<option selected>----Select User Type----</option>
					<option value="T" <%if lUserType="T" then Response.Write "selected" %> >TCM </option>
					<option value="I" <%if lUserType="I" then Response.Write "selected" %> >ICM</option>
					<option value="J" <%if lUserType="J" then Response.Write "selected" %> >SubBroker</option>
					<option value="C" <%if lUserType="C" then Response.Write "selected" %> >Client</option>
					<option value="M" <%if lUserType="M" then Response.Write "selected" %> >MAC - User</option>
					<option value="R" <%if lUserType="R" then Response.Write "selected" %> >Surveillance User</option>
					<option value="U" <%if lUserType="U" then Response.Write "selected" %> >Surveillance Manager</option>
				</select>
		</tr>
		<input type=hidden name="hidUserType">
		<tr class=tdbglight width="100%">
			<td align="left" height="20" width="15%"> <font class=blacktext>Company Code </font></td>
			<td size="15" maxlength="10" width="25%">
				<%if lUserType <> "" then
					if not (lRsCompIds.BOF and lRsCompIds.EOF)then 
						Response.Write  "<select name='optCoyCode' style='height: 22px; width: 199px'>"
						while not lRsCompIds.EOF 
							Response.Write "<option value=" & lRsCompIds(0) & ">" & lRsCompIds(0) & "</option>"
							lRsCompIds.MoveNext
						wend
						Response.Write "</select>"
					else
						Response.Write "<font align='left'class='blacktext1'>No UserID is available</font>"
					end if
				else
					Response.Write "<font align='left'class='blacktext1'>Please select User Type to display Company IDs</font>"
				end if %>
			<td align="left" height="20" width="15%"> <font class=blacktext>Exchange Code *</font></td>
			<td size="15" maxlength="10" width="25%">
				<select name="optExchCode" style="height: 22px; width: 199px">
					<option selected>----Select Exchange Code----</option>
					<option value="BOOE">BOOE</option>
					<option value="KCEX">KCEX</option>
				</select>
		</tr>
		<tr class=tdbglight width="100%">
			<td align="left" height="20" width="15%"> <font class=blacktext>App. NO </font></td>
			<td size="15" maxlength="10" width="25%"><input type=text name="txtAppNo" style="height: 22px; width: 199px"></td>
			<td align="left" height="20" width="15%"> <font class=blacktext>First Name </font></td>
			<td size="15" maxlength="10" width="25%"><input type=text name="txtFName" style="height: 22px; width: 199px"></td>
		</tr>
		<tr class=tdbglight width="100%">
			<td align="left" height="20" width="15%"> <font class=blacktext>Middle Name </font></td>
			<td size="15" maxlength="10" width="25%"><input type=text name="txtMName" style="height: 22px; width: 199px"></td>
			<td align="left" height="20" width="15%"> <font class=blacktext>Last Name *</font></td>
			<td size="15" maxlength="10" width="25%"><input type=text name="txtLName" style="height: 22px; width: 199px" ></td>
		</tr>
		<tr class=tdbglight width="50%">
			<td align="left" height="20" width="15%"> <font class=blacktext>Gender *</font></td>
			<td size="15" maxlength="10" width="25%">
				<select name="optGender" style="height: 22px; width: 199px">
					<option selected>-----Select Gender----</option>
					<option value="M">Male</option>
					<option value="F">Female</option>
			</select>
			<td class=tdbglight width="15%" height="20"><font class=blacktext>Date of Birth *</font></td>
			<td  class=tdbglight height="20" width="25%"> 
			<select size="1" name="optDMonth">
				<option  value="1" <%if lMonth=1 then Response.Write "selected"%>>January</option>
				<option value="2" <%if lMonth=2 then Response.Write "selected"%>>February</option>
				<option value="3" <%if lMonth=3 then Response.Write "selected"%>>March</option>
				<option value="4" <%if lMonth=4 then Response.Write "selected"%>>April</option>
				<option value="5" <%if lMonth=5 then Response.Write "selected"%>>May</option>
				<option value="6" <%if lMonth=6 then Response.Write "selected"%>>June</option>
				<option value="7" <%if lMonth=7 then Response.Write "selected"%>>July</option>
				<option value="8" <%if lMonth=8 then Response.Write "selected"%>>August</option>
				<option value="9" <%if lMonth=9 then Response.Write "selected"%>>September</option>
				<option value="10" <%if lMonth=10 then Response.Write "selected"%>>October</option>
				<option value="11" <%if lMonth=11 then Response.Write "selected"%>>November</option>
				<option value="12" <%if lMonth=12 then Response.Write "selected"%>>December</option>
			</select> 
			<select size="1" name="optDDate">
				<option  value="1" <%if lDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lDate=2 then Response.Write "selected"%>>2</option>
				<option value="3" <%if lDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lDate=4 then Response.Write "selected"%>>4</option>
				<option value="5" <%if lDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lDate=6 then Response.Write "selected"%>>6</option>
				<option value="7" <%if lDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lDate=8 then Response.Write "selected"%>>8</option>
				<option value="9" <%if lDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lDate=10 then Response.Write "selected"%>>10</option>
				<option value="11" <%if lDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lDate=12 then Response.Write "selected"%>>12</option>
				<option value="13" <%if lDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lDate=14 then Response.Write "selected"%>>14</option>
				<option value="15" <%if lDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lDate=16 then Response.Write "selected"%>>16</option>
				<option value="17" <%if lDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lDate=18 then Response.Write "selected"%>>18</option>
				<option value="19" <%if lDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lDate=20 then Response.Write "selected"%>>20</option>
				<option value="21" <%if lDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lDate=22 then Response.Write "selected"%>>22</option>
				<option value="23" <%if lDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lDate=24 then Response.Write "selected"%>>24</option>
				<option value="25" <%if lDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lDate=26 then Response.Write "selected"%>>26</option>
				<option value="27" <%if lDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lDate=28 then Response.Write "selected"%>>28</option>
				<option value="29" <%if lDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lDate=30 then Response.Write "selected"%>>30</option>
				<option value="31" <%if lDate=31 then Response.Write "selected"%>>31</option>
			</select>&nbsp;
			<select name="optDYear"  size="1" >
				<option value="<%=lYearPrev%>" selected><%=lYearPrev%></option>
				<option value="<%=lYear%>" selected><%=lYear%></option>
			</select>
			</td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20" colspan="4"> <font class=blackboldtext>Permanent Address</font></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Per.Address1 * </font></td>
			<td size="15" maxlength="10"><input type=text name="txtPAdd1" ></td>
			<td align="left" height="20"> <font class=blacktext>Per.Address2 </font></td>
			<td size="15" maxlength="10"><input type=text name="txtPAdd2" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Per.Address3 </font></td>
			<td size="15" maxlength="10"><input type=text name="txtPAdd3" ></td>
			<td align="left" height="20"> <font class=blacktext>Phone</font></td>
			<td size="15" maxlength="10"><input type=text name="txtPhone" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Fax</font></td>
			<td size="15" maxlength="10"><input type=text name="txtFax" ></td>
			<td align="left" height="20"> <font class=blacktext>Email-Id *</font></td>
			<td size="15" maxlength="10"><input type=text name="txtEmailId" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>PAN No</font></td>
			<td size="15" maxlength="10" colspan=3><input type=text name="txtPanNo" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20" colspan="4"> <font class=blackboldtext>Contact Address</font></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Contact Address1 *</font></td>
			<td size="15" maxlength="10"><input type=text name="txtCAdd1" ></td>
			<td align="left" height="20"> <font class=blacktext>Contact Address2 </font></td>
			<td size="15" maxlength="10"><input type=text name="txtCAdd2" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Contact Address3 </font></td>
			<td size="15" maxlength="10" colspan="3"><input type=text name="txtCAdd3" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20" colspan="4"> <font class=blackboldtext>Owner Details</font></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Contact Person Name * </font></td>
			<td size="15" maxlength="10"><input type=text name="txtCPName" ></td>
			<td align="left" height="20"> <font class=blacktext>Sales Tax No </font></td>
			<td size="15" maxlength="10"><input type=text name="txtSTNo" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>CST No </font></td>
			<td size="15" maxlength="10" colspan="3"><input type=text name="txtCSTNo" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20" colspan="4"> <font class=blackboldtext>Fee Details</font></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Reg. Fee * </font></td>
			<td size="15" maxlength="10"><input type=text name="txtRegFee" ></td>
			<td align="left" height="20"> <font class=blacktext>Equity Fee * </font></td>
			<td size="15" maxlength="10"><input type=text name="txtEFee" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20"> <font class=blacktext>Deposit *</font></td>
			<td size="15" maxlength="10" colspan=3><input type=text name="txtDeposit" ></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20" colspan=4> <font class=blackboldtext>Period</font></td>
		</tr>
		<tr class=tdbglight>
			<td align="left" height="20" > <font class=blacktext>Start Date</font></td>
			<td  class=tdbglight height="20" width="25%"> 
			<select size="1" name="optSMonth">
				<option  value="1" <%if lMonth=1 then Response.Write "selected"%>>January</option>
				<option value="2" <%if lMonth=2 then Response.Write "selected"%>>February</option>
				<option value="3" <%if lMonth=3 then Response.Write "selected"%>>March</option>
				<option value="4" <%if lMonth=4 then Response.Write "selected"%>>April</option>
				<option value="5" <%if lMonth=5 then Response.Write "selected"%>>May</option>
				<option value="6" <%if lMonth=6 then Response.Write "selected"%>>June</option>
				<option value="7" <%if lMonth=7 then Response.Write "selected"%>>July</option>
				<option value="8" <%if lMonth=8 then Response.Write "selected"%>>August</option>
				<option value="9" <%if lMonth=9 then Response.Write "selected"%>>September</option>
				<option value="10" <%if lMonth=10 then Response.Write "selected"%>>October</option>
				<option value="11" <%if lMonth=11 then Response.Write "selected"%>>November</option>
				<option value="12" <%if lMonth=12 then Response.Write "selected"%>>December</option>
			</select> 
			<select size="1" name="optSDate">
				<option  value="1" <%if lDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lDate=2 then Response.Write "selected"%>>2</option>
				<option value="3" <%if lDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lDate=4 then Response.Write "selected"%>>4</option>
				<option value="5" <%if lDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lDate=6 then Response.Write "selected"%>>6</option>
				<option value="7" <%if lDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lDate=8 then Response.Write "selected"%>>8</option>
				<option value="9" <%if lDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lDate=10 then Response.Write "selected"%>>10</option>
				<option value="11" <%if lDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lDate=12 then Response.Write "selected"%>>12</option>
				<option value="13" <%if lDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lDate=14 then Response.Write "selected"%>>14</option>
				<option value="15" <%if lDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lDate=16 then Response.Write "selected"%>>16</option>
				<option value="17" <%if lDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lDate=18 then Response.Write "selected"%>>18</option>
				<option value="19" <%if lDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lDate=20 then Response.Write "selected"%>>20</option>
				<option value="21" <%if lDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lDate=22 then Response.Write "selected"%>>22</option>
				<option value="23" <%if lDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lDate=24 then Response.Write "selected"%>>24</option>
				<option value="25" <%if lDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lDate=26 then Response.Write "selected"%>>26</option>
				<option value="27" <%if lDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lDate=28 then Response.Write "selected"%>>28</option>
				<option value="29" <%if lDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lDate=30 then Response.Write "selected"%>>30</option>
				<option value="31" <%if lDate=31 then Response.Write "selected"%>>31</option>
			</select>&nbsp;
			<select name="optSYear"  size="1" >
				<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
				<option value="<%=lYear%>" selected><%=lYear%></option>
			</select>
			</td>
			<td align="left" height="20" > <font class=blacktext>Start Date</font></td>
			<td  class=tdbglight height="20" width="25%"> 
			<select size="1" name="optEMonth">
				<option  value="1" <%if lMonth=1 then Response.Write "selected"%>>January</option>
				<option value="2" <%if lMonth=2 then Response.Write "selected"%>>February</option>
				<option value="3" <%if lMonth=3 then Response.Write "selected"%>>March</option>
				<option value="4" <%if lMonth=4 then Response.Write "selected"%>>April</option>
				<option value="5" <%if lMonth=5 then Response.Write "selected"%>>May</option>
				<option value="6" <%if lMonth=6 then Response.Write "selected"%>>June</option>
				<option value="7" <%if lMonth=7 then Response.Write "selected"%>>July</option>
				<option value="8" <%if lMonth=8 then Response.Write "selected"%>>August</option>
				<option value="9" <%if lMonth=9 then Response.Write "selected"%>>September</option>
				<option value="10" <%if lMonth=10 then Response.Write "selected"%>>October</option>
				<option value="11" <%if lMonth=11 then Response.Write "selected"%>>November</option>
				<option value="12" <%if lMonth=12 then Response.Write "selected"%>>December</option>
			</select> 
			<select size="1" name="optEDate">
				<option  value="1" <%if lDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lDate=2 then Response.Write "selected"%>>2</option>
				<option value="3" <%if lDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lDate=4 then Response.Write "selected"%>>4</option>
				<option value="5" <%if lDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lDate=6 then Response.Write "selected"%>>6</option>
				<option value="7" <%if lDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lDate=8 then Response.Write "selected"%>>8</option>
				<option value="9" <%if lDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lDate=10 then Response.Write "selected"%>>10</option>
				<option value="11" <%if lDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lDate=12 then Response.Write "selected"%>>12</option>
				<option value="13" <%if lDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lDate=14 then Response.Write "selected"%>>14</option>
				<option value="15" <%if lDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lDate=16 then Response.Write "selected"%>>16</option>
				<option value="17" <%if lDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lDate=18 then Response.Write "selected"%>>18</option>
				<option value="19" <%if lDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lDate=20 then Response.Write "selected"%>>20</option>
				<option value="21" <%if lDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lDate=22 then Response.Write "selected"%>>22</option>
				<option value="23" <%if lDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lDate=24 then Response.Write "selected"%>>24</option>
				<option value="25" <%if lDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lDate=26 then Response.Write "selected"%>>26</option>
				<option value="27" <%if lDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lDate=28 then Response.Write "selected"%>>28</option>
				<option value="29" <%if lDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lDate=30 then Response.Write "selected"%>>30</option>
				<option value="31" <%if lDate=31 then Response.Write "selected"%>>31</option>
			</select>&nbsp;
			<select name="optEYear"  size="1" >
				<option value="<%=lYearPrev%>"><%=lYearPrev%></option>
				<option value="<%=lYear%>" selected><%=lYear%></option>
			</select>
			</td>
		</tr>
		<input type=hidden name="hidActionValue">
		<tr class=tdbglight>
			<td align="center" height="20" colspan=4>
				<input type=button name="btnAdd" value="Add" onclick =" return CheckAction(1);">
				<!--
				<input type=button name="btnApply" value="Apply" onclick ="return CheckAction(4);">
				-->
				<input type=reset name="btnClear" value="Clear" >
			</td>
		</tr>
	</table><br><br>
	</form>
	</body>
	</html>
