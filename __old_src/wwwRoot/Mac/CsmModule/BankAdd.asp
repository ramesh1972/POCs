<%@ Language=VBScript %>
<%
    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Mac Module       									  *
	'* File name	:	BankAdd.asp                 					      *
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
	
dim lObjBnkGrp
dim lRsBankCode
dim  lRsBranchCode
dim lSplitRes
set lObjBnkGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lRsBankCode=server.CreateObject("adodb.recordset")
set  lRsBranchCode=server.CreateObject("adodb.recordset")
set lRsBankCode=lObjBnkGrp.GetBankCodes()
'if Request.Form("txtBnkCode")<>"" then
 '  set  lRsBranchCode=lObjBnkGrp.GetBranchCodes(Request.Form("txtBnkCode"))
'end if

%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var lSelIndex=document.frmBankMaster.optBnkCode.selectedIndex;
		var lSelValue=document.frmBankMaster.optBnkCode.options[lSelIndex].value;
		document.frmBankMaster.hidBankCode.value=lSelValue;
		document.frmBankMaster.submit();
	}
	
	/*function GetBranchCode()
	{	
		var lSelIndex=document.frmBankMaster.optBrnCode.selectedIndex;
		var lSelValue=document.frmBankMaster.optBrnCode.options[lSelIndex].value;
		document.frmBankMaster.txtBrnCode.value=lSelValue;
	}*/

	
	function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
	
	
	    if(document.frmBankMaster.txtBrnCode.value==""){
			alert("Enter Branch code ")
			document.frmBankMaster.txtBrnCode.focus()
			return false;}
		
		if(document.frmBankMaster.txtBrnName.value==""){
			alert("Enter Branch Name ")
			document.frmBankMaster.txtBrnName.focus()
			return false;}
		if(document.frmBankMaster.txtBrnAdd1.value==""){
			alert("Enter Branch Address1")
			document.frmBankMaster.txtBrnAdd1.focus()
			return false;}
			
		if(document.frmBankMaster.txtBrnAdd2.value==""){
			alert("Enter Branch Address2")
			document.frmBankMaster.txtBrnAdd2.focus()
			return false;}
		
		if(document.frmBankMaster.txtBrnAdd3.value==""){
			alert("Enter Branch Address3")
			document.frmBankMaster.txtBrnAdd3.focus()
			return false;}
			
		else{
			document.frmBankMaster.action="BankAddRes.asp";
			document.frmBankMaster.method="post";
			document.frmBankMaster.submit(); }}
		else if(i==2) {
			document.frmBankMaster.action="BankMenu.asp";
			document.frmBankMaster.submit(); }
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

	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class="bodycolor">
	<form name="frmBankMaster"  method="post">
	<center>
	<br>
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	<%
	if not(lRsBankCode.BOF and lRsBankCode.EOF) then
	%>

	<table width="75%" border="1"  cellpadding=2 cellspacing=2 align=center height="146">
	<tr class="tdbgdark">
	   <td valign=center colspan=3 class="whiteboldtext1">Bank Master Details</td>
</tr>	
	
	 <TR><TD class=tdbglight width=30% height="20"><font class=blacktext>Bank Code</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="optBnkCode" style="HEIGHT: 22px; WIDTH: 180px" onchange="ChkSubmit();">
		<option selected value="No">- Select Bank Code </option>
		
		<%
		if not(lRsBankCode.BOF and lRsBankCode.EOF) then
			lRsBankCode.MoveFirst 
			while not lRsBankCode.EOF
				%>
				<%if Request.Form("hidBankCode")=lrsBankCode(0) then%>
				<option value="<%=lRsBankCode(0)%>" selected><%=lRsBankCode(0)%></option>
				<%else%>
					<option value="<%=lRsBankCode(0)%>"><%=lRsBankCode(0)%></option>
				<%end if%>
				<%lRsBankCode.MoveNext 
			wend%>
		<%end if%>
		
		
		</select> 
		</td>
		<TD class=tdbglight width=30% height="25">
		<input type=text name="txtBnkCode" value="<%=Request.Form("hidBankCode")%>" style="HEIGHT: 22px; WIDTH: 180px"></td>
		</tr>
		<input name="hidBankCode" type=hidden>
	
		<!-- TO BE PASTRD FROM NOTEPAD
		-->
	
	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Branch Code</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtBrnCode value="">
     </tr>
     
	
	 <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Branch Name </font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtBrnName value="">
     </tr>
     
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Branch Address1 </font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtBrnAdd1 value="">
     </tr>
     
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Branch Address2 </font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtBrnAdd2 value="">
     </tr>
     
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Branch Address3 </font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtBrnAdd3 value="">
     </tr>
    
     <tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAddChrg"   value="Add    "  onclick ="btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
	</tr>
	     
     </table>
	<%else%>
	 <center><p>  
       <table width="70%" align=center border=0>
				<tr class="tdbgdark"> 
					<td colspan=2 class="whiteboldtext1">Select Bank Code</td>
				</tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">No More Bank Code  Available for Selection......Click
					<A href="BankMenu.asp">here</A> to view menu 
					</td>
				</tr>		
				<tr><td>&nbsp;</td></tr>
		</table>
   </Center>

<%end if
set lRsBankCode=nothing
'set  lRsBranchCode=nothing
%>
    <br><br>
    <!---#include file="../Includes/footer.inc"---> 
   	</FORM>
	</body>
</Html>

