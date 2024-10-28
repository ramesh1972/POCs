<%@ Language=VBScript %>
<%
dim mCDelRs
Dim mCDelObj
dim lContType

set mCDelObj = server.CreateObject("MacWebCon.clsMacWebCon")
set mCDelRs = server.CreateObject("ADODB.Recordset") 
set mCDelRs  = mCDelObj.GetContractCodes()

%>
<HTML>
<HEAD>
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
	</HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' onload="">
	<!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	
	<script language =javascript>
	function IntChange()
	{
		document.frmMarketContract.hidInst.value=document.frmMarketContract.optMkrAdd.options[document.frmMarketContract.optMkrAdd.selectedIndex].value;
	}
	function instChk()
	{
		if (document.frmMarketContract.optMkrAdd.value =="")
		{
			alert("Select A Contract");
			return false;
		}
	
	}
	function funExit()
	{	 
	 document.frmMarketContract.action ="MarketMenu.asp";
	 document.frmMarketContract.method ="Post";
	 document.frmMarketContract.submit();		
	}
	function Addasucc()
	{
	document.frmMarketContract.action ="MktContaddRes.asp";
	document.frmMarketContract.method ="post";
	document.frmMarketContract.submit();
	}
	</script>
	<form name="frmMarketContract" >
	<input type="hidden" name ="hidInst" >
	<table width="50%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr align="middle" class="tdbgdark">
		<td colspan=2 >
		<font class=whiteBoldtext>Contract Information
		</td>
	</tr>
	<tr>
		<td WIDTH="30%" class=tdbglight align="middle">
		<font class=blackBoldtext>Select Contract Code </font>
		</td>
		<td WIDTH="20%" class=tdbglight align="middle">
		<SELECT style="WIDTH: 180px" class=tdbglight name="optMkrAdd" onchange="IntChange()" >
			<OPTION value="" selected>Select Contract Code</OPTION>
			<%
			if not(mCDelRs.BOF and mCDelRs.EOF) then
				while not mCDelRs.EOF %>
					<%if trim(Request.Form("hidInst"))= mCDelRs("inst_code") then%>
   						<option value=<%=mCDelRs("INST_CODE")%> selected> <%=mCDelRs("INST_CODE")%></option>
					<%else%>
						<option value=<%=mCDelRs("INST_CODE")%>> <%=mCDelRs("INST_CODE")%></option>
					<%end if
						mCDelRs.MoveNext 
				wend
			end if
			%>
		</SELECT>
		</td>
	</tr>
</table>
<br>
<br>
	<table width="20%" border=1 cellpadding=1 cellspacing=1 align="center">
	<tr WIDTH="80%" class=tdbglight height=10 align="left">
		<td colspan=4 align="center">
			<INPUT style="WIDTH: 80px" type="button" value="Add"     name=btnAdd onclick="Addasucc();">&nbsp;&nbsp;
			<INPUT style="WIDTH: 80px" type="button" value="Cancel"  name=btnExit onclick="funExit();">
		</td>
	</tr>
	</table>
<INPUT id=text1 name=text1 style="WIDTH: 5px" width="5">
</form></FONT>
<!---#include file="../includes/footer.inc"--->
	
</body>
</HTML>



 