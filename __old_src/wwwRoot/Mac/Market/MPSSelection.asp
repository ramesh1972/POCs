<%@language="vbscript"%>
<%
dim objMac
dim objRsMps
set objMac=server.CreateObject("MacWebCon.clsMacWebCon")
set objRsMps=server.CreateObject("ADODB.Recordset")
set objRsMps=objMac.GetContractCodes()
if objRsMps.BOF =false then
	objRsMps.MoveFirst 
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE>Market Price Statistics</TITLE>
<link rel="stylesheet" href="../Includes/Theme.css">
<script language="javascript">
	function sel_Change()
	{
		document.frmMPS.hidselValue.value=document.frmMPS.selContract.options[document.frmMPS.selContract.selectedIndex].value;
	}
	function FunctionView()
	{
		/*if (document.frmMPS.selContract.value =="")
		{
		   alert("Select A Contract");
		   return false;
		}
		else
		{*/
		 document.frmMPS.action="MpsView.asp";
	     document.frmMPS.method="Post";
	     document.frmMPS.submit();  
	    
	}
		function FunctionCancel()
		{
		document.frmMPS.action="macmarket.asp";
		document.frmMPS.submit();
		}    
	   
</script>
</HEAD>
<BODY>
<Center>
<!--#include file="../includes/header.inc"-->
		<br>
<!--- #include file="../includes/MAClinks.inc" --->
	<br>

<form name="frmMPS" method="post" action="mpsselection.asp">
	<table width="347" align="center" border="1"  cellpadding=1 cellspacing=1 >
		<tr class=tdbgdark height=30 align=middle><td align=left width="337"><font class=whiteboldtext1>Market Price Statistics</font></td></tr>
			<tr class=tdbglight height=30 align=left><td width="337">&nbsp; Contract Code 
	      :&nbsp;&nbsp;&nbsp; <SELECT  name="selContract" style="height: 23; width: 210" onchange="sel_Change()"> 
		      <OPTION  value="ALL" selected> All Contracts </OPTION>
		      <%while not objRsMps.EOF%>
					<%if trim(Request.Form("hidselValue"))= objrsMps("inst_code") then%>
						<OPTION value=<%=objrsMps("inst_code")%> selected><%=objrsMps("inst_desc")%></OPTION>
					<%else%>
					<OPTION value=<%=objrsMps("inst_code")%>><%=objrsMps("inst_desc")%></OPTION>
					<%end if%>
					<%objRsMps.MoveNext 
					wend
					objRsMps.Close 
					set objrsMps=nothing
					%>
			<%else%>
				<%objRsMps.Close 
				set objrsMps=nothing%>			
			<%end if%>
	      </SELECT></td></tr>
	</table>
	<input type="hidden" name ="hidselValue" ><br>
	<CENTER>
	
	<tr class=tdbglight height=30 align="center">
	<td>
	   <INPUT name="btnView" type="submit" value="View" onclick="FunctionView();">
	   <input name="btnCancel" type="Reset" value="Cancel" onclick="FunctionCancel();">
   </td>
    </tr>
	</TABLE>
	</CENTER>
</form>
<br>
<!---#include file="../includes/footer.inc"--->

</BODY>
</HTML>
	