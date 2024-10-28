<%@Language=VBScript %>

<% Option Explicit

    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Contract											  *
	'* File name	:	ComtUpdRes.asp			       					      *
	'* Purpose		:	This page displays result of commodity type update    *
	'*					with values given in the previous page.				  *
	'* Prepared by	:	Majo												  *		
	'* Date			:	3.1.2002			 								  *
	'* Copyright	:	(c) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page displays result of commodity type update                     *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.- Date		- By				   - Explanation	   	  *
	'*	1		                -Majo                    First Baseline       *
	'**************************************************************************

'	dim lUserType
'	lUserType=Request.Cookies("UserType")
	%>	
	<script language="Javascript">
	
	function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
	/*if (document.frmComtSelection.OptComgCode.value==""){
			alert("Select Commodity Group and Type");
			return false;}*/
		if(document.frmComtSelection.txtShortDesc.value==""){
			alert("Enter Quantity")
			document.frmComtSelection.txtShortDesc.focus()
			return false;}
		
		if(document.frmComtSelection.txtQty.value==""){
			alert("Enter Quantity")
			document.frmComtSelection.txtQty.focus()
			return false;}
		if(document.frmComtSelection.txtQty.value<0){
			alert("Type quantity Cannot be Negative")
			document.frmComtSelection.txtQty.focus()
			return false;}
		if (isNaN(document.frmComtSelection.txtQty.value)==true){
			alert("Type quantity Should have only Numerals");
			return false;}
		if (isNaN(document.frmComtSelection.txtMaop.value)==true){
			alert("MAOP Should have only Numerals");
			return false;}
		if(document.frmComtSelection.txtMaop.value==""){
			alert("Enter MAOP ")
			document.frmComtSelection.txtMaop.focus()
			return false;}
		if(document.frmComtSelection.txtMaop.value<0){
			alert("MAOP Cannot be Negative")
			document.frmComtSelection.txtMaop.focus()
			return false;}
		else{
			document.frmComtSelection.action="ComtUpdResult.asp";
			document.frmComtSelection.method="post";
			document.frmComtSelection.submit(); }}
		else if(i==2) {
			document.frmComtSelection.action="ComtMenu.asp";
			document.frmComtSelection.submit(); }
	}
	</script>

	<HTML>
	<HEAD>
		<style>
			a {text-decoration:none}
			a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
	</HEAD>
	<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name=frmComtSelection action="ComtUpdResult.asp" method=post>
	<!---#include file="../includes/header.inc"--->
	<br>
<!---#include file="../includes/MACLinks.inc"--->
	<br>
<%
dim lObjCharge
dim lResult	
dim lResponse
dim lResultValues
dim lComgCode
dim lContCode
dim lShortDesc
dim lQty
dim lMaop
lComgCode	= trim(Request.Form("OptComgCode"))
lContCode	= trim(Request.Form("OptContCode"))
set lObjCharge	=	server.CreateObject("Mac.comtMgr")

if lComgCode = "" then
lComgCode = 0
end if
if lContCode = "" then
lContCode = 0 
end if
lResult = lObjCharge.DoBrowse("V",lComgCode,lContCode,lContCode,lShortDesc,lMaop,lQty)
select case(lResult)
	case "1000":
		lResponse = "Invalid Type"
	case "1100":
		lResponse = "Invalid Group"
	case "1498":
		lResponse = "Type can not be deleted."
	case "1499":
		lResponse = "Invalid Exchange"
	case "1800":
		lResponse = "The System Date doesn't match"
	case "9598":
		lResponse = "The Connection to the Server cannot be established"
'	case else
'		lResponse = "Error in record browse"
End Select

'lResult = lObjCharge.DoUpdate ("I",lComgCode,"Short Desc",100,10,lContCode,lContCode)
'lResult = lObjCharge.DoUpdate ("I",30,"UPD",111,22,"SEED",30)
'Response.Write "<BR>After updation, result  = " & lResult
'Response.Write  "Result = " & lResult
'lResultValues = split(lResult,"|")
'Response.Write "<br>" & lResultValues(1)

if lResult = 0 then
%>	

<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Commodity Type View</td>
	</tr>

	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Comg Grp Code</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lComgCode%>
    </tr>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Commodity Type</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lContCode%>
    </tr>
    
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Short Description</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=txtShortDesc value=<%=lShortDesc%>>
    </tr>

    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Quantity</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=txtQty value=<%=lQty%>>
    </tr>

    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>MAOP</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><input type=text name=txtMaop value=<%=lMaop%>>
    </tr>

    <tr>
    <td  colspan=2 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtUpdChrg"   value="Update    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
	</tr>

</table>	
<input type=hidden name=txthidComgCode value=<%=trim(Request.Form("optComgCode"))%>>
<input type=hidden name=txthidContCode value=<%=trim(Request.Form("optContCode"))%>>
<input type=hidden name=txthidShortDesc value=<%=lShortDesc%>>
<input type=hidden name=txthidQty value=<%=lQty%>>
<input type=hidden name=txthidMaop value=<%=lMaop%>>

<%else%>
<center>
		<table width="80%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Commodity Type View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Type Details available for the selected cirteria. Click <a href="ComtUpd.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</form>
	</body>
	</HTML>


















