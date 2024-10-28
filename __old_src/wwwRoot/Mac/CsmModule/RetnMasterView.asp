<%@ Language=VBScript %>
 
<HTML>
<HEAD>
<script language=javascript>
	function GetDisabled()
	{
		document.frmViewRet.OptUserId.disabled = true;
		document.frmViewRet.txtRetAmt.disabled = false;
		document.frmViewRet.txtRetOChrg.disabled = false;
		document.frmViewRet.sbtView.disabled=true;
	}
	
		
	function btnClick(btnValue)
	{
		var lActionValue=btnValue;
		if (lActionValue==1) 
		{
			
			document.frmViewRet.hidActionvalue.value =1;
			if (document.frmViewRet.OptUserId.value=="")
			{
				alert("Please select User Id and Name ");
				return false;
			}
			else
			{
				document.frmViewRet.action="RetnMaster.asp";
				document.frmViewRet.method="post";
				document.frmViewRet.submit(); 
			}
		}
		else if(lActionValue==2) 
		{
			
			document.frmViewRet.hidActionvalue.value =2;
			if (document.frmViewRet.OptUserId.value=="")
			{
				alert("Please select User Id and Name ");
				return false;
			}
			else
			{
				document.frmViewRet.action="RetnMasterView.asp";
				document.frmViewRet.method="post";
				document.frmViewRet.submit(); 
			}
		 }
		else if(lActionValue==3) 
		{
			
			document.frmViewRet.hidActionvalue.value =3;
			if (document.frmViewRet.OptUserId.value=="")
			{
				alert("Please select User Id and Name");
				return false;
			}
			else
			{
				document.frmViewRet.action="RetnMasterUpdate.asp";
				document.frmViewRet.method="post";
				document.frmViewRet.submit(); 
			}
		}	
		else if(lActionValue==4) 
		{
			
			document.frmViewRet.hidActionvalue.value =4;
			if (document.frmViewRet.OptUserId.value=="")
			{
				alert("Please select User Id and Name");
				return false;
			}
			else
			{
				document.frmViewRet.action="RetnMasterUpdate.asp";
				document.frmViewRet.method="post";
				document.frmViewRet.submit(); 
			}
		}			
		else if(lActionValue==5) 
		{
			document.frmViewRet.action="RetnMaster.asp";
			document.frmViewRet.submit(); 
		}
	}	
		
   </script>
	
	<style>
		a {text-decoration:none}
		a:hover { color:#3333FF}
	</style>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<title>Welcome to the bombay oilseeds and oils exchange limited</title>
	<link rel="stylesheet" href="../includes/Theme.css">
	<meta name="Microsoft Border" content="none, default">
</HEAD>
<center>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!---#include file="../includes/header.inc"--->
<br>
<!---#include file="../includes/MACLinks.inc"--->
<%
 dim lObjRetView
 dim lUserId
 dim lRetAmt
 dim lRetOChrg
 dim lResult
 dim lResultValues
 
 lUserId	= trim(Request.Form("OptUserId"))
 set lObjRetView	=	server.CreateObject("RETENTIONMAIN.Retention")
 Response.Write "userid=" & lUserId
 lResult = lObjRetView.View(lUserId)
 Response.Write  "Result = " & lResult
 'Response.Write lresult(0)
 
 lResultValues = split(lResult,"|")
 
 %>
<BODY marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor onload="GetDisabled();">
<center>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->

<form name="frmViewRet"  method="post" >
<table width="55%" border="1"  cellpadding=2 cellspacing=2 align=center height="146">
<tr class="tdbgdark">
 <td valign=center colspan=3 class="whiteboldtext1">Retention  Master</td>
 </tr>
		
	 <TR><TD class=tdbglight width=30% height="20"><font class=blacktext>User id and Name</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptUserId" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option value="<%=lUserId%>" selected> <%=lResultValues(1)%></option>
		</select> </tr><input name="hidUserId" value=<%=lResultValues(1)%> type=hidden>
		
	 <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Retn. Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name="txtRetAmt" value="<%=lResultValues(2)%>" style="HEIGHT: 22px; WIDTH: 180px" ></td>
     </tr>
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Retn.Penality Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name="txtRetOChrg" value="<%=lResultValues(3)%>" style="HEIGHT: 22px; WIDTH: 180px" ></td>
     </tr>
     <input type=hidden value="<%=lUserId%>" name="txtUserId">
     <tr> 
     <tr> 
	 <td colspan=3 valign="center" align=middle class="tdbglight">
	 <input type=hidden name="hidActionvalue">
   		<input type="Button" name="sbtAdd"   value="Add    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtView"  value="View   "  onclick ="GetDisabled(); return btnClick(2);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtUpdate"   value="Update "  onclick ="return btnClick(3);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtDelete" value="Delete "  onclick ="return btnClick(4);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(5);">&nbsp;&nbsp;&nbsp;
	</td>

	</tr>
	</table>
	 </table>
	 <P>&nbsp;</P>
</form>
<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>
