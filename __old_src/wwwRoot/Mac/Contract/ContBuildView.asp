<%@ Language=VBScript %>
<%
    '**************************************************************************
	'* Application	:	MAC								    				  *
	'* Module		:   MAC web     										  *
	'* File name	:	ContBuidView.asp               					      *
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
	
	
dim lObjContCode 
set lObjContCode=server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsContCode=server.CreateObject("adodb.recordset")
set lObjRsContCode=lObjContCode.GetContractCodes()

%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmContBuildSelection.OptContCode.selectedIndex;
		var j=document.frmContBuildSelection.OptContCode.options[i].value;
		document.frmContBuildSelection.txtContCode.value =j;  
    	document.frmContBuildSelection.submit();
	}
	
	
	function btnClick(fValue)
	{
		var i=fValue;
			
		
		if (i==1) {
			document.frmContBuildSelection.hidActionvalue.value =1;
			if (document.frmContBuildSelection.OptContCode.value==""){
				alert("Select Contract code ");
				return false;}
			else{
				document.frmContBuildSelection.action="ContBuildViewRes.asp";
				document.frmContBuildSelection.method="post";
				document.frmContBuildSelection.submit(); }}
		else if(i==2) {
			document.frmContBuildSelection.action="ContBuildMenu.asp";
			document.frmContBuildSelection.submit(); }
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
	
	<%	If not  lObjRsContCode.EOF then%>
	<form name="frmContBuildSelection"  method="post">
	<table width="70%" border="2"  cellpadding=2 cellspacing=1 align=center height="146">
	<%if Request.QueryString("Mode")="V" then%>
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Select Contract Code for Contract view Details</td>
	</tr>
	<%elseif Request.QueryString("Mode")="D" then%>
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Select Contract Code for Contract view Details</td>
	</tr>
	<%end if%>
   <input type=hidden name=txthidMode value=<%=Request.QueryString("Mode")%>>		
	 <TR><TD class=tdbglight width=25% height="20"><font class=blacktext>Select Contract Code </font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25" > 
		<select size="1" name="OptContCode" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option selected value="">Select Contract Code</option>
	<%
		if not lObjRsContCode.EOF then
			do while not lObjRsContCode.EOF %>
				<option <%if trim(lObjRsContCode(1))=trim(Request.Form("txtContCode")) then Response.Write "selected"%> value="<%=lObjRsContCode(1)%>" > <%=lObjRsContCode(1)%></option>
				<%lObjRsContCode.MoveNext 
			loop
		end if
			
		%>
		</select>
		
		<input type=hidden name="txtContCode">
		
	<input type=hidden name="hidActionvalue">
	<tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAddRetn"   value="View    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>

	</tr>
	</table>
	<%else%>
	 <center><p>  
       <table width="70%" align=center border=0>
				<tr class="tdbgdark"> 
					<td colspan=2 class="whiteboldtext1">Select User Id </td>
				</tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">No More Users Available for Selection......Click
					<A href="RetnMenu.asp">here</A> to view menu 
					</td>
				</tr>		
				<tr><td>&nbsp;</td></tr>
		</table>
   </Center>

	 <%end if%>
    <br><br>
    <!---#include file="../Includes/footer.inc"---> 
   	</FORM>
	</body>
</Html>
	

