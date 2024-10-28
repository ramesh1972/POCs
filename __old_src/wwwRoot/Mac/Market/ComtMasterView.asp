<%@ Language=VBScript %>
 
<HTML>
<HEAD>
<script language=javascript>
	function GetDisabled()
	{
		document.frmViewChrage.OptComgCode.disabled = true;
		document.frmViewChrage.OptContCode.disabled  = true;
		document.frmViewChrage.optChrgType.disabled= true; 
		document.frmViewChrage.optChrgBase.disabled= false;
		document.frmViewChrage.txtChrgFee.disabled = false;
		document.frmViewChrage.txtChrgAmt.disabled = false;
		document.frmViewChrage.sbtView.disabled=true;
	}
	
		
	function btnClick(btnValue)
	{
		var lActionValue=btnValue;
		if (lActionValue==1) 
		{
			
			document.frmViewCharge.hidActionvalue.value =1;
			if (document.frmViewCharge.optComgCode.value=="")
			{
				alert("Please select Comg Code");
				return false;
			}
			else
			{
				document.frmViewCharge.action="ChrageMaster.asp";
				document.frmViewCharge.method="post";
				document.frmViewCharge.submit(); 
			}
		}
		else if(lActionValue==2) 
		{
			
			document.frmViewCharge.hidActionvalue.value =2;
			if (document.frmViewCharge.optComgCode.value=="")
			{
				alert("Please select Commodity code");
				return false;
			}
			else
			{
				document.frmViewCharge.action="ChargeView.asp";
				document.frmViewCharge.method="post";
				document.frmViewCharge.submit(); 
			}
		 }
		else if(lActionValue==3) 
		{
			
			document.frmViewChrage.hidActionvalue.value =3;
			if (document.frmViewChrage.OptComgCode.value=="")
			{
				alert("Please select Commodity Group code");
				return false;
			}
			else
			{
				document.frmViewChrage.action="ChargeMasterUpdate.asp";
				document.frmViewChrage.method="post";
				document.frmViewChrage.submit(); 
			}
		}	
		else if(lActionValue==4) 
		{
			
			document.frmViewChrage.hidActionvalue.value =4;
			if (document.frmViewChrage.OptComgCode.value=="")
			{
				alert("Please select Commodity code");
				return false;
			}
			else
			{
				document.frmViewChrage.action="ChargeMasterUpdate.asp";
				document.frmViewChrage.method="post";
				document.frmViewChrage.submit(); 
			}
		}			
		else if(lActionValue==5) 
		{
			document.frmViewChrage.action="ChargeMaster.asp";
			document.frmViewCharge.submit(); 
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
<%'<!---#include file="../includes/header.inc"--->%>
<br>
<%'<!---#include file="../includes/MACLinks.inc"--->%>
<%
 dim lObjChrgView
 dim lComgCode
 dim lContCode
 dim lChrgType
 dim lChrgBase
 dim lChrgFee
 dim lChrgAmt
 dim lResult
 dim lResultValues
 dim lDisValue
 dim lChBase
 
 lComgCode	= trim(Request.Form("optComgCode"))
 lContCode	= trim(Request.Form("optContCode"))
 lChrgType  = trim(Request.Form("optChrgType"))
 
 Response.Write  "Group = " & lComgCode & "Contract = " & lContCode & "Charge Type = " &  lChrgType & "<BR>"
 
 set lObjCharge	=	server.CreateObject("CLEARANDSETTLEMENT.ClearSettlement")
 lResult = lObjCharge.chargeMasterUpdateDeleteBrowse("MZE0006000",lComgCode,lContCode,lChrgType)
 Response.Write  "Result = " & lResult
 
 lResultValues = split(lResult,"|")
 
 
 
 
 %>
<BODY marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor onload="GetDisabled();">
<center>
	<!---#include file="includes/header.inc"--->
	<br>
	<!--- #include file="includes/MAClinks.inc" --->

<form name="frmViewChrage"  method="post" >
<table width="55%" border="1"  cellpadding=2 cellspacing=2 align=center height="146">
<tr class="tdbgdark">
 <td valign=center colspan=3 class="whiteboldtext1">Charge Master</td>
 </tr>
		
	 <TR><TD class=tdbglight width=30% height="20"><font class=blacktext>Commodity  Group Code</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptComgCode" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option value="<%=lComgCode%>" selected> <%=lComgCode%></option>
		</select> </tr><input name="hidComgCode" type=hidden value="<%=lComgCode%>" >
		<tr><TD class=tdbglight width=30% height="25"><font class=blacktext>Contract </font></TD>
		<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5"><select size="1" name="OptContCode" style="HEIGHT: 22px; WIDTH: 150px">
		<option value="<%=lContCode%>" selected> <%=lContCode%></option>
						
		</select> </td>	
	</tr> <input type=hidden value="<%=lContCode%>" name="hidContCode">
	 <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge Type</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <select size="1" name="optChrgType" style="HEIGHT: 22px; WIDTH: 150px">
	  <option value="<%=lChrgType%>" selected> <%=lChrgType%></option>
	</select>
     </tr><input type=hidden value=<%=lChrgType%>  name="hidChrgType">
	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge Base</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <% 'lChBase = lResultValues(4)
      'select case(lChBase)
	'	case	"Q"	:	lDisValue = "Quantity"
	'	case	"V"	:	lDisValue = "Value"
     ' end select
      %>
      <select size="1" name="optChrgBase" style="HEIGHT: 22px; WIDTH: 150px">
	  <option value="<%=lResultValues(4)%>" selected> <%=lResultValues(4)%></option>
	</select>
     </tr>
     <input type=hidden name="hidChrgBase" value="<%=lResultValues(4)%>" >
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Charge</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name="txtChrgFee" value="<%=(lResultValues(5))/100%>" style="HEIGHT: 22px; WIDTH: 180px" ></td>
     </tr>
     <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Amount</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25">
      <input type=text name="txtChrgAmt" value="<%=(lResultValues(6))/100%>" style="HEIGHT: 22px; WIDTH: 180px" ></td>
     </tr>
     <input type=hidden value="<%=lComgCode%>" name="txtComgCode">
     <input type=hidden value="<%=lContCode%>" name="txtContCode">
     <input type=hidden value="<%=lChrgType%>" name="txtChrgType">
     <tr> 
     <tr> 
	 <td colspan=3 valign="center" align=middle class="tdbglight">
	 <input type=hidden name="hidActionvalue">
   		<input type="Button" name="sbtAdd"   value="Add    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtView"  value="View   "  onclick ="GetDisabled(); return btnClick(2);">&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtUpdate"   value="Update " onclick ="return btnClick(3);" >&nbsp;&nbsp;&nbsp;
   		<input type="Button" name="sbtDelete" value="Delete "  onclick ="return btnClick(4);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(5);">&nbsp;&nbsp;&nbsp;
	</td>

	</tr>
	</table>
	 </table>
	 <P>&nbsp;</P>
</form>
<!---#include file="includes/footer.inc"--->
</BODY>
</HTML>

