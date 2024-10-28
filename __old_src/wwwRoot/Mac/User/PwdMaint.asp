	<%@ Language=VBScript %>
	<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	PwdMaint.asp									      *
	'* Purpose		:	This is used for			.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for										  *
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
	dim lUserType
	dim lUserId
	dim lExchangeId
	dim lObjCoyId
	dim lCoyId
	dim lDisCoyId
	dim lActVal
	
	lCurrentDate=now()
	lMonth= month(lCurrentDate)
	lDate=day(lCurrentDate)
	lYear=year(lCurrentDate)
	lYearPrev	= lYear -1
	
	lUserType = trim(Request.Form("hidUserType"))
	lUserId = trim(Request.Form("hidUserId"))
	lExchangeId = trim(Request.Form("optExchgcode"))
'	Response.Write "User Id = " & lUserId & "<br>"
'	Response.Write "User Type = " & lUserType & "<br>"
	if lUserType <> "" then
'		Response.Write "User Type = " & lUserType
		lActVal = trim(Request.Form("hidActionValue"))
		Response.Write lActVal
		set lObjLogPwdMain	= server.CreateObject("MacWebCon.clsMacWebCon")
		set lRsUserId		= server.CreateObject("adodb.recordset")
		set lRsUserId = lObjLogPwdMain.GetUsersByType(cstr(lUserType)) 
		'select case(lUserType)
		'case	"T"	:	set lRsUserId		=	lObjLogPwdMain.GetTcmds() 
		'case	"I"	:	set lRsUserId		=	lObjLogPwdMain.GetIcmds() 
		'case	"J"	:	set lRsUserId		=	lObjLogPwdMain.GetTcmds() 
		'case	"C"	:	set lRsUserId		=	lObjLogPwdMain.GetClientIds() 
		'case	"M"	:	set lRsUserId		=	lObjLogPwdMain.GetUsers()
		'case	"R"	:	set lRsUserId		=	lObjLogPwdMain.GetUsers()
		'case	"U"	:	set lRsUserId		=	lObjLogPwdMain.GetUsers()
		'end select
		if  lUserId <> "" then
			lCoyId = lObjLogPwdMain.GetCompanyCode(lUserId,lUserType)
		end if
	end if %>
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<script language="Javascript">
	function validateDate()
	{		
		lSDate	= document.frmLogPwdMaint.StartDate.value ;
		lSMonth	= document.frmLogPwdMaint.StartMonth.value;
		lSYear	= document.frmLogPwdMaint.StartYear.value;
		lEDate	=	document.frmLogPwdMaint.EndDate.value;
		lEMonth	=	document.frmLogPwdMaint.EndMonth.value;
		lEYear	=	document.frmLogPwdMaint.EndYear.value;  
		lSDay	=	new Date(lSMonth + '/' + lSDate +'/'+ lSYear );
		lEDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear);
		if (lSDay > lEDay) 
		{
			document.frmLogPwdMaint.StartMonth.focus(); 
			alert("Start date should be Greater than End date");
			return false;
		}
		if ((validDate(lSMonth,lSDate,lSYear))== false )
		{
			document.frmLogPwdMaint.StartDate.focus();
			alert("Please Enter valid Start Date");
			return false;
		}
		if ((validDate(lEMonth,lEDate,lEYear))== false)
		{
			document.frmLogPwdMaint.EndDate.focus(); 
			alert("Please Enter valid End Date");
			return false;
		}
		return true;
	}
		
	function validDate(vMonth,vDay,vYear)
	{
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
		
	if (vDay>vaMonths[vMonth])
		{
		return false;
		}
	return true;
	}	

	function CheckEndDate()
	{
    lEDate	=	document.frmLogPwdMaint.EndDate.value
    lEMonth	=	document.frmLogPwdMaint.EndMonth.value
	lEYear	=	document.frmLogPwdMaint.EndYear.value	
	lDay	=	new Date(lEMonth + '/' + lEDate + '/' + lEYear)
	lCDay	=	new Date();
	lCMonth =   lCDay.getMonth();
	lCMonth =	lCMonth + 1
	lCDate	=	lCDay.getDate();
	lCYear	=	lCDay.getYear();
	
	if (lEMonth > lCMonth)
	{	
		document.frmLogPwdMaint.EndMonth.focus(); 
		alert("Please Enter Correct Month.\nEnd Date should be Less than or Equal to Current Date.");
		return false;
	}
	if (lEDate > lCDate)
	{	
		document.frmLogPwdMaint.EndDate.focus();
		alert("Please Enter Correct Date.\nEnd Date should be Less than or Equal to Current Date.");
		return false;
	}
	if (lEYear > lCYear)
	{	
		document.frmLogPwdMaint.EndYear.focus(); 
		alert("Please Enter Correct Year.\nEnd Date should be Less than or Equal to Current Date.");
		return false;
	}
	return true;
	}
	
	function CheckMacUser()
	{
		if (( document.frmLogPwdMaint.optUserType.value != "M"  ) && (document.frmLogPwdMaint.btnView.disabled == false )){
			document.frmLogPwdMaint.optAccessType.disabled = true;}	
	}
	 
	function CheckAction(btnValue){
	var lActionValue	=	btnValue;
	if ((lActionValue == 1) && (CheckValues())){
		document.frmLogPwdMaint.action="PwdMaintRes.asp";
		document.frmLogPwdMaint.method="post";
		document.frmLogPwdMaint.submit();}
	else if((lActionValue == 2)&& (CheckValues())){
		document.frmLogPwdMaint.action="PwdMaintAdd.asp";
		document.frmLogPwdMaint.method="post";
		document.frmLogPwdMaint.submit(); }}
	
	function CheckValues(){
		if (document.frmLogPwdMaint.optExchgcode.value==""){
			document.frmLogPwdMaint.optExchgcode.focus();
			alert("Please select Exchange ID");  
			return false;}
		if (document.frmLogPwdMaint.optUserType.value ==""){
			document.frmLogPwdMaint.optUserType.focus();
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
		if ((document.frmLogPwdMaint.optUserType.value =="M") && (document.frmLogPwdMaint.optAccessType.value =="" )&& (document.frmLogPwdMaint.btnView.disabled ==false )){
			document.frmLogPwdMaint.optAccessType.focus();
			alert("Please select the Access type");
			return false;}
		/*
		if (document.frmLogPwdMaint.txtPwd.value =="") 
		{
			document.frmLogPwdMaint.txtPwd.focus();
			alert("Please enter the Password");  
			return false;
		}
		
		if (document.frmLogPwdMaint.txtConfPwd.value =="") 
		{
			document.frmLogPwdMaint.txtConfPwd.focus();
			alert("Please enter the confirm Password");  
			return false;
		}
		var lPwd	= document.frmLogPwdMaint.txtPwd.value;
		var lCPwd	= document.frmLogPwdMaint.txtConfPwd.value;
		if (lPwd != lCPwd)
		{
			document.frmLogPwdMaint.txtConfPwd.focus();
			alert("Please type correct cofirm password");
			return false;
		}
		*/
		return true;
	}
	

	function defaultfocus()
	{
	/*
		document.frmLogPwdMaint.btnAdd.disabled = false;
		document.frmLogPwdMaint.btnView.disabled = false;
//		document.frmLogPwdMaint.btnEdit.disabled = true;
		document.frmLogPwdMaint.btnCancel.disabled = true;      
		document.frmLogPwdMaint.optExchgcode.disabled = true;
//		document.frmLogPwdMaint.optUserId.disabled = true;
		document.frmLogPwdMaint.optUserType.disabled = true;
//		document.frmLogPwdMaint.optCompanyId.disabled = true;
		document.frmLogPwdMaint.optAccessType.disabled = true;
		document.frmLogPwdMaint.txtPwd.disabled = true;
		document.frmLogPwdMaint.txtConfPwd.disabled = true; 
		document.frmLogPwdMaint.StartDate.disabled = true;
		document.frmLogPwdMaint.StartMonth.disabled = true;
		document.frmLogPwdMaint.StartYear.disabled = true;
		document.frmLogPwdMaint.EndDate.disabled =true;
		document.frmLogPwdMaint.EndMonth.disabled =true;
		document.frmLogPwdMaint.EndYear.disabled = true; 
		document.frmLogPwdMaint.btnApply.disabled =true;   
		*/
	}

	function ViewValues()	
	{
		document.frmLogPwdMaint.btnAdd.disabled = false;
		document.frmLogPwdMaint.btnView.disabled = false;
	//	document.frmLogPwdMaint.btnEdit.disabled = true;
		document.frmLogPwdMaint.btnCancel.disabled = true;      
		document.frmLogPwdMaint.optExchgcode.disabled = false;
//		document.frmLogPwdMaint.optUserId.disabled = false;
		document.frmLogPwdMaint.optUserType.disabled = false; 
//		document.frmLogPwdMaint.optCompanyId.disabled = false;
		document.frmLogPwdMaint.optAccessType.disabled = true;
		document.frmLogPwdMaint.txtPwd.disabled = true;
		document.frmLogPwdMaint.txtConfPwd.disabled = true; 
		document.frmLogPwdMaint.StartDate.disabled = true;
		document.frmLogPwdMaint.StartMonth.disabled = true;
		document.frmLogPwdMaint.StartYear.disabled = true;
		document.frmLogPwdMaint.EndDate.disabled =true;
		document.frmLogPwdMaint.EndMonth.disabled =true;
		document.frmLogPwdMaint.EndYear.disabled = true;   
		document.frmLogPwdMaint.btnApply.disabled = false; 
		document.frmLogPwdMaint.btnView.disabled = true;   
		document.frmLogPwdMaint.hidActionValue.value =2;   
	}
	
	function AddValues()	 
	{
		document.frmLogPwdMaint.btnAdd.disabled = true;
		document.frmLogPwdMaint.btnView.disabled = true;
	//	document.frmLogPwdMaint.btnEdit.disabled = true;
		document.frmLogPwdMaint.btnCancel.disabled = true;      
		document.frmLogPwdMaint.optExchgcode.disabled = false;
//		document.frmLogPwdMaint.optUserId.disabled = false;
		document.frmLogPwdMaint.optUserType.disabled = false;
//		document.frmLogPwdMaint.optCompanyId.disabled = false;
		document.frmLogPwdMaint.optAccessType.disabled = false;
		document.frmLogPwdMaint.txtPwd.disabled = false;
		document.frmLogPwdMaint.txtConfPwd.disabled = false; 
		document.frmLogPwdMaint.StartDate.disabled = false;
		document.frmLogPwdMaint.StartMonth.disabled = false;
		document.frmLogPwdMaint.StartYear.disabled = false;
		document.frmLogPwdMaint.EndDate.disabled =false;
		document.frmLogPwdMaint.EndMonth.disabled =false;
		document.frmLogPwdMaint.EndYear.disabled = false; 
		document.frmLogPwdMaint.btnApply.disabled =false; 
		document.frmLogPwdMaint.hidActionValue.value =1;   
		
	}
	
	function DisplayIds(){
		var lSelIndex = document.frmLogPwdMaint.optUserType.selectedIndex;
		var lSelValue = document.frmLogPwdMaint.optUserType.options[lSelIndex].value;
		document.frmLogPwdMaint.hidUserType.value = lSelValue;
		document.frmLogPwdMaint.hidActionValue.value ='<%=lActVal%>';		
		document.frmLogPwdMaint.submit();}	
	
	function DisCoyId(){
		var lSelIndex = document.frmLogPwdMaint.optUserType.selectedIndex;
		var lSelValue = document.frmLogPwdMaint.optUserType.options[lSelIndex].value;
		document.frmLogPwdMaint.hidUserType.value = lSelValue;
		var lSIndex = document.frmLogPwdMaint.optUserId.selectedIndex;
		var lSValue = document.frmLogPwdMaint.optUserId.options[lSIndex].value;
		document.frmLogPwdMaint.hidUserId.value = lSValue;
		document.frmLogPwdMaint.hidActionValue.value ='<%=lActVal%>';
		document.frmLogPwdMaint.submit(); }
	</script>
	
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor onload="defaultfocus()">
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	<form name="frmLogPwdMaint" method="post"  onsubmit="return validateDate();">
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1"> Logon and Password Maintenance </font></td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Exchange ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%">			
				<select name="optExchgcode" style="height: 22px; width: 199px">
					<option >------    Exchange ID    ------</option>
					<option value="BOOE" <%if lExchangeId="BOOE" then Response.Write "selected"%>>BOOE</option>
					<option value="KCE" <%if lExchangeId="KCE" then Response.Write "selected"%>>KCEX</option>
				</select> 
	        </td>
		</tr>
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User Type</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optUserType" style="HEIGHT: 22px; WIDTH: 199px" onchange="DisplayIds(),CheckMacUser();">
					<option selected>------   User Type  ------</option>
					<option value="T" <%if lUserType ="T" then Response.Write "selected" %>>TCM</option>
					<option value="I" <%if lUserType ="I" then Response.Write "selected" %>>ICM</option>
					<option value="J" <%if lUserType ="J" then Response.Write "selected" %>>Sub-Broker</option>
					<option value="C" <%if lUserType ="C" then Response.Write "selected" %>>Client</option>
					<option value="M" <%if lUserType ="M" then Response.Write "selected" %>>MAC</option>
					<option value="R" <%if lUserType ="R" then Response.Write "selected" %>>Surveillance Manager</option>
					<option value="U" <%if lUserType ="U" then Response.Write "selected" %>>Surveillance User</option>
				</select> 
	        </td>
		</tr>		
		<tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<%if trim(Request.Form("hidUserType")) <> "" then
					if not (lRsUserId.BOF and lRsUserId.EOF) then %>
						<select name="optUserId" style="HEIGHT: 22px; WIDTH: 199px" onchange="DisCoyId()">
							<option selected>------   User ID   ------</option>
							<%while not lRsUserId.EOF %>
								<option value="<%=lRsUserId.Fields(0).Value %>" <%if lRsUserId.Fields(0).Value = lUserId then Response.Write "selected" %>	><%=lRsUserId.Fields(0).Value %></option>							
								<%lRsUserId.MoveNext 
							wend
						else
							Response.Write "<font align='left' class='blacktext'>No UserID is available</font>"
						 end if
							Response.Write "</select>"
					else 
						Response.Write "<font align='left' class='blacktext'>Please select User Type to display User IDs</font>"
					end if%></td>
		</tr>
		
	    <tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Company ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
	        <%if trim(Request.Form("hidUserId")) <> ""  then
				if  lCoyId <> "NoCompany" then %>
					<select name="optCompanyId" style="HEIGHT: 22px; WIDTH: 199px">
						<option value="<%=lCoyId%>" selected><%=lCoyId%></option>
					</select> 
				<%else%>
					<font align="left" class="blacktext"> CompanyId is not available</font>
				<%end if%>
		     
		     <%else%>
				<font align="left" class="blacktext"> Please select UserId to display CompanyId</font>
		     <%end if%>
	        </td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext"> Password</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight"> 
				<input type="password" size="26.7"  maxlength="10" name="txtPwd">
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
			<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" >
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
			<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
				<option value="<%=lYearPrev%>" selected><%=lYearPrev%></option>
				<option value="<%=lYear%>" selected><%=lYear%></option>
			</select>
			</td>
		</tr>
		<tr><td class=tdbglight width="230" height="25" width="20%"><font class=blacktext>PasswordEnd Date</font></td>
			<td WIDTH="367" CLASS=tdbglight height="25"> 
			<select size="1" name="EndMonth" style="HEIGHT: 22px; WIDTH: 92px" >
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
			<select size="1" name="EndDate" style="HEIGHT: 22px; WIDTH: 40px" >
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
			<select name="EndYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" >
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
					<option selected>------  Access Type  ------</option>
					<option value="T">Full Control</option>
					<option value="I">Read</option>
				</select> 
			</td>
		</tr>			
		<tr class="tdbglight"> 
			<td colspan=2 valign="center" align=middle height="27">
				<input type="button" name=btnAdd value="Add" onclick ="AddValues();">
				<input type="button" name="btnView" value="View" onclick ="ViewValues(); ">
				<input type="button" name="btnApply" value="Apply" onclick ="return CheckAction(1);">
				<!--
				<input type="button" name="btnEdit" value="Edit" onclick ="return CheckAction(3);">
				-->
				<input type="reset" name="btnCancel" value="Cancel" >
			</td>
		</tr>
	</table>
	
	<!--hidden fields included-->
	<input type=hidden name="hidUserType" >
	<input type=hidden name="hidUserId" >
	<input type=hidden name="hidActionValue">
		
	</form>
	<br><!---#include file="../includes/footer.inc"--->
	<body>
	<%
	set lRsUserId = nothing
	set lObjLogPwdMain = nothing
	'set lObjCoyId = nothing
	
	%>
	</html>
	
	