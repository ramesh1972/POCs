<%@ Language=VBScript %>
<%
    '**************************************************************************
	'* Application	:	BCE								    				  *
	'* Module		:   Mac													  *
	'* File name	:	RetAmtSelection.asp               					  *
	'* Purpose		:	This page will display Retention Amount Details       *
	'* Prepared by	:	Obula Reddy                 						  *	
	'* Date			:	20.11.2001											  *
	'* Copyright	:	(c) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page will display all Retention Amount Details . Based on User    *
	'*	selection all Retention Amount details  will be displayed             *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.- Date		- By				   - Explanation	   	  *
	'*	1		            - Obula Reddy                 First Baseline      *
	'**************************************************************************
	
	
dim lObjUserId 
dim lObjRsUserId
set lObjUserId=server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsUserId=server.CreateObject("adodb.recordset")

set lObjRsUserId=lObjUserId.GetUsers()
'Response.Write lObjRsUserId.GetString 
%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmRetSelection.OptUserId.selectedIndex;
		var j=document.frmRetSelection.OptUserId.options[i].value;
		document.frmRetSelection.txthUser.value=j;
    	document.frmRetSelection.submit();
	}
	
	
	function btnClick(fValue)
	{
		var i=fValue;
		
		if (i==1) 
			{
			if (document.frmRetSelection.OptUserId.value=="")
			   {
				alert("Select User id ");
				return false;
			   }
			else
			   {
				document.frmRetSelection.action="AddRetAmt.asp";
				document.frmRetSelection.method="post";
				document.frmRetSelection.submit(); 
				}
			}
			
			if (i==2) 
			{
			if (document.frmRetSelection.OptUserId.value=="")
			   {
				alert("Select User id ");
				return false;
			   }
			else
			   {
				document.frmRetSelection.action="ViewRetAmt.asp";
				document.frmRetSelection.method="post";
				document.frmRetSelection.submit(); 
				}
			}
			if (i==3) 
			{
			if (document.frmRetSelection.OptUserId.value=="")
			   {
				alert("Select User id ");
				return false;
			   }
			else
			   {
				document.frmRetSelection.action="UpdateRetAmt.asp";
				document.frmRetSelection.method="post";
				document.frmRetSelection.submit(); 
				}
			}

			if (i==4) 
			{
			if (document.frmRetSelection.OptUserId.value=="")
			   {
				alert("Select User id ");
				return false;
			   }
			else
			   {
				document.frmRetSelection.action="DeleteRetAmt.asp";
				document.frmRetSelection.method="post";
				document.frmRetSelection.submit(); 
				}
			}
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
	
	<%	If not  lObjRsUserId.EOF then%>
	   <form name="frmRetSelection"  method="post">
	   <table width="55%" border="1"  cellpadding=2 cellspacing=2 align=center height="146">
	   <tr class="tdbgdark">
	   <td valign=center colspan=3 class="whiteboldtext1">Retention Master</td>
	   </tr>
		
	  <TR><TD class=tdbglight width=50% height="20"><font class=blacktext>User ID (TCM/ICM)</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptUserId" style="HEIGHT: 22px; WIDTH: 180px" onchange="ChkSubmit()">
		<option selected value="">Select User ID </option>
		<%
		if not lObjRsUserId.EOF then
			do while not lObjRsUserId.EOF %>
				<option <%if trim(lObjRsUserId(0))=trim(Request.Form("txthUser")) then Response.Write "selected"%> value=<%=lObjRsUserId(0)%>><%=lObjRsUserId(0)%>--<%=lObjRsUserId(1)%></option>
				<%lObjRsUserId.MoveNext 
			loop
		end if
		
		%>
	 <input type=hidden name=txthUser>
	 <tr>
      <td class=tdbglight width=50% height="25"><font class=blacktext>Retention Amount </font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtRetAmt>
     </tr>
     <tr>
      <td class=tdbglight width=50% height="25"><font class=blacktext>Retention Penality Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name=txtRetPetAmt>
     </tr>
	<tr> 
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAddRet"  value="Add     "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtViewRet" value="View    "  onclick ="return btnClick(2);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtUpdRet"  value="Update  "  onclick ="return btnClick(3);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtDelRet"  value="Delete  "  onclick ="return btnClick(4);"-->&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel"   value="Cancel  "  onclick ="return btnClick(5);">
	</td>

	</tr>
	</table>
	<%else%>
	 <center><p>  
       <table width="70%" align=center border=0>
				<tr class="tdbgdark"> 
					<td colspan=2 class="whiteboldtext1">Select User ID </td>
				</tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">No More TCM/ICM's are  Available for Selection......Click
					<A href="TCMAdmin.asp">here</A> to view menu 
					</td>
				</tr>		
				<tr><td>&nbsp;</td></tr>
		</table>
   </Center>

	 <%end if%>
    <br><br>
    </FORM>
    <!---#include file="../Includes/footer.inc"---> 
	</body>
</Html>

	

