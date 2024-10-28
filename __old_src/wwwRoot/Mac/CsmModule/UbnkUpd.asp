<%@ Language=VBScript %>
<%
lUserId=request.form("selUsrId")
lAccType=request.form("selAccounttype")


dim lobjRsUser
dim lObjBnkGrp
dim lObjRsBnkGrp
dim lObjRsBrnCode
dim lSplitRes
set lObjBnkGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsBnkGrp=server.CreateObject("adodb.recordset")
set lObjRsBrnCode=server.CreateObject("adodb.recordset")
set lobjRsUser=lObjBnkGrp.GetUsers()
set lObjRsBnkGrp=lObjBnkGrp.GetBankCodes()
if Request.Form("txtBnkCode")<>"" then
   set lObjRsBrnCode=lObjBnkGrp.GetBranchCodes(Request.Form("txtBnkCode"))
end if

		if lobjRsUser.BOF=false then
		lobjRsUser.movefirst
		end if
%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmChargeSelection.OptBnKCode.selectedIndex;
		var j=document.frmChargeSelection.OptBnKCode.options[i].value;
		document.frmChargeSelection.txtBnkCode.value =j;  
    	document.frmChargeSelection.submit();
	}
	

	
	function btnClick(fValue)
	{	
	if (document.frmChargeSelection.selUsrId.value=="")
	{
	alert("Select Userid please");
	return false;
	}
	if (document.frmChargeSelection.selAccounttype.value=="")
	{
	alert("Select Accounttype please");
	return false;
	}
	if (document.frmChargeSelection.OptBnKCode.value=="") 
	{
	alert("Select BankCode please");
	return false;
	}
	
 else
 	{
			document.frmChargeSelection.action="UbnkUpdRes.asp";
			document.frmChargeSelection.method="post";
			document.frmChargeSelection.submit(); 	
			return true;
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

	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class="bodycolor">
	<form name="frmChargeSelection"  method="post">
	<center>
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	
	<%
	If not  lObjRsBnkGrp.EOF then
	%>
	<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Select the criteria to UpDate :</td>
	</tr>
	
	<TR><TD class=tdbglight width=202 height="13"><font class=blacktext>User&nbsp;
        Id:</font></TD>
		<TD WIDTH="303" CLASS=tdbglight height="13"> 
		<select size="1" name="selUsrId" style="HEIGHT: 22px; WIDTH: 150px">
		<option selected value="">-- User Ids--</option>
		<%
			while not lobjRsUser.EOF %>
			<option  <%if lobjRsUser(0)=lUserId then response.write "selected"%>    value="<%=lobjRsUser(0)%>" <%if lobjRsUser(0)=Request.Form("txtUserId") then Response.Write "selected"%>> <%=lobjRsUser(0)%></option>
			<%lobjRsUser.MoveNext 
			wend
			%>
		</select> </td>
		</TR>
		<TR><TD class=tdbglight width=202 height="23"><font class=blacktext>Account
            Type:</font></TD>
		<TD WIDTH="303" CLASS=tdbglight height="23"> 
		<select size="1" name="selAccounttype" style="HEIGHT: 22px; WIDTH: 150px" >
		<option <%if lAccType="C" then response.write "selected" %> value="C">Clearing Account</option>
		<option <%if lAccType="M" then response.write "selected" %> value="M">Margin Account</option>

		</select> </td>
		</TR>
	 <TR><TD class=tdbglight width=20% height="20"><font class=blacktext>Bank code</font></TD>
		<TD WIDTH="367" CLASS=tdbglight height="25"> 
		<select size="1" name="OptBnKCode" style="HEIGHT: 22px; WIDTH: 150px" onchange="ChkSubmit()">
		<option selected value="">Select Bank Code</option>
	<%
	if not lObjRsBnkGrp.EOF and trim(Request.Form("txtBnkCode"))="" then
		do while not lObjRsBnkGrp.EOF %>
			<option <%'if trim(lObjRsBnkGrp(0))=trim(Request.Form("txtBnkCode")) then Response.Write "selected"%> value="<%=lObjRsBnkGrp(0)%>"><%=lObjRsBnkGrp(0)%></option>
			<%lObjRsBnkGrp.MoveNext 
		loop
	else
		do while not lObjRsBnkGrp.EOF%>
			<option <%if trim(lObjRsBnkGrp(0))=trim(Request.Form("txtBnkCode")) then Response.Write "selected"%> value="<%=lObjRsBnkGrp(0)%>"><%=lObjRsBnkGrp(0)%></option>
			<%lObjRsBnkGrp.MoveNext 
		loop
	end if
		%>
		</select>
		<input type=hidden name="txtBnkCode">
		<tr><TD class=tdbglight width=30% height="25"><font class=blacktext>Branch Code </font></TD>
		<%if Request.Form("txtBnkCode")<>"" then%>
			<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5">
			<select size="1" name="OptBrnCode" style="HEIGHT: 22px; WIDTH: 150px">
				
		<%
		if not lObjRsBrnCode.EOF then
			do while not lObjRsBrnCode.EOF %>
				<option value=<%=lObjRsBrnCode(0)%>><%=lObjRsBrnCode(0)%></option>
				<%lObjRsBrnCode.MoveNext 
			loop
		end if
		%>
		</select> </td>
		
		<%else%>
			<td WIDTH="367" CLASS=tdbglight height="25" bgcolor="#dadac5"><font class=blacktext2>Select BankCode  to Display BranchCode</font></td>
		<%end if
		%>
	</tr>
	
 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="sbtAdd"   value="View"   onclick ="btnClick(1)">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="sbtCancel" value="Cancel"  >
	</td>
	</tr>
	</table>
	
<%end if 
set lObjRsBnkGrp=nothing
set lObjRsBrnCode=nothing
%>
    <br>
    <!--#include file="../Includes/footer.inc"> -->
   	</FORM>
	</body>
</Html>
	












