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
	
	
dim lObjMacWeb 
dim lObjRsUsers
set lObjMacWeb=server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsUsers=server.CreateObject("adodb.recordset")
set lObjRsUsers=lObjMacWeb.GetUsers()
%>
	<script language="Javascript">
	/*'function ChkSubmit()
	{
		var i=document.frmRetn.OptUserId.selectedIndex;
		var j=document.frmRetn.OptUserId.options[i].value;
		//document.frmRetn.OptUser.value=j;
		document.frmRetn.txtUserId.value =j;  
    	document.frmRetn.submit();
	}*/
	
	
	function btnClick(fValue)
	{
		var i=fValue;
		if (i==1) {
			document.frmRetn.hidActionvalue.value =1;
			if (document.frmRetn.OptUserId.value==""){
				alert("Select UserId and User Name");
				return false;}
			else{
				document.frmRetn.action="RetnMasterUpdate.asp";
				document.frmRetn.method="post";
				document.frmRetn.submit(); }}
		else if(i==2) {
			if (document.frmRetn.OptUserId.value==""){
				alert("Select UserId and User Name");
				return false;}
			else{
				document.frmRetn.action="RetnMasterView.asp";
				document.frmRetn.method="post";
				document.frmRetn.submit(); }}
		else if(i==3) {
			document.frmRetn.hidActionvalue.value =3;
			if (document.frmRetn.OptUserId.value==""){
				alert("Select UserId and User Name");
				return false;}
			else{
				document.frmRetn.action="RetnMasterUpdate.asp";
				document.frmRetn.method="post";
				document.frmRetn.submit(); }}	
		else if(i==4) {
			document.frmRetn.hidActionvalue.value =4;
			if (document.frmRetn.OptUserId.value==""){
				alert("Select UserId and User Name");
				return false;}
			else{
				document.frmRetn.action="RetnMasterUpdate.asp";
				document.frmRetn.method="post";
				document.frmRetn.submit(); }}			
		else if(i==5) {
			document.frmRetn.action="RetnMaster.asp";
			document.frmRetn.submit(); }
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
	<%'!---#include file="../includes/header.inc"--->%>
	<br>
	<%'!--- #include file="../includes/MAClinks.inc" --->%>
	
	<%	If not  lObjRsUsers.EOF then%>
	<form name="frmRetn"  method="post">
	<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Retension Master</td>
		
	</tr>
		
	 <TR><TD class=tdbglight width=20% height="20"><font class=blacktext>User ID & Name</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptUserId" style="HEIGHT: 29px; WIDTH: 279px">
		<option selected value="">Select User Id and Name </option>
	<%do while not lObjRsUsers.EOF %>
			<option <%if trim(lObjRsUsers(0))=trim(Request.Form("txtComgCode")) then Response.Write "selected"%> value=<%=lObjRsUsers(0)%>><%=lObjRsUsers(0)%>--<%=ucase(left(lObjRsUsers(1),1))%><%=lcase(mid(lObjRsUsers(1),2))%></option>
			<%lObjRsUsers.MoveNext 
	  loop
	%>
	</select>
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Retntion Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtRetAmt>
     </tr>
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Other Charges</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtRetOChrg>
     </tr>
	<tr>
	<input type=hidden name="hidActionvalue">
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAddChrg"   value="Add    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtViewChrg"  value="View   "  onclick ="return btnClick(2);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtUpdChrg"   value="Update "  onclick ="return btnClick(3);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtDeletehrg" value="Delete "  onclick ="return btnClick(4);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(5);">
	</td>

	</tr>
	</table>
	<%else%>
	 <center><p>  
       <table width="70%" align=center border=0>
				<tr class="tdbgdark"> 
					<td colspan=2 class="whiteboldtext1">Select User ID & Name</td>
				</tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">No More Commodity Groups Available for Selection......Click
					<A href="RetnMaster.asp">here</A> to view menu 
					</td>
				</tr>		
				<tr><td>&nbsp;</td></tr>
		</table>
   </Center>

	 <%end if%>
    <br><br>
    <%'!---#include file="../Includes/footer.inc"--->%> 
   	</FORM>
	</body>
</Html>
	

