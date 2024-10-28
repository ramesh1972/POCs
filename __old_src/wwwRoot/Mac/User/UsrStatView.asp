	<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	UsrStatView.asp										  *
	'* Purpose		:	This is used for .		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for .								  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   27/11/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		
	'option explicit 
	dim lUserType
	dim lObjUsrStatus
	dim lRsUserIds
	dim lCoyId
	dim lUserId
	
	lUserType = trim(Request.Form("hidUserType"))
	lUserId	  = trim(Request.Form ("hidUserId"))
	if lUserType <>"" then
		set lObjUsrStatus	= server.CreateObject("MacWebCon.clsMacWebCon")
		set lRsUserIds		= server.CreateObject("adodb.recordset")
		select case(lUserType)
			case "T"	:	set lRsUserIds	= lObjUsrStatus.GetTcmds()
			case "I"	:	set lRsUserIds	= lObjUsrStatus.GetIcmds()
			case "C"	:	set lRsUserIds	= lObjUsrStatus.GetClientIds()
			case "M"	:	set lRsUserIds	= lObjUsrStatus.GetTcmds()
			case "J"	:	set lRsUserIds	= lObjUsrStatus.GetTcmds()
			case "R"	:	set lRsUserIds	= lObjUsrStatus.GetTcmds()
			case "U"	:	set lRsUserIds	= lObjUsrStatus.GetTcmds()
		end select
		if lUserId <> "" then
			'set lCoyId = server.CreateObject("adodb.recordset")
			lCoyId = lObjUsrStatus.GetCompanyCode(lUserId,lUserType) 
		end if
	end if
	
	%>
	
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<script language="Javascript">
	
	function CheckValues()
	{
		if ((document.frmUsrStatView.optUserType.value =="") || (document.frmUsrStatView.optUserId.value =="") || (document.frmUsrStatView.optStatus.value =="") || (document.frmUsrStatView.optCompanyId.value ==""))
		{
			document.frmUsrStatView.optUserType.focus();
			alert("Please select atleast one among these to display all details");  
			return false;
		}
		return true;
	}
	
	function DisUserIds(){
		var lSelInd = document.frmUsrStatView.optUserType.selectedIndex;
		var lSelVal = document.frmUsrStatView.optUserType.options[lSelInd].value;
		document.frmUsrStatView.hidUserType.value = lSelVal;
		document.frmUsrStatView.submit();}
	function DisCoyId()
	{
		var lSInd = document.frmUsrStatView.optUserType.selectedIndex;
		var lSVal = document.frmUsrStatView.optUserType.options[lSInd].value;
		document.frmUsrStatView.hidUserType.value = lSVal;
		var lSelInd = document.frmUsrStatView.optUserId.selectedIndex;
		var lSelVal = document.frmUsrStatView.optUserType.options[lSelInd].value;
		document.frmUsrStatView.hidUserId.value = lSelVal;
		document.frmUsrStatView.submit();
	}
	</script>
	
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	
	<form name="frmUsrStatView" method="post">
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1"> User Status Browse </font></td>
		</tr>
	    <tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User Type</font>
	        </td>
	        <td  align="left" height="16"  width="30%">
				<select name="optUserType" style="height: 22px; width: 199px" onchange="DisUserIds()">
					<option selected>------    User Type   ------</option>
					<option value="T" <%if lUserType="T" then Response.Write "selected" %>>TCM</option>
					<option value="I" <%if lUserType="I" then Response.Write "selected" %>>ICM</option>
					<option value="J" <%if lUserType="J" then Response.Write "selected" %>>Sub-Broker</option>
					<option value="C" <%if lUserType="C" then Response.Write "selected" %>>Client</option>
					<option value="M" <%if lUserType="M" then Response.Write "selected" %>>MAC</option>
					<option value="R" <%if lUserType="R" then Response.Write "selected" %>>Surveillance Manager</option>
					<option value="U" <%if lUserType="U" then Response.Write "selected" %>>Surveillance User</option>>
				</select> 
	        </td>
		</tr>
		<input type=hidden name="hidUserType">
		<tr class="tdbglight"> 
			<td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">User ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
					<%if lUserType <> "" then%>
						<select name="optUserId" style="HEIGHT: 22px; WIDTH: 199px" onchange="DisCoyId()">
							<option >------   User ID   ------</option>
						<%
						if not (lRsUserIds.BOF and lRsUserIds.EOF) then
							while not lRsUserIds.EOF %>
								<option value="<%=lRsUserIds(0)%>"  <%if trim(lRsUserIds(0))=trim(lUserId) then Response.Write "selected"%> ><%=lRsUserIds(0)%></option>							
								<%lRsUserIds.MoveNext
							wend
						else
							Response.Write "<font class='blacktext1'>No User ID is available</font>"
						end if
					else
						Response.Write "<font class=blacktext1>Please select User Type to display User IDs </font>"
					end if
						%>
				</select> 
	        </td>
		</tr>
		<input type=hidden name="hidUserId">
		
		 <tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Status</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<select name="optStatus" style="HEIGHT: 22px; WIDTH: 199px">
					<option selected>------ status  ------</option>
					<option value="TVE0081000">Active</option>
					<option value="MNA0003000">Halt</option>
					<option value="TVE0081000">Procedural Suspension</option>
					<option value="MNA0003000">Disciplinary Suspension</option>
		     </select> 
	        </td>
		</tr>
		
	    <tr class="tdbglight"> 
	        <td height="27" align=left  width="20%"> 
				<font align="left" class="blacktext">Company ID</font>
	        </td>
	        <td  align="left" height="16"  width="30%" class="tdbglight">
				<%if lUserId <> "" then
					if trim(lCoyId) <> "NoCompany" then %>
						<select name="optCompanyId" style="HEIGHT: 22px; WIDTH: 199px">
							<option value="<%=lCoyId%>"><%=lCoyId%></option>
						</select> 
					<%else
						Response.Write "<font class='blacktext1'>Company Id is not available</font>"
					end if
				else
					Response.Write "<font class='blacktext1'>Please select UserId to display CompanyID</font>"
				end if %>
				
	        </td>
		</tr>
		
		<input type=hidden name="hidActionValue">	
		<tr class="tdbglight"> 
			<td colspan=2 valign="center" align=middle height="27">
				<input type="submit" name="sbtView" value="View">
				<input type="reset" name="btnCancel" value="Cancel" >
			</td>
		</tr>
	</table>
	</form>
	<br><!---#include file="../includes/footer.inc"--->
	<body>
	</html>
