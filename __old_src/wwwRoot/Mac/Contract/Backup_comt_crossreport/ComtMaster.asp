<%@ Language=VBScript %>
<%
    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Broker Admin										  *
	'* File name	:	ChrageMaster.asp               					      *
	'* Purpose		:	This page will display Commodity Group and Contract   *
	'*                  code                                                  * 
	'* Prepared by	:	Obula Reddy                 						  *	
	'* Date			:	30.11.2001											  *
	'* Copyright	:	(c) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page will display all Commodity Groups in the exchange. Based on  *
	'* group selection all Contracts  will be displayed in that group         *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.- Date		- By				   - Explanation	   	  *
	'*	1		            - Obula Reddy                 First Baseline      *
	'**************************************************************************
	
	
dim lObjComgGrp 
dim lObjRsComgGrp
dim lObjRsContCode
dim lSplitRes
set lObjComgGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lobjRsComgGrp=server.CreateObject("adodb.recordset")
set lObjRsContCode=server.CreateObject("adodb.recordset")
set lObjRsComgGrp=lObjComgGrp.GetCommodityGroup()
if Request.Form("txtComgCode")<>"" then
   lSplitRes=split(Request.Form("txtComgCode"),"|")
   set lObjRsContCode=lObjComgGrp.GetComgTypes (cstr(lSplitRes(0))) 
end if

%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmComtSelection.OptComgCode.selectedIndex;
		var j=document.frmComtSelection.OptComgCode.options[i].value;
		document.frmComtSelection.txtComgCode.value =j;  
    	document.frmComtSelection.submit();
	}
	
	function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
	if (document.frmComtSelection.OptComgCode.value==""){
			alert("Select Commodity Group and Type");
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
			document.frmComtSelection.action="ComtMasterUpdate.asp";
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
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
    </head>

	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
	<center>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->
	
	<%	'lSplitOptComgCode
	'Response.Write "fdgdd" & trim(Request.Form("txtComgCode"))
	'lSplitOptComgCode=split(trim(Request.Form("txtComgCode")),"|")
	'Response.Write lSplitOptComgCode(0)
	'Response.Write "fdgdd" & trim(Request.Form("txtComgCode")) & "---" & lSplitRes(0)
	If not  lObjRsComgGrp.EOF then%>
	<form name="frmComtSelection"  method="post">
	<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Commodity Type Master</td>
		
	</tr>
		
	 <TR><TD class=tdbglight width=20% height="20"><font class=blacktext>Commodity Group Code</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptComgCode" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option selected value="">Select Comg Grp</option>
	<%
	if not lobjRsComgGrp.EOF and trim(Request.Form("txtComgCode"))="" then
		do while not lObjRsComgGrp.EOF %>
			<option <%'if trim(lObjRsComgGrp(0))=trim(Request.Form("txtComgCode")) then Response.Write "selected"%> value="<%=lObjRsComgGrp(0)%>|<%=lObjRsComgGrp(1)%>" > <%=lObjRsComgGrp(0)%>--<%=lObjRsComgGrp(1)%></option>
			<%lObjRsComgGrp.MoveNext 
		loop
	else
		do while not lObjRsComgGrp.EOF %>
			<option <%if trim(lObjRsComgGrp(0))=cstr(lSplitRes(0)) then Response.Write "selected"%> value="<%=lObjRsComgGrp(0)%>|<%=lObjRsComgGrp(1)%>" > <%=lObjRsComgGrp(0)%>--<%=lObjRsComgGrp(1)%></option>
			<%lObjRsComgGrp.MoveNext 
		loop
	end if
			
		%>
		</select>
		
		<input type=hidden name="txtComgCode">
		<tr><TD class=tdbglight width=30% height="25"><font class=blacktext>Commodity Type</font></TD>
		<%if Request.Form("txtComgCode")<>"" then%>
			<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5">
			<select size="1" name="optContCode" style="HEIGHT: 22px; WIDTH: 150px">
		<%
		if not lObjRsContCode.EOF then
			do while not lObjRsContCode.EOF %>
				
				<option value=<%=lObjRsContCode(1)%>><%=lObjRsContcode(0)%>--<%=lObjRsContcode(1)%></option>
				
				<%lObjRsContCode.MoveNext 
			loop
		end if
		%>
		</select> </td>
		
		<%else%>
			<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5"><font class=blacktext2>Select Commodity Group to Display Commodity Types</font></td>
		<%end if
		%>
	</tr>
	
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Short Description</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtShortDesc value="">
     </tr>
     
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Quantity</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtQty value="">
     </tr>
     
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>MAOP</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtMaop value="">
     </tr>
   
	<tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAddChrg"   value="Add    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>

	</tr>

	</table>
	<%else%>
	 <center><p>  
       <table width="70%" align=center border=0>
				<tr class="tdbgdark"> 
					<td colspan=2 class="whiteboldtext1">Select Commodity Groups</td>
				</tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">No More Commodity Groups Available for Selection......Click
					<A href="ComtMaster.asp">here</A> to view menu 
					</td>
				</tr>		
				<tr><td>&nbsp;</td></tr>
		</table>
   </Center>

<%end if
set lObjComgGrp=nothing
set lObjRsComgGrp=nothing
set lObjRsContCode=nothing
 
%>
    <br><br>
    <!---#include file="../Includes/footer.inc"---> 
   	</FORM>
	</body>
</Html>
	

