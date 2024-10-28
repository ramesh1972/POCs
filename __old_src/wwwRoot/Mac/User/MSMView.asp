
<%@ Language=VBScript %>
<%  option explicit
	dim lEntyType
	dim lObjMSMView
	dim lRsContracts
	dim lActionMode
	
	lEntyType = trim(Request.Form("hidEntyType"))
	if trim(Request.Form("lMode")) <> "" then
		lActionMode = trim(Request.Form("lMode"))
	else
		lActionMode = trim(Request.Form("hidActionMode"))
	end if
	
	Response.Write "Entity Type = " & lEntyType
	Response.Write "Action Mode = "  & lActionMode
	
	
	if lEntyType <> "" then
		if ucase(lEntyType) ="I" then
			set lObjMSMView  = server.CreateObject("MacWebCon.clsMacWebCon")
			set lRsContracts = server.CreateObject("adodb.recordset")
			set lRsContracts = lObjMSMView.GetContractCodes(" ") 
		end if
	end if

	%>
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<script language="javascript">
	function EntityCodeDis(){
		var lSelVal = document.frmMSM.optEntityType.options[document.frmMSM.optEntityType.selectedIndex].value;
		document.frmMSM.hidEntyType.value = lSelVal;
		document.frmMSM.method ="post";
		document.frmMSM.action ="MSMView.asp"; 
		document.frmMSM.submit();}
		
	function DisplayChk(lActValue)
	{
	
		if (document.frmMSM.optEntityType.value ==""){
			document.frmMSM.optEntityType.focus();
			 alert("Please select the Entity Type");
			return false;}
		if (document.frmMSM.optEntityCode.value == ""){
			document.frmMSM.optEntityCode.focus();
			alert("Please select the Entity Code");
			return false;}
		if (lActValue == 1){
			document.frmMSM.action ="MSMViewRes.asp";
			document.frmMSM.method='post';	
			document.frmMSM.submit();
			}
		if (lActValue == 2 ){ 
			document.frmMSM.action ="MSMUpd.asp";
			document.frmMSM.method='post';	
			document.frmMSM.submit();}
		
		}
	</script>
	</head>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	<form name="frmMSM" method="post" >
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1">Market Session Management</font></td>
		</tr>
		<tr class="tdbglight"> 
			<td valign=center width="50%"  height="27"><font class="blacktext">Entity Type</font></td>
			<td valign=center width="50%"  height="27">
			<select name="optEntityType" onchange="EntityCodeDis()">
				<option >-- Entity Type -- </option>
				<option value="M" <%if lEntyType ="M" then Response.Write "selected" %>>Market</option>
				<option value="B" <%if lEntyType ="B" then Response.Write "selected" %>>Basket</option>
				<option value="I" <%if lEntyType ="I" then Response.Write "selected" %>>Contract</option>
				<option value="E" <%if lEntyType ="E" then Response.Write "selected" %>>Event</option>
				<option value="A" <%if lEntyType ="A" then Response.Write "selected" %>>All Timer</option>
			</select>
			</td>
		</tr>
		<input type=hidden name="hidEntyType">
		<input type=hidden name="hidActionMode" value="<%=lActionMode%>">
		<tr class="tdbglight"> 
			<td valign=center width="50%"  height="27"><font class="blacktext">Entity Code</font></td>
			<td valign=center width="50%"  height="27">
			<%if lEntyType <> "" then %>
				<select name="optEntityCode">
				<%select case(ucase(lEntyType))%>
		
					<%case "M"	: %>
								<option  size=5 value="BOOE" >BOOE</option>
								<option  size=5 value="KCEX" >KCEX</option>
	
					<%case "B"	: %>
								<option  size=5 value="BOOE" >BOOE</option>
								<option  size=5 value="KCEX" >KCEX</option>
							
					<%case "I"	:
								 if not (lRsContracts.BOF and lRsContracts.EOF) then
									while not lRsContracts.EOF 
										Response.Write "<option  size=5 value=" & lRsContracts(1)& ">" & lRsContracts(1) & "</option>"
										lRsContracts.MoveNext 
									wend
								else
									Response.Write "<option value=''>No Contracts</option>"
								end if
							
					case "E"	: %>
								<option  size=5 value="BDAY" >BDAY</option>
								<option  size=5 value="OPEN" >OPEN</option>
								<option  size=5 value="ETRD" >ETRD</option>
								<option  size=5 value="HALT" >HALT</option>
								<option  size=5 value="CLSE" >CLSE</option>
								<option  size=5 value="EDAY" >EDAY</option>
							
					<%case "A"	: %>
								<option  size=5 value="ALL" >ALL</option>

				<%end select%>
				</select>
			<%else
				Response.Write"<font class='blacktext1'>Please select Entity Type to display Entity Code </font>"
			end if %>
			</td>
		</tr>
		<tr class="tdbglight"> 
			<td colspan="2" align=center width="50%"  height="27">
				<%if ucase(lActionMode) = "U" then %>
					<input type=button name="btnUpdate" value="View" onclick="return DisplayChk(2);">
				<%else %>
					<input type=button name="btnBrowse" value="Browse" onclick="return DisplayChk(1);">
				<%end if%>
			</td>
		</tr>
	</table>
	</form>
	<P>&nbsp;</P>
	</BODY>
	</HTML>
