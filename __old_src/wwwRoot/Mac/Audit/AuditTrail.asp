<%@ Language=VBScript %>
<%
    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Mac Module       									  *
	'* File name	:	AuditTraialView.asp                					  *
	'* Purpose		:	This page will display Audit Trail                    *
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
	
	
dim lObjAdt  
dim lObjRsUserId 
dim lObjRsContCode
set lObjAdt =server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsUserId =server.CreateObject("adodb.recordset")
set lObjRsContCode=server.CreateObject("adodb.recordset")
set lObjRsUserId =lObjAdt.GetUsers()
set lObjRsContCode=lObjAdt.GetContractCodes() 

%>
	<script language="Javascript">
	function IntChange()
	{
	
		document.frmAuditTrialSelection.hiduserid.value = document.frmAuditTrialSelection.OptUserId.options[document.frmAuditTrialSelection.OptUserId.selectedIndex].value;
		document.frmAuditTrialSelection.hidTransType.value  = document.frmAuditTrialSelection.optTranType.options[document.frmAuditTrialSelection.optTranType.selectedIndex].value;
		document.frmAuditTrialSelection.hidcontcode.value = document.frmAuditTrialSelection.OptContCode.options[document.frmAuditTrialSelection.OptContCode.selectedIndex].value;
	}
	
	function FuncView()
	{
	document.frmAuditTrialSelection.action ="AuditTrailView.asp";
	document.frmAuditTrialSelection.method ="post";
	document.frmAuditTrialSelection.submit();
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
	
	<form name="frmAuditTrialSelection"  method="post">
	<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Audit Trail</td>
		
	</tr>
		
	 <TR><TD class=tdbglight width=20% height="20"><font class=blacktext>Select User id </font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
				
		<select size="1" name="OptUserId" style="HEIGHT: 22px; WIDTH: 150px" onchange="IntChange()" >
			<option selected value="">Select User ID</option>
				<%if not lObjRsUserId.EOF then
					do while not lObjRsUserId.EOF %>
					<option <%if trim(lObjRsUserId(0))=trim(Request.Form("hiduserid")) then Response.Write "selected"%> value=<%=lObjRsUserId(0)%>><%=lObjRsUserId(0)%>--<%=lObjRsUserId(1)%></option>
					<%lObjRsUserId.MoveNext 
					loop
				   end if
				%>
			
		</select>
		
	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Transaction Code</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <select size="1" name="optTranType" style="HEIGHT: 22px; WIDTH: 150px" onchange="IntChange()">
		<option value="ALL">ALL</option>
		<option value="IOADDQ">IOADDQ</option>
		<option value="IOMODQ">IOMODQ</option>
		<option value="IOCANQ">IOCANQ</option>
		<option value="ISAODQ">ISAODQ</option>
		<option value="ISMODQ">ISMODQ</option>
		<option value="ISCANQ">ISCANQ</option>
		<option value="ICRRPQ">ICRRPQ</option>
		</select>
      </tr>
      <tr><TD class=tdbglight width=30% height="25"><font class=blacktext>Contract Code</font></TD>
		<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5">
		<select size="1" name="OptContCode" style="HEIGHT: 22px; WIDTH: 150px" onchange="IntChange()">
		<%
		if not lObjRsContCode.EOF then
			do while not lObjRsContCode.EOF %>
				<option <%if trim(lObjRsContCode(0))=trim(Request.Form("hidcontcode")) then Response.Write "selected"%> value=<%=lObjRsContCode(0)%>><%=lObjRsContCode(0)%>--<%=lObjRsContCode(1)%></option>
				<%lObjRsContCode.MoveNext 
			loop
		end if
		
		%>
		
	</tr>
	<input type="hidden" name="hiduserid">
	<input type="hidden" name="hidcontcode">
	<input type="hidden" name="hidTransType">		
	
	 <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Date Stamp</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtDtSt>
     </tr>
     
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Time Stamp</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtTmSt>
     </tr>
     
     <tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Submit" name="sbtAddChrg"   value="View"  onclick ="FuncView();">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>

	</tr>
   

	</table>


<%
 set lObjAdt =nothing
 set lObjRsUserId =nothing
 set lObjRsContCode=nothing
 %>

    <br><br>
   
   	</FORM>
	</body>
</Html>
	

