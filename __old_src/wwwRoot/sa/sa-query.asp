<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<% 
	'Declarations
	Dim db_cnn
	Dim sql_str
	Dim rs_prod
	Dim rs_plan
%>

<%
	' Get connection
	Set db_cnn = Server.CreateObject("ADODB.Connection")
	db_cnn.Open ("hc")
	
	' Create product record set
	sql_str = "Select Distinct(Product_Group_Name) From ProdGrp"
	Set rs_prod = Server.CreateObject("ADODB.RecordSet")
	Set rs_prod = db_cnn.Execute (sql_str)
	
	' Create plan record set
	sql_str = "Select Distinct(Plan_Name) From Plans"
	Set rs_plan = Server.CreateObject("ADODB.RecordSet")
	Set rs_plan = db_cnn.Execute (sql_str)
%>	
</HEAD>
<BODY>
<P>&nbsp;</P>
<TABLE align="center" width=100%>
<TR>
	<TD align="center">
		<B>Product and Plan Query</B>
	</TD>
</TR>
</TABLE>
<FORM name="frmQuery" method="POST" action="sa-view.asp">
<TABLE border=1 align="center" width=600 bgcolor="wheat">
<TR>
	<TD width=300 align="right">
		Plan
	</TD>
	<TD>
		<SELECT name="cbPlan"> 
		<% 
			While Not rs_plan.EOF 
				Response.Write("<OPTION Value = " & "'" & rs_plan("Plan_Name") & "'" & ">" & rs_plan("Plan_Name") & "</OPTION>")
				rs_plan.MoveNext
			Wend
		%>
	</TD>
</TR>
<TR>
	<TD width=300 align="right">
		Product
	</TD>
	<TD>
		<SELECT name="cbProduct"> 
		<% 
			While Not rs_prod.EOF 
				Response.Write("<OPTION Value = " & "'" & rs_prod("Product_Group_Name") & "'" & ">" & rs_prod("Product_Group_Name") & "</OPTION>")
				rs_prod.MoveNext
			Wend
		%>
	</TD>
</TR>
</TABLE>
<BR>
<TABLE align="center" width=600>
<TR>
	<TD align="center">
		<INPUT type="submit" value="Query">
	</TD>
</TR>
</TABLE>
</BODY>
</HTML>
