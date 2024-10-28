<%@ Language=VBScript %>

<%
if request("m")<> "" then
	dim lEntity
	dim lMode
	lEntity = Request.Form("optEntityType")
	lMode = request("m")
	
	Response.Write	"MODE = " & request("m")
	Response.Write "Entity = " & lEntity
	%>
	
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	
	<form name="frmMktSessMgt" method="post" action="MSMView.asp" >
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1">Market Session Management</font></td>
		</tr>
		
		<tr class="tdbglight"> 
			<td valign=center width="50%"  height="27"><font class="blacktext">Entity Type</font></td>
			<td valign=center width="50%"  height="27">
	<select name="optEntityType" disabled>
		<option value="M" <%if lEntity="M"then Response.Write "selected"%>>Market</option>
		<option value="B" <%if lEntity="B"then Response.Write "selected"%>>Basket</option>
		<option value="C" <%if lEntity="C"then Response.Write "selected"%>>Contract</option>
		<option value="E" <%if lEntity="E"then Response.Write "selected"%>>Event</option>
		<option value="A" <%if lEntity="A"then Response.Write "selected"%>>All Timer</option>
	</select>
	</td>
	</tr>
		<tr class="tdbglight"> 
			<td valign=center width="50%"  height="27"><font class="blacktext">Entity Code</font></td>
			<td valign=center width="50%"  height="27">
	
	<%
	select case(lMode)
		case "m"	: %>
						<select name="dest">
							<option  size=5 value="BOOE" >BOOE</option>
							<option  size=5 value="KCEX" >KCEX</option>
						</select>
		<%case "b"	: %>
						<select name="dest">
							<option  size=5 value="BOOE" >BOOE</option>
							<option  size=5 value="KCEX" >KCEX</option>
						</select>
		<%case "c"	: %>
						<select name="dest">
							<option  size=5 value="RBDPAM0202" >RBDPAM0202</option>
							<option  size=5 value="CASOIL0202" >CASOIL0202</option>
						</select>
		<%case "e"	: %>
						<select name="dest">
							<option  size=5 value="BDAY" >BDAY</option>
							<option  size=5 value="OPEN" >OPEN</option>
						</select>
		<%case "a"	: %>
						<select name="dest">
							<option  size=5 value="ALL" >ALL</option>
						</select>
	<%end select%>
	</td>
	</tr>
	<tr class="tdbglight"> 
			<td  align=center width="50%"  height="27" colspan=2>
				<input type=submit value="Browse" name="btnBrowse">
				<input type=reset value="Cancel" name="btnBrowse">
	
	</table>

<%else%>



<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
<script language="javascript">
function EntityCodeCheck()
{
	if (document.frmMktSessMgt.optEntityType.value =="M"){
	document.frmMktSessMgt.action = 'test.asp?m=m';}
	if (document.frmMktSessMgt.optEntityType.value =="B"){
	document.frmMktSessMgt.action = 'test.asp?m=b';}
	if (document.frmMktSessMgt.optEntityType.value =="C"){
	document.frmMktSessMgt.action = 'test.asp?m=c';}
	if (document.frmMktSessMgt.optEntityType.value =="E"){
	document.frmMktSessMgt.action = 'test.asp?m=e';}
	if (document.frmMktSessMgt.optEntityType.value =="A"){
	document.frmMktSessMgt.action = 'test.asp?m=a';}
	document.frmMktSessMgt.method ="post";
	document.frmMktSessMgt.submit(); 
}
</script>
</HEAD>
<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	
	<form name="frmMktSessMgt" method="post" action="MSMView.asp" >
	<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
		<tr class="tdbgdark"> 
			<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1">Market Session Management</font></td>
		</tr>
		
		<tr class="tdbglight"> 
			<td valign=center width="50%"  height="27"><font class="blacktext">Entity Type</font></td>
			<td valign=center width="50%"  height="27">
	
	<select name="optEntityType" onchange="EntityCodeCheck()">
		<option value="M">Market</option>
		<option value="B">Basket</option>
		<option value="I">Contract</option>
		<option value="E">Event</option>
		<option value="A">All Timer</option>
	</select>
	</td>
	</tr>
		<tr class="tdbglight"> 
			<td valign=center width="50%"  height="27"><font class="blacktext">Entity Type</font></td>
			<td valign=center width="50%"  height="27">
	
	<select name="dest">
		<option   value="" >&nbsp;</option>
	</select>
	</td></tr>
	</table>
	<input type=hidden name="hidEntity">
</form>
<P>&nbsp;</P>

</BODY>
</HTML>
<%end if%>