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
set lObjComgGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lobjRsComgGrp=server.CreateObject("adodb.recordset")
set lObjRsContCode=server.CreateObject("adodb.recordset")
set lObjRsComgGrp=lObjComgGrp.GetCommodityGroup()
if Request.Form("txtComgCode")<>"" then
   'Response.Write "Group = " & Request.Form("txtComgCode")
   set lObjRsContCode=lObjComgGrp.GetContractCodes(Request.Form("txtComgCode")) 
   'Response.Write 	lObjRsContCode.Fields(0) 
end if

%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmChargeSelection.OptComgCode.selectedIndex;
		var j=document.frmChargeSelection.OptComgCode.options[i].value;
		//document.frmChargeSelection.OptComgcode.value=j;
		document.frmChargeSelection.txtComgCode.value =j;  
    	document.frmChargeSelection.submit();
	}
	
	
	function btnClick(fValue)
	{
		var i=fValue;
			
		
		if (i==1) {
			document.frmChargeSelection.hidActionvalue.value =1;
			if (document.frmChargeSelection.OptComgCode.value==""){
				alert("Select Commodity Group and Contract Code");
				return false;}
			else{
				document.frmChargeSelection.action="ChargeViewRes.asp";
				document.frmChargeSelection.method="post";
				document.frmChargeSelection.submit(); }}
		else if(i==2) {
			document.frmChargeSelection.action="ChargeMaster.asp";
			document.frmChargeSelection.submit(); }
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
	
	<%	If not  lObjRsComgGrp.EOF then%>
	<form name="frmChargeSelection"  method="post">
	<table width="55%" border="2"  cellpadding=2 cellspacing=1 align=center height="146">
	<%if Request.QueryString("Mode")="V" then%>
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Select the criteria to View Charges</td>
	</tr>
	<%elseif Request.QueryString("Mode")="D" then%>
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Select the criteria to Delete Charges</td>
	</tr>
	<%end if%>
   <input type=hidden name=txthidMode value=<%=Request.QueryString("Mode")%>>		
	 <TR><TD class=tdbglight width=25% height="20"><font class=blacktext>Commodity Group Code</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25" > 
		<select size="1" name="OptComgCode" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option selected value="">Select Comg Grp</option>
	<%
		if not lobjRsComgGrp.EOF then
			do while not lObjRsComgGrp.EOF %>
				<option <%if trim(lObjRsComgGrp(0))=trim(Request.Form("txtComgCode")) then Response.Write "selected"%> value="<%=lObjRsComgGrp(0)%>" > <%=lObjRsComgGrp(0)%>--<%=lObjRsComgGrp(1)%></option>
				<%lObjRsComgGrp.MoveNext 
			loop
		end if
			
		%>
		</select>
		
		<input type=hidden name="txtComgCode">
		<tr><TD class=tdbglight width=30% height="25"><font class=blacktext>Contract </font></TD>
		<%if Request.Form("txtComgCode")<>"" then%>
			<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5">
			<select size="1" name="OptContCode" style="HEIGHT: 22px; WIDTH: 150px">
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
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge Type</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <select size="1" name="optChrgType" style="HEIGHT: 22px; WIDTH: 150px">
		<option value="IC">Internet Charges</option>
		<option value="TC">Transaction Fee</option>
		<option value="CC">Clearing Charges</option>
		<option value="ST">Stamp Duty</option>
		<option value="OC">Other Charges</option>
        </select>
        </tr>
        
     
	<input type=hidden name="hidActionvalue">
	<tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAddChrg"   value="View    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
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
					<A href="ChargeMaster.asp">here</A> to view menu 
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
	

