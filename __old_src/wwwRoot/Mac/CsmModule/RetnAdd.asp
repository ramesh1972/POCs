<%@ Language=VBScript %>
<%
    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Mac Module											  *
	'* File name	:	RetnAdd.asp                  					      *
	'* Purpose		:	This page will display Commodity Group and Description*
	'*                                                                        * 
	'* Prepared by	:	Obula Reddy                 						  *	
	'* Date			:	10.12.2001											  *
	'* Copyright	:	(c) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page will display all Commodity Groups in the exchange. Based on  *
	'* group selection it  will be display description                        *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.- Date		- By				   - Explanation	   	  *
	'*	1		            - Obula Reddy                 First Baseline      *
	'**************************************************************************
	
dim lObjRetnGrp 
dim lObjRsRetnGrp
set lObjRetnGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lobjRsRetnGrp=server.CreateObject("adodb.recordset")
set lObjRsRetnGrp=lObjRetnGrp.GetUsers()

%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmRetnSelection.OptUserId.selectedIndex;
		var j=document.frmRetnSelection.OptUserId.options[i].value;
		document.frmRetnSelection.txtUserId.value =j;  
    	document.frmRetnSelection.submit();
	}
	
	function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
	   
	   if (document.frmRetnSelection.OptUserId.value==""){
			alert("Select User Id & Name");
			return false;}
	   if(document.frmRetnSelection.txtRetAmt.value<0){
			alert("Charge Fee Cannot be Negative")
			document.frmRetnSelection.txtRetAmt.focus()
			return false;}
		if (isNaN(document.frmRetnSelection.txtRetAmt.value)==true){
			alert("Retention Amount  Fee Should have only Numerals");
			return false;}
		if (isNaN(document.frmRetnSelection.txtRetPenAmt.value)==true){
			alert("Retention Penality Amount Should have only Numerals");
			return false;}
		if(document.frmRetnSelection.txtRetPenAmt.value<0){
			alert("Retention Penality  Amount Cannot be Negative")
			document.frmRetnSelection.txtRetPenAmt.focus()
			return false;}
		else{
			document.frmRetnSelection.action="RetnAddRes.asp";
			document.frmRetnSelection.method="post";
			document.frmRetnSelection.submit(); }}
		else if(i==2) {
			document.frmRetnSelection.action="RetnMenu.asp";
			document.frmRetnSelection.submit(); }
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
	
	<%If not  lObjRsRetnGrp.EOF then%>
	<form name="frmRetnSelection"  method="post">
	<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Retention  Master</td>
		
	</tr>
		
	 <TR><TD class=tdbglight width=20% height="20"><font class=blacktext>User ID & Name</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptUserId" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option selected value="">Select User Id & Name</option>
	<%
		if not lobjRsRetnGrp.EOF then
			do while not lObjRsRetnGrp.EOF %>
				<option <%if trim(lObjRsRetnGrp(0))=trim(Request.Form("txtUserId")) then Response.Write "selected"%> value="<%=lObjRsRetnGrp(0)%>" ><%=lObjRsRetnGrp(0)%></option>
				<%lObjRsRetnGrp.MoveNext 
			loop
		end if
			
		%>
		</select>
		
		<input type=hidden name="txtUserId">
	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Retention Amount </font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text value=0 name=txtRetAmt>
     </tr>
         
	
	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Retention Penality Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text value=0 name=txtRetPenAmt>
     </tr>
         
     
	<tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAddRetn"   value="Add    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>

	</tr>
	</table>
	<%else%>
	 <center><p>  
       <table width="70%" align=center border=0>
				<tr class="tdbgdark"> 
					<td colspan=2 class="whiteboldtext1">Select User Id & Name</td>
				</tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">No More Users Available for Selection......Click
					<A href="RetnMenu.asp">here</A> to view menu 
					</td>
				</tr>		
				<tr><td>&nbsp;</td></tr>
		</table>
   </Center>

<%end if

set  lObjRetnGrp=nothing 
set lObjRsRetnGrp=nothing
 
%>
    <br><br>
    <!---#include file="../Includes/footer.inc"---> 
   	</FORM>
	</body>
</Html>
	

