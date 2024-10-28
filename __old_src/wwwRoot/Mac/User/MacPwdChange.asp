<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	MacPwdChange.asp									  *
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
	dim lUserType
	
	lCurrentDate=now()
	lMonth= month(lCurrentDate)
	lDate=day(lCurrentDate)
	lYear=year(lCurrentDate)
	lYearPrev	= lYear -1
	lUserType	= trim(Request.Form("hidUserType"))
	
	if lUserType <> "" then				
		set lObjLogPwdMain	= server.CreateObject("MacWebCon.clsMacWebCon")
		set lRsUserId		= server.CreateObject("adodb.recordset")
		
		set lRsUserId		=	lObjLogPwdMain.GetUsersByType(cstr(lUserType))		
				
		'select case(lUserType)
		'	case "T"	:
		'		set lRsUserId		=	lObjLogPwdMain.GetTcmds()
		'	case "I"	:
		'		set lRsUserId		=	lObjLogPwdMain.GetIcmds()
		'	case "C"	:
		'		set lRsUserId		=	lObjLogPwdMain.GetClientIds()
		'	case "J"	:
		'		set lRsUserId		=	lObjLogPwdMain.GetTcmds()
		'	case "M"	:
		'		set lRsUserId		=	lObjLogPwdMain.GetTcmds()
		'	case "R"	:
		'		set lRsUserId		=	lObjLogPwdMain.GetSubBrokers()
		'	case "U"	:
		'		set lRsUserId		=	lObjLogPwdMain.GetSurvUsers()
		'	end select
		
		'Response.Write lRsUserId.GetString 
	end if
	%>
	
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<script language="Javascript">
	function CheckAction(btnValue)
	{
		var lActionValue	=	btnValue;
			if ((lActionValue == 1) && (CheckValues()))
			{
				document.frmMacPwdChange.action="MacPwdChangeRes.asp";
				document.frmMacPwdChange.method="post";
				document.frmMacPwdChange.submit();
			}
			else if((lActionValue == 2)&& (CheckValues()))
			{
				document.frmMacPwdChange.action="MacPwdChangeRes.asp";
				document.frmMacPwdChange.method="post";
				document.frmMacPwdChange.submit(); 
			}
			else if(lActionValue == 3)
			{
				document.frmMacPwdChange.action="MacPwdChangeRes.asp";
				document.frmMacPwdChange.submit(); 
			}
		}
		
	function CheckValues()
	{
		if (document.frmMacPwdChange.optUserType.value =="") 
		{
			document.frmMacPwdChange.optUserType.focus();
			alert("Please select User Type");  
			return false;
		}
		
		if (document.frmMacPwdChange.optUserId.value =="") 
		{
			document.frmMacPwdChange.optUserId.focus();
			alert("Please select User Id");  
			return false;
		}
		
		if (document.frmMacPwdChange.txtOldPwd.value =="") 
		{
			document.frmMacPwdChange.txtOldPwd.focus();
			document.frmMacPwdChange.txtOldPwd.select();
			alert("Please enter the Old Password");  
			return false;
		}
		
		var lOPwd=document.frmMacPwdChange.txtOldPwd.value;
				
		if ((lOPwd.length < 5 ) ||(lOPwd.length >= 11))
		{
			alert("\nThe old password entered is incorrect.")
			document.frmMacPwdChange.txtOldPwd.select();
			document.frmMacPwdChange.txtOldPwd.focus();
			return false;
		}
		
		if (document.frmMacPwdChange.txtNewPwd.value =="") 
		{
			document.frmMacPwdChange.txtNewPwd.focus();
			document.frmMacPwdChange.txtNewPwd.select();
			alert("Please enter the new Password");  
			return false;
		}
		if (document.frmMacPwdChange.txtConfirmPwd.value =="") 
		{
			document.frmMacPwdChange.txtConfirmPwd.focus();
			document.frmMacPwdChange.txtConfirmPwd.select();
			alert("Please enter the confirm Password");  
			return false;
		}
		
		var lNPwd	= document.frmMacPwdChange.txtNewPwd.value;
		var lCPwd	= document.frmMacPwdChange.txtConfirmPwd.value;
		if (lNPwd != lCPwd)
		{
			document.frmMacPwdChange.txtConfirmPwd.focus();
			document.frmMacPwdChange.txtConfirmPwd.select();
			alert("Please enter correct cofirm password");
			return false;
		}
		
		if ((lNPwd.length < 5 ) ||(lNPwd.length >= 11))
		{
			alert("\nThe new Password is not in the range of 5 to 10 characters.\nPlease re-enter your new Password.")
			document.frmMacPwdChange.txtNewPwd.select();
			document.frmMacPwdChange.txtNewPwd.focus();
			return false;
		}
		
		return true;
	}
	
	function defaultfocus()
	{
		document.frmMacPwdChange.optUserType.focus();  
	}
	
	function DisplayIds()
	{
		var lSelIndex = document.frmMacPwdChange.optUserType.selectedIndex; 
		var lSelValue = document.frmMacPwdChange.optUserType.options[lSelIndex].value;
		document.frmMacPwdChange.hidUserType.value = lSelValue;
		document.frmMacPwdChange.submit();
	}
	
	</script>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor onload="defaultfocus();">
	<!---#include file="../Includes/header.inc"--->
	<br><!--#include file="../Includes/MACLinks.inc" ---->
	<form name="frmMacPwdChange" method="post"  >
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1"> Password Change </font></td>
		</tr>
	        
		<tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User Type</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optUserType" style="HEIGHT: 22px; WIDTH: 199px" onchange="DisplayIds();">
					<%if lUserType ="" then %>
						<option selected>------   User Type  ------</option>
					<%end if%>
					<option value="T" <%if lUserType ="T" then Response.Write "selected"%> >TCM</option>
					<option value="I"  <%if lUserType ="I" then Response.Write "selected"%>>ICM</option>
					<option value="J"  <%if lUserType ="J" then Response.Write "selected"%>>Sub-Broker</option>
					<option value="C"  <%if lUserType ="C" then Response.Write "selected"%>>Client</option>
					<option value="M"  <%if lUserType ="M" then Response.Write "selected"%>>MAC</option>
					<option value="R"  <%if lUserType ="R" then Response.Write "selected"%>>Surveillance Manager</option>
					<option value="U"  <%if lUserType ="U" then Response.Write "selected"%>>Surveillance User</option>
				</select> 
	        </td>
		</tr>
		<input type=hidden name="hidUserType" >
		<tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<%if trim(Request.Form("hidUserType")) <> "" then
					if not (lRsUserId.BOF and lRsUserId.EOF) then 
				'	Response.Write "Inside while loop"
					'Response.Write lRsUserId.GetString & "<Br>"
					%>
						<select name="optUserId" style="HEIGHT: 22px; WIDTH: 199px">
							<option selected>------   User ID   ------</option>
							<%while not lRsUserId.EOF %>
								<option value="<%=lRsUserId.Fields(0)%>"><%=lRsUserId.Fields(0)%></option>
								<%lRsUserId.MoveNext 
							wend
						end if %>	</select> 
					<%else %>
						
							<font align="left" class="blacktext">Please select User Type to display User IDs</font>
					<%end if%>
				        </td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Old Password</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight"> 
				<input type="password" size="26.7"  maxlength="10" name="txtOldPwd">
	        </td>
		</tr>
	    <tr class="tdbglight"> 
			<td  height="27" align=left width="20%"> 
				<font align="left"><font class=blacktext>New Password</font></font>
	        </td>
	        <td align="left" height="27"  width="30%" class="tdbglight"> 
				<input type="password" size="26.7" maxlength="10" name="txtNewPwd">
	        </td>
		</tr>
		<tr class="tdbglight"> 
			<td  height="27" align=left width="20%"> 
				<font align="left"><font class=blacktext>Confirm Password</font></font>
	        </td>
	        <td align="left" height="27"  width="30%" class="tdbglight"> 
				<input type="password" size="26.7" maxlength="10" name="txtConfirmPwd">
	        </td>
		</tr>
		<input type=hidden name="hidActionValue">	
		<tr class="tdbglight"> 
			<td colspan=2 valign="center" align=middle height="27">
				<input type="button" name=btnPChange value="Change" onclick="return CheckAction(1)">
				<input type=reset name="btnCancel" value="Clear">
			</td>
		</tr>
	</table>
	</form>
	<!---#include file="../includes/footer.inc"--->
	<body>
	</html>
	
