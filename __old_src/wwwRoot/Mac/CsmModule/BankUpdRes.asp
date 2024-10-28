<%@ Language=VBScript%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
 <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
</HEAD>
<BODY marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
<form name="frmBankView" method="post">
<center>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->
	<br>
<script language="Javascript">

function btnClick(fValue)
	{
	var i=fValue;
	if (i==1) {
		document.frmBankView.action="BankUpdResult.asp";
		document.frmBankView.method="post";
		document.frmBankView.submit(); }
	else if(i==2) {
		document.frmBankView.action="BankMenu.asp";
		document.frmBankView.submit(); }
	}
	
</script>	
<%
	dim lObjBnkUpdate
	dim lBankCode
	dim lBranchCode
	dim lBranchname
	dim lAddress1
	dim lAddress2
	dim lAddress3
	dim lResult
	dim lResponse
	
	
		lBankCode	= trim(Request.Form("optBnkCode"))
		lBranchCode	= trim(Request.Form("optBrnCode"))
		set lObjBnkUpdate	= server.CreateObject("Project1.BankMasterMgr")
		lResult	=	lObjBnkUpdate.DoUpdate(lBankCode,lBranchCode,lBranchname,lAddress1,lAddress2,lAddress3)
				
if lResult=0 then
%>	

<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Bank Master View</td>
		
	</tr>

	<tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Bank Code </font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lBankCode%>
    </tr>
 
    <tr>
      <td class=tdbglight width=30% height="25"><font class=blacktext>Branch Code</font> </td>
      <td WIDTH="367" CLASS=tdbglight height="25"><%=lBranchCode%>
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
      <td  colspan=2 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtUpdBnk"   value="Update    "  onclick ="return btnClick(1);">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  onclick ="return btnClick(2);">
	</td>
    </tr>
 
 <input type=hidden name=txtBnkCode value=<%=trim(Request.Form("optBnkCode"))%>>
 <input type=hidden name=txtBrnCode value=<%=trim(Request.Form("optBrnCode"))%>>
</table>
</form>			
<%else%>
<center>
		<table width="80%" border="1" cellspacing="1" cellpadding="1">
		<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Bank  Master View</font></td></tr>
		<tr width="40%"><td class=tdbglight>
		<font class=colorboldtext1>No Bank  Details available for the selected cirteria. Click <a href="BankMenu.asp">here</a> to view the previous page</font>
		</td></tr>
		</table>
</center>		
<%end if%>
		
	<br><br>

	<!---#include file="../includes/footer.inc"--->
	</body>
	</HTML>


















