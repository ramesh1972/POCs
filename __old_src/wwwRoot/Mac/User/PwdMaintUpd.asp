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
	
	dim lCurrentDate
	dim lMonth
	dim lDate
	dim lYear
	dim lYearPrev
	dim lObjLogPwdMain
	dim lRsUserId
	dim lExchgcode
	dim lUserType 
	dim lUserId 
	dim lCompanyId
	dim lPwd
	dim lStartMonth
	dim lStartDate
	dim lStartYear
	dim lEndMonth
	dim lEndDate
	dim lEndYear
	dim lAccessType
		
	lExchgcode = trim(Request.Form("hidExchgcode"))
	lUserType = trim(Request.Form("hidUserType")) 
	lUserId  = trim(Request.Form("hidUserId"))
	lCompanyId = trim(Request.Form("hidCompanyId"))
	lPwd = trim(Request.Form("hidPwd"))
	lStartMonth = trim(Request.Form("hidStartMonth"))
	lStartDate = trim(Request.Form("hidStartDate"))
	lStartYear = trim(Request.Form("hidStartYear"))
	lEndMonth = trim(Request.Form("hidEndMonth"))
	lEndDate = trim(Request.Form("hidEndDate"))
	lEndYear = trim(Request.Form("hidEndYear"))
	lAccessType = trim(Request.Form("hidAccessType"))

	lCurrentDate=now()
	lMonth= month(lCurrentDate)
	lDate=day(lCurrentDate)
	lYear=year(lCurrentDate)
	lYearPrev	= lYear -1
	%>
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<script language="Javascript">
	function validateDate(){
		lSDate	= document.frmLogPwdMaint.StartDate.value ;
		lSMonth	= document.frmLogPwdMaint.StartMonth.value;
		lSYear	= document.frmLogPwdMaint.StartYear.value;
		lEDate	=	document.frmLogPwdMaint.EndDate.value;
		lEMonth	=	document.frmLogPwdMaint.EndMonth.value;
		lEYear	=	document.frmLogPwdMaint.EndYear.value;  
		lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
		lEDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear);
		if (lSDay > lEDay){
			document.frmLogPwdMaint.StartMonth.focus(); 
			alert("Start date should be Greater than End date");
			return false;}
		if ((validDate(lSMonth,lSDate,lSYear))== false ){
			document.frmLogPwdMaint.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;}
		if ((validDate(lEMonth,lEDate,lEYear))== false){
			document.frmLogPwdMaint.EndDate.focus(); 
			alert("Please Enter valid End Date");
			return false;}
		return true;}
		
	function validDate(vMonth,vDay,vYear){
	var vaMonths = new Array();
	vaMonths[1]=31;
	if (vYear%4==0)
		vaMonths[2]=29;
	else
		vaMonths[2]=28;

	vaMonths[3]=31;
	vaMonths[4]=30;
	vaMonths[5]=31;
	vaMonths[6]=30;
	vaMonths[7]=31;
	vaMonths[8]=31;
	vaMonths[9]=30;
	vaMonths[10]=31;
	vaMonths[11]=30;
	vaMonths[12]=31;
	if (vDay>vaMonths[vMonth]){return false;}
	return true;}	

	function CheckEndDate(){
    lEDate	=	document.frmLogPwdMaint.EndDate.value
    lEMonth	=	document.frmLogPwdMaint.EndMonth.value
	lEYear	=	document.frmLogPwdMaint.EndYear.value	
	lDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear)
	lCDay	=	new Date();
	lCMonth =   lCDay.getMonth();
	lCMonth =	lCMonth + 1
	lCDate	=	lCDay.getDate();
	lCYear	=	lCDay.getYear();
	if (lEMonth > lCMonth){	
		document.frmLogPwdMaint.EndMonth.focus(); 
		alert("Please Enter Correct Month.\nEnd Date should be Less than or Equal to Current Date.");
		return false;}
	if (lEDate > lCDate){	
		document.frmLogPwdMaint.EndDate.focus();
		alert("Please Enter Correct Date.\nEnd Date should be Less than or Equal to Current Date.");
		return false;}
	if (lEYear > lCYear){	
		document.frmLogPwdMaint.EndYear.focus(); 
		alert("Please Enter Correct Year.\nEnd Date should be Less than or Equal to Current Date.");
		return false;}
	return true;}
	
	function CheckAction(btnValue){
		var lActionValue	=	btnValue;
			if (lActionValue == 1) {
				if (CheckValues()==true){
					document.frmLogPwdMaint.action="PwdMURes.asp";
					document.frmLogPwdMaint.method="post";
					document.frmLogPwdMaint.submit();}
				else
					{ return false;}}}
	
	function CheckValues(){
		if (document.frmLogPwdMaint.optExchgcode.value==""){
			document.frmLogPwdMaint.optExchgcode.focus();
			alert("Please select Exchange ID");  
			return false;}
		if (document.frmLogPwdMaint.optUserype.value ==""){
			document.frmLogPwdMaint.optUserype.focus();
			alert("Please select User Type");  
			return false;}
		if (document.frmLogPwdMaint.optUserId.value ==""){
			document.frmLogPwdMaint.optUserId.focus();
			alert("Please select User ID");  
			return false;}
		if (document.frmLogPwdMaint.optCompanyId.value ==""){
			document.frmLogPwdMaint.optCompanyId.focus();
			alert("Please select Company ID");  
			return false;}
		if ((document.frmLogPwdMaint.optUserype.value =="M") && (document.frmLogPwdMaint.optAccessType.value =="" )){
			document.frmLogPwdMaint.optAccessType.focus();
			alert("Please select the Access type");
			return false;}
		if (document.frmLogPwdMaint.txtPwd.value ==""){
			document.frmLogPwdMaint.txtPwd.focus();
			alert("Please enter the Password");  
			return false;}
		if (document.frmLogPwdMaint.txtConfPwd.value ==""){
			document.frmLogPwdMaint.txtConfPwd.focus();
			alert("Please enter the confirm Password");  
			return false;}
		var lPwd	= document.frmLogPwdMaint.txtPwd.value;
		var lCPwd	= document.frmLogPwdMaint.txtConfPwd.value;
		if (lPwd != lCPwd){
			document.frmLogPwdMaint.txtConfPwd.focus();
			alert("Please type correct cofirm password");
			return false;}
		return true;}
	</script>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	<form name="frmLogPwdMaint" method="post">
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1"> Logon and Password Maintenance </font></td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Exchange ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%">
				<select name="optExchgcode" style="height: 22px; width: 199px" disabled>
					<option value="<%=lExchgcode%>" selected><%=lExchgcode%></option>
				</select> 
	        </td>
		</tr>
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User Type</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optUserype" style="HEIGHT: 22px; WIDTH: 199px" disabled>
					<option value="<%=lUserType %>" selected ><%=lUserType%></option>
				</select> 
	        </td>
		</tr>
		<tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optUserId" style="HEIGHT: 22px; WIDTH: 199px" disabled>
					<option value="<%=lUserId %>" selected ><%=lUserId %></option>
				</select> 
	        </td>
		</tr>
	    <tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Company ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optCompanyId" style="HEIGHT: 22px; WIDTH: 199px" disabled>
					<option value="<%=lCompanyId%>" selected><%=lCompanyId%></option>
		     </select> 
	        </td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Password</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight"> 
				<input type="password" size="26.7"  maxlength="10" name="txtPwd" value="<%=lPwd%>">
	        </td>
		</tr>
	    <tr class="tdbglight"> 
			<td  height="27" align=left width="20%"> 
				<font align="left"><font class=blacktext>Confirm Password</font></font>
	        </td>
	        <td align="left" height="27"  width="30%" class="tdbglight"> 
				<input type="password" size="26.7" maxlength="10" name="txtConfPwd">
	        </td>
		</tr>
		<tr><td class=tdbglight width="230" height="25" width="20%"><font class=blacktext>Password Start Date</font></td>
			<td WIDTH="367" CLASS=tdbglight height="25"> 
			<select size="1" name="StartMonth" style="height: 22px; width: 92px" >
				<option  value="1" <%if lStartMonth=1 then Response.Write "selected"%>>January</option>
				<option value="2" <%if lStartMonth=2 then Response.Write "selected"%>>February</option>
				<option value="3" <%if lStartMonth=3 then Response.Write "selected"%>>March</option>
				<option value="4" <%if lStartMonth=4 then Response.Write "selected"%>>April</option>
				<option value="5" <%if lStartMonth=5 then Response.Write "selected"%>>May</option>
				<option value="6" <%if lStartMonth=6 then Response.Write "selected"%>>June</option>
				<option value="7" <%if lStartMonth=7 then Response.Write "selected"%>>July</option>
				<option value="8" <%if lStartMonth=8 then Response.Write "selected"%>>August</option>
				<option value="9" <%if lStartMonth=9 then Response.Write "selected"%>>September</option>
				<option value="10" <%if lStartMonth=10 then Response.Write "selected"%>>October</option>
				<option value="11" <%if lStartMonth=11 then Response.Write "selected"%>>November</option>
				<option value="12" <%if lStartMonth=12 then Response.Write "selected"%>>December</option>
			</select> 
			<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" >
				<option  value="1" <%if lStartDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lStartDate=2 then Response.Write "selected"%>>2</option>
				<option value="3" <%if lStartDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lStartDate=4 then Response.Write "selected"%>>4</option>
				<option value="5" <%if lStartDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lStartDate=6 then Response.Write "selected"%>>6</option>
				<option value="7" <%if lStartDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lStartDate=8 then Response.Write "selected"%>>8</option>
				<option value="9" <%if lStartDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lStartDate=10 then Response.Write "selected"%>>10</option>
				<option value="11" <%if lStartDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lStartDate=12 then Response.Write "selected"%>>12</option>
				<option value="13" <%if lStartDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lStartDate=14 then Response.Write "selected"%>>14</option>
				<option value="15" <%if lStartDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lStartDate=16 then Response.Write "selected"%>>16</option>
				<option value="17" <%if lStartDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lStartDate=18 then Response.Write "selected"%>>18</option>
				<option value="19" <%if lStartDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lStartDate=20 then Response.Write "selected"%>>20</option>
				<option value="21" <%if lStartDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lStartDate=22 then Response.Write "selected"%>>22</option>
				<option value="23" <%if lStartDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lStartDate=24 then Response.Write "selected"%>>24</option>
				<option value="25" <%if lStartDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lStartDate=26 then Response.Write "selected"%>>26</option>
				<option value="27" <%if lStartDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lStartDate=28 then Response.Write "selected"%>>28</option>
				<option value="29" <%if lStartDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lStartDate=30 then Response.Write "selected"%>>30</option>
				<option value="31" <%if lStartDate=31 then Response.Write "selected"%>>31</option>
			</select>&nbsp;
			<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
				<option value=<%=lStartYear%> selected > <%=lStartYear%></option>
				<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
				<option value="<%=lYear%>" ><%=lYear%></option>
			</select>
			</td>
		</tr>
		<tr><td class=tdbglight width="230" height="25" width="20%"><font class=blacktext>PasswordEnd Date</font></td>
			<td WIDTH="367" CLASS=tdbglight height="25"> 
			<select size="1" name="EndMonth" style="HEIGHT: 22px; WIDTH: 92px" >
				<option  value="1" <%if lEndMonth=1 then Response.Write "selected"%>>January</option>
				<option value="2" <%if lEndMonth=2 then Response.Write "selected"%>>February</option>
				<option value="3" <%if lEndMonth=3 then Response.Write "selected"%>>March</option>
				<option value="4" <%if lEndMonth=4 then Response.Write "selected"%>>April</option>
				<option value="5" <%if lEndMonth=5 then Response.Write "selected"%>>May</option>
				<option value="6" <%if lEndMonth=6 then Response.Write "selected"%>>June</option>
				<option value="7" <%if lEndMonth=7 then Response.Write "selected"%>>July</option>
				<option value="8" <%if lEndMonth=8 then Response.Write "selected"%>>August</option>
				<option value="9" <%if lEndMonth=9 then Response.Write "selected"%>>September</option>
				<option value="10" <%if lEndMonth=10 then Response.Write "selected"%>>October</option>
				<option value="11" <%if lEndMonth=11 then Response.Write "selected"%>>November</option>
				<option value="12" <%if lEndMonth=12 then Response.Write "selected"%>>December</option>
			</select> 
			<select size="1" name="EndDate" style="HEIGHT: 22px; WIDTH: 40px" >
				<option  value="1" <%if lEndDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lEndDate=2 then Response.Write "selected"%>>2</option>
				<option value="3" <%if lEndDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lEndDate=4 then Response.Write "selected"%>>4</option>
				<option value="5" <%if lEndDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lEndDate=6 then Response.Write "selected"%>>6</option>
				<option value="7" <%if lEndDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lEndDate=8 then Response.Write "selected"%>>8</option>
				<option value="9" <%if lEndDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lEndDate=10 then Response.Write "selected"%>>10</option>
				<option value="11" <%if lEndDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lEndDate=12 then Response.Write "selected"%>>12</option>
				<option value="13" <%if lEndDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lEndDate=14 then Response.Write "selected"%>>14</option>
				<option value="15" <%if lEndDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lEndDate=16 then Response.Write "selected"%>>16</option>
				<option value="17" <%if lEndDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lEndDate=18 then Response.Write "selected"%>>18</option>
				<option value="19" <%if lEndDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lEndDate=20 then Response.Write "selected"%>>20</option>
				<option value="21" <%if lEndDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lEndDate=22 then Response.Write "selected"%>>22</option>
				<option value="23" <%if lEndDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lEndDate=24 then Response.Write "selected"%>>24</option>
				<option value="25" <%if lEndDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lEndDate=26 then Response.Write "selected"%>>26</option>
				<option value="27" <%if lEndDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lEndDate=28 then Response.Write "selected"%>>28</option>
				<option value="29" <%if lEndDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lEndDate=30 then Response.Write "selected"%>>30</option>
				<option value="31" <%if lEndDate=31 then Response.Write "selected"%>>31</option>
			</select>&nbsp;
			<select name="EndYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
				<option value=<%=lEndYear%> selected > <%=lEndYear%> </option>
				<option value="<%=lYearPrev%>" selected><%=lYearPrev%></option>
				<option value="<%=lYear%>" selected><%=lYear%></option>
			</select>
			</td>
		</tr>
		<tr> 
			<td  height="27" align=left width="20%" class="tdbglight"> 
				<font align="left"><font class=blacktext>Type of Access</font></font>
	        </td>
	        <td align="left" height="27"  width="30%" class="tdbglight"> 
				<select name="optAccessType" style="HEIGHT: 22px; WIDTH: 199px" >
					<option value="T" <%if lAccessType = "T" then Response.Write "selected" %>	>Full Control</option>
					<option value="I" <%if lAccessType = "I" then Response.Write "selected" %>>Read</option>
				</select> 
			</td>
		</tr>	
		<input type=hidden name="hidActionValue">	
		<input type="hidden" name="hidExchgcode" value="<%=lExchgcode%>">
		<input type="hidden" name="hidUserType" value="<%=lUserType%>">
		<input type="hidden" name="hidUserId" value="<%=lUserId%>">
		<input type="hidden" name="hidCompanyId" value="<%=lCompanyId%>">
		<tr class="tdbglight"> 
			<td colspan=2 valign="center" align=middle height="27">
				<input type="button" name=btnAdd value="Add" disabled>
				<input type="button" name="btnView" value="View" disabled>
				<input type="submit" name="btnApply" value="Apply" onclick ="return CheckAction(1);">
				<input type="button" name="btnEdit" value="Edit" disabled>
				<input type="reset" name="btnCancel" value="Cancel" disabled>
			</td>
		</tr>
	</table>
	</form>
	<br><!---#include file="../includes/footer.inc"--->
	<body>
	</html>
