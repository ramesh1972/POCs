<%@ Language=VBScript %>
<%
dim lObjBnkGrp
dim lObjRsBnkGrp
dim lObjRsBrnCode
dim lSplitRes
set lObjBnkGrp=server.CreateObject("MacWebCon.clsMacWebCon")
set lObjRsBnkGrp=server.CreateObject("adodb.recordset")
set lObjRsBrnCode=server.CreateObject("adodb.recordset")
set lObjRsBnkGrp=lObjBnkGrp.GetBankCodes()
if Request.Form("txtBnkCode")<>"" then
   set lObjRsBrnCode=lObjBnkGrp.GetBranchCodes(Request.Form("txtBnkCode"))
end if

%>
	<script language="Javascript">
	function ChkSubmit()
	{
		var i=document.frmubnkSelectionAll.OptBnKCode.selectedIndex;
		var j=document.frmubnkSelectionAll.OptBnKCode.options[i].value;
		document.frmubnkSelectionAll.txtBnkCode.value =j;  
    	document.frmubnkSelectionAll.submit();
	}
	function	FunctionView()
	{	
	if (document.frmubnkSelectionAll.OptBnKCode.value=="") 
	{
		alert("Select BankCode please");
		return false;
	}
	else
 	{
		document.frmubnkSelectionAll.action="BankUpdRes.asp";
		document.frmubnkSelectionAll.method="post";
		document.frmubnkSelectionAll.submit(); 	
		return true;
	}
    }
    function FunctionCancel()
	{
	 document.frmubnkSelectionAll.action="BankMenu.asp";
	 document.frmubnkSelectionAll.method="Post";
	 document.frmubnkSelectionAll.submit();    
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
	<form name="frmubnkSelectionAll"  method="post">
	<center>
	<br>
	<br>
	<!---#include file="../includes/header.inc"--->
	<br>
	<!---#include file="../includes/MACLinks.inc"--->
	<br>
	<%
	If not  lObjRsBnkGrp.EOF then
	%>
	<table width="55%" border="1"  cellpadding=2 cellspacing=1 align=center height="146">
	<%if Request.QueryString("Mode")="V" then%>
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Select Bank Code to View Bank Details</td>
	</tr>
	<%elseif Request.QueryString("Mode")="D" then%>
	<tr class="tdbgdark">
	   <td valign=center colspan=2 class="whiteboldtext1">Select Bank code to Delete Bank Details</td>
	</tr>
	<%end if%>
   <input type=hidden name=txthidMode value=<%=Request.QueryString("Mode")%>>	
		
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
			<td WIDTH="150" CLASS=tdbglight height="25" bgcolor="#dadac5">
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
			<td WIDTH="40" CLASS=tdbglight height="10" bgcolor="#dadac5"><font class=blacktext2>Select BankCode  to Display BranchCode</font></td>
		<%end if
		%>
	</tr>
	
	<tr>
	 <td colspan=3 valign="center" align=middle class="tdbglight">
   		<input type="Button" name="btnView"   value="View    "  onclick ="FunctionView();">&nbsp;&nbsp;&nbsp;
   		<input type="reset" name="btnCancel" value="Cancel"  onclick ="FunctionCancel();">
	</td>
	</tr>
	</table>
	<%else%>
	 <center><p>  
       <table width="70%" align=center border=0>
				<tr class="tdbgdark"> 
					<td colspan=2 class="whiteboldtext1">Select bank code</td>
				</tr>
				<tr class="tdbglight"> 
					<td colspan=2 class="blacktext">No More  bank detail Available for Selection......Click
					<A href="../TempMAc/BankMenu.asp">here</A> to view menu 
					</td>
				</tr>		
				<tr><td>&nbsp;</td></tr>
		</table>
   </Center>
<%end if
set lObjRsBnkGrp=nothing
set lObjRsBrnCode=nothing
%>
    <br><br>
    <!---#include file="../Includes/footer.inc"---> 
   	</FORM>
	</body>
</Html>
	
