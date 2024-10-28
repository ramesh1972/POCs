<%@ Language=VBScript %>
<% 
Option Explicit
Response.Buffer =True
'on error resume Next

dim prodSql
dim planSql
dim rsProd
dim rsPlan
dim cnn
'dim adOpenStatic

Const adOpenStatic = 3
Const adLockReadOnly = 1
set cnn=server.CreateObject("ADODB.Connection")
set rsProd=Server.CreateObject("ADODB.Recordset")
set rsPlan=Server.CreateObject("ADODB.Recordset")

cnn.Open "DSN=HealthCare;uid=;pwd=;"
	If Err.Number<>0 then
	   ErrorInfo()
	   Response.End 
	End IF
	
planSql="Select Payer_Plan_Code, Plan_Name from Plans"
prodSql="Select Product_Group_Code,Product_Group_Name from ProdGrp"

rsProd.Open prodSql,cnn,adOpenStatic,adLockReadOnly 
rsPlan.Open planSql,cnn,adOpenStatic,adLockReadOnly 


%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="themes.css">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

function submit_onclick() {
	if(document.frmPlan.PlanCode.value=='')
	{
	alert('Please select One Plan');
	document.frmPlan.PlanCode.focus();
	return false;
	}
	if(document.frmPlan.ProductCode.value=='')
	{
	alert('Please select One Product');
	document.frmPlan.ProductCode.focus();
	return false;
	
	}
}

//-->
</SCRIPT>
</HEAD>
<BODY>
<br><br>
<h2 align="center"><font face="Times New Roman" Size="4" color="#ff0000"> HeathCare </Font></h2>

<FORM NAME="frmPlan" METHOD="Post" ACTION="ViewPlan.asp">

<TABLE align="center" WIDTH="75%" BORDER=1 CELLSPACING=1 CELLPADDING=1>
	<%If not(rsPlan.EOF and rsPlan.BOF) then %>
		<TR>
		<TD width="35%"><font face="Times New Roman" Size="4" color="#ff0000">List of Plans </font></TD>
		<TD width="40%">
		<SELECT name="PlanCode" onchange="document.frmPlan.PlanName.value=document.frmPlan.PlanCode.options[selectedIndex].text;">
		<OPTION Selected>--Select One Plan--</OPTION>
	<%while not rsPlan.EOF %>	
			<OPTION value="<%=rsPlan.Fields("Payer_Plan_Code") %>"><%=rsPlan.Fields("Plan_Name") %></OPTION>
		
		<%rsPlan.MoveNext 
		 wend%>		
	</SELECT>
	<INPUT TYPE="HIDDEN" NAME="PlanName">
	 </TD>
	</TR>
		<%Else %>
	<%=Display_NoRecords()%>
	<%End IF%>
	</TABLE>
<TABLE align="center" WIDTH="75%" BORDER=1 CELLSPACING=1 CELLPADDING=1>	
	<TR> <TD width="35%"><font face="Times New Roman" Size="4" color="#ff0000">Product List</font></TD>
		<%If not(rsProd.EOF and rsProd.BOF) then %>
		<TD width="40%"><SELECT name="ProductCode" onchange="document.frmPlan.ProductName.value=document.frmPlan.ProductCode.options[selectedIndex].text;">
		<OPTION Selected>--Select One Product--</OPTION>
		<%while not rsProd.EOF %>	
			<OPTION value="<%=rsProd.Fields("Product_Group_Code") %>"><%=rsProd.Fields("Product_Group_Name") %></OPTION>
		
		<%rsProd.MoveNext 
		 wend%>		
	</SELECT>
	<INPUT TYPE="HIDDEN" NAME="ProductName">
	</TD>
	<%Else %>
	<%Display_NoRecords()%>
	<%End IF%>
	</TR>
<TABLE align="center" WIDTH="75%" BORDER=1 CELLSPACING=1 CELLPADDING=1>	
	<TR>
		<TD width="35%" align="right"><INPUT type="submit" value="Submit" name=submit onclick="return submit_onclick();"></TD>
		<TD width="40%"><INPUT type="reset" value="Reset"  name=reset></TD>
	</TR>
</TABLE>
</FORM>
</BODY>
</HTML>

<%Set rsProd=Nothing
 Set rsPlan=Nothing
 Set Cnn=Nothing %>

<%Sub Display_NoRecords()%>
<TD><font face="Times New Roman" Size="4" color="#ff0000">
INFORMATION NOT AVAILABLE</font></TD>

<%End Sub%>

<% Sub ErrorInfo()%>
<br><br><br>
<TABLE align="center" WIDTH="80%" BORDER=1 CELLSPACING=1 CELLPADDING=1>
	<TR>
	<TD align="center"><font face="Times New Roman" Size="4" color="#ff0000">
	Internal Error. Please Try again !..</font></TD></TR>
		
<%End Sub%>