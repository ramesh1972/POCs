<%@ Language=VBScript %>
<% Option Explicit
Response.Buffer =True
on error resume Next

dim periodSql
dim planSql
dim rsPeriod
dim rsPlan
dim cnn
dim lProductCode
dim lProductName
dim lPlanCode
dim lPlanName
dim lCount
dim totscriptSql
dim i
dim str
dim j
'dim lQuarter(10)
dim rsTotScript
dim rsFactsMOP
dim FactsMOPSql
'dim adOpenStatic
'Constant declarations
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3
'end of const
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4
'end of cursor decl

lProductCode=trim(Request.Form("ProductCode"))
lProductName=Request.Form("ProductName")
lPlanCode=trim(Request.Form("PlanCode"))
lPlanName=Request.Form("PlanName")
'end of request values from previous form

set cnn=server.CreateObject("ADODB.Connection")
set rsPeriod=Server.CreateObject("ADODB.Recordset")
set rsTotScript=Server.CreateObject("ADODB.Recordset")
set rsFactsMOP=Server.CreateObject("ADODB.Recordset")
cnn.Open "dsn=HealthCare;uid=;pwd=;"
'opening connection using System DSN 
	If Err.Number<>0 then
	   ErrorInfo()
	   Response.End 
	End IF
	
periodSql="SELECT DISTINCT(Quarters) FROM Periods WHERE Data_Date in (SELECT Data_date FROM FactsMOP WHERE Product_Group_Code ='"& lProductCode &"')"

rsPeriod.Open periodSql,cnn,1,1
	If Err.Number<>0 then
	   ErrorInfo()
	   Response.End 
	End IF

lCount=rsPeriod.RecordCount
i=0
redim lQuarter(lCount)

while not rsPeriod.EOF 
	lQuarter(i)=rsPeriod.Fields("Quarters").Value 
	i=i+1
	rsPeriod.MoveNext 
wend

%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY BGCOLOR="#e0ffff">
<br><br><br>
<h2 align="center"><font face="Times New Roman" Size="4" color="#ff0000">
		Report</font></h2>
<TABLE align="center" WIDTH="80%" BORDER=1 CELLSPACING=1 CELLPADDING=1>
	<TR>
		<TD width="60%"><font face="Times New Roman" Size="3" color="#ff0000">
		<B><%=lPlanName%></B></font></TD>
		<TD width="20%"><font face="Times New Roman" Size="3" color="#ff0000">
		<B><%=lProductName%></B></font></TD>
	</TR>
</TABLE>

<TABLE align="center" WIDTH="80%" BORDER=1 CELLSPACING=1 CELLPADDING=1>	
	<TR><TD> &nbsp;</TD>
		<%For i=0 to lCount-1 %>
		<TD><font face="Times New Roman" Size="3" color="black">
		<B><%=left(lQuarter(i),6)%></B></font></TD>
		<%Next%>
	</TR>
	<TR>
		<TD><font face="Times New Roman" Size="2" color="#ff0000"><b><%=lPlanName %></b>
		</font></TD>
<%
for i=0 to lCount-1

totscriptSql="SELECT SUM(total_scripts) FROM FactsPLT WHERE product_group_code ='"& lProductCode &"'  AND " _
			 &" payer_plan_code='"& lPlanCode &"' AND Data_date in (SELECT data_date FROM periods " _
			 &" WHERE  quarters='"& lQuarter(i) &"')"
rsTotScript.Open totscriptSql,cnn
	if not(rsTotScript.EOF and rsTotScript.BOF) then 

%>	
		<TD><font face="Times New Roman" Size="3" color="black">
			<%If isnull(rsTotScript.Fields(0)) then %>
					&nbsp;
			<% Else
					Response.Write rsTotScript.Fields(0)
			End If  %></TD>
	
	<%End if%>
	

<%rsTotScript.Close 
next %>
	</TR>
	<TR> <TD><font face="Times New Roman" Size="3" color="#ff0000">
		<B>State (Medicalid)</B></font></TD>

<%for i=0 to lCount-1
	FactsMOPSql="SELECT Medicaid_Total_Scripts  " _
			&" FROM FactsMOP WHERE Product_Group_Code='"& lProductCode &"' AND data_date in " _
			&" (SELECT data_date FROM Periods WHERE quarters='"& lQuarter(i)&"')"

	rsFactsMOP.Open FactsMOPSql,cnn
	if not(rsFactsMOP.BOF and rsFactsMOP.EOF) then 
%> 

	<TD><font face="Times New Roman" Size="3" color="black">
		<%=rsFactsMOP.Fields("Medicaid_Total_Scripts").Value %></font></TD>
 
	<%End if %> 

<% rsFactsMOP.Close 
Next %>
	</TR>
	<TR> <TD><font face="Times New Roman" Size="3" color="#ff0000"><B>State (3rdParty)</B></font></TD>

<%for i=0 to lCount-1
	FactsMOPSql="SELECT Thd_Pty_Total_Scripts  " _
			&" FROM FactsMOP WHERE Product_Group_Code='"& lProductCode &"' AND data_date in " _
			&" (SELECT data_date FROM Periods WHERE quarters='"& lQuarter(i)&"')"

	rsFactsMOP.Open FactsMOPSql,cnn
	if not(rsFactsMOP.BOF and rsFactsMOP.EOF) then  %> 

		 <TD><font face="Times New Roman" Size="3" color="black">
			<%=rsFactsMOP.Fields("Thd_Pty_Total_Scripts").Value %></font></TD>
 
	<%End if %> 

<% rsFactsMOP.Close 
Next %>
	</TR>

	<TR> <TD><font face="Times New Roman" Size="3" color="#ff0000"><B>State (Cash)</B></font></TD>

<%for i=0 to lCount-1
	FactsMOPSql="SELECT Cash_Total_Scripts  " _
			&" FROM FactsMOP WHERE Product_Group_Code='"& lProductCode &"' AND data_date in " _
			&" (SELECT data_date FROM Periods WHERE quarters='"& lQuarter(i)&"')"

	rsFactsMOP.Open FactsMOPSql,cnn
	if not(rsFactsMOP.BOF and rsFactsMOP.EOF) then  %> 

		<TD><font face="Times New Roman" Size="3" color="black">
		<%=rsFactsMOP.Fields("Cash_Total_Scripts").Value %></font></TD>
	<%End if %> 

<% rsFactsMOP.Close 
Next %>
	</TR>

</TABLE>
<p align="center"><A href="SelPlan.asp"><font face="Times New Roman" Size="3" color="black">
		Back </A>to Selection Page</font></p>
</BODY>
</HTML>

<%
set cnn=Nothing
set rsPeriod=Nothing
set rsTotScript=Nothing
set rsFactsMOP=Nothing
%>

<% Sub ErrorInfo()%>
<br><br><br>
<TABLE align="center" WIDTH="80%" BORDER=1 CELLSPACING=1 CELLPADDING=1>
	<TR>
	<TD align="center"><font face="Times New Roman" Size="4" color="#ff0000">
	Internal Error. Please Try again !..</font></TD></TR>
	<TR><TD><p align="center"><A href="SelPlan.asp"><font face="Times New Roman" Size="3" color="black">
		Back </A>to Selection Page</font></p></TD>
	</TR>
<%End Sub%>