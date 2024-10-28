<%@ Language=VBScript %>
<% option explicit
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	UsrCompDetView.asp									  *
	'* Purpose		:	This is used for		.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for		.								  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   15/12/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		

	dim lMode
	dim lObjUserIds
	dim lRsUserIds
	dim lUserflg
	
	lMode	= trim(Request.Form("lMode"))
	set lObjUserIds = server.CreateObject("MacWebCon.clsMacWebCon")
	set lRsUserIds  = server.CreateObject("adodb.recordset")
	set lRsUserIds  = lObjUserIds.GetUsers() 
	lUserflg = false
	%>	
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Bombay Commodity Exchange Limited</title>
	<script language="javascript">
	function ChkUser()
	{
	//	alert("hi");
		if (document.frmUserCompanyDetails.optUserId.checked == false )
		{	
	//		alert("hi");
			document.frmUserCompanyDetails.optUserId.select();
			alert("Please select the User ID");
			return false;
		}
		return true;
	}
	</script>
	</head>
	<body border="1" cellspacing="1" cellpadding"1" topmargin="1" bottommargin="1" >
	<!---#include file="../includes/header.inc"--->
	<br><!--#include file="../Includes/MACLinks.inc" ----><br>
	<form name="frmUserCompanyDetails" action="UserCompDetRes.asp" method=post >
	<table border="1" cellspacing="1" cellpadding="1" width="50%" align="center">
		<tr class=tdbglight width="100%">
			<td align="left" height="25" colspan="2"> <font class=blackboldtext>User Company Details</font></td>
		</tr>
		<tr class=tdbglight width="100%">
			<td align="left" height="20" width="25%"> <font class=blacktext>User ID </font></td>
			<td size="15" maxlength="10" width="25%">
				<select name="optUserId" style="height: 22px; width: 199px" >
				<%if not (lRsUserIds.BOF and lRsUserIds.EOF) then %>
					<option selected>----Select User Id----</option>
					<%while not lRsUserIds.EOF %>
						<option value="<%=lRsUserIds(0)%>"><%=lRsUserIds(0)%></option>
						<%lRsUserIds.MoveNext 
					wend
					Response.Write "</select>"
					lUserflg = true
				else
					Response.Write "<font class='blacktext'>No User is available to View/ Update. </font>"
					lUserflg = false
				end if%>
			</td>
		</tr>
		<%if lUserflg= true then %>
			<tr class=tdbglight width="100%">
				<td size="15" maxlength="10" width="25%" colspan="2" align="center">
					<input type=submit name="sbtDisplay" value="Display" onclick="return ChkUser();">
				</td>
			</tr>
		<%end if%>
	</table>
	<input type=hidden name="hidActionValue" value="<%=lMode%>">
	</form>
	</body>
	</html>