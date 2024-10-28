<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<% 
	' Declarations	
	' Form varaibles
	Dim lprod
	Dim lplan
	
	Dim count1
	Dim lquarter
	
	Dim lplayer_plan_code
	Dim lprod_group_code
%>
<!-- #include File="sa-header.asp" -->
<BODY>
<TABLE align="center" width=100%>
<TR>
	<TD align="center">
		<B>Product and Plan View</B>
	</TD>
</TR>
</TABLE>
<BR>
<%
	' Get db connection
	GetDBConnection()

	' Get the form variables
	lprod = Request.Form("cbProduct")
	lplan = Request.Form("cbPlan")
	
	' Get the Payer_Plan_Code from plan name
	sql_str = "Select Payer_Plan_Code From Plans Where Plan_Name = " & "'" & lplan & "'"
	Set rs = Server.CreateObject("ADODB.RecordSet")
	Set rs = db_cnn.Execute(sql_str)
	lpayer_plan_code = rs("Payer_Plan_Code")
	Set rs = Nothing

	' Get the Product_Group_Code from product name
	sql_str = "Select Product_Group_Code From ProdGrp Where Product_Group_Name = " & "'" & lprod & "'"
	Set rs = Server.CreateObject("ADODB.RecordSet")
	Set rs = db_cnn.Execute(sql_str)
	lprod_group_code = rs("Product_Group_Code")
	Set rs = Nothing

	' Get the quarters for the corresponding product
	GetQuarters()

	' Display the table header
	Response.Write("<TABLE bgcolor=yellow width=100% align=center>")
	Response.Write("<TR>")
	Response.Write("<TD align=left>" & lplan & "</TD>")
	Response.Write("<TD align=right>" & lprod & "&nbsp;&nbsp;&nbsp<B>Total Scripts</B></TD>")
	Response.Write("</TR>")
	Response.Write("</TABLE")	
	Response.Write("<BR>")
	Response.Write("<TABLE border=1 width=100% align=center>")	
	Response.Write("<TR>")
	Response.Write("<TD width=450>&nbsp</TD>") 
	For count1 = 0 to lrec_count - 1
		Response.Write("<TD bgcolor=green><B>" & left(rs_prd.Fields(0), 6) & "</B></TD>")
		rs_prd.MoveNext()
	Next 
		
	' Total scripts
	DisplayTotalScripts()			
	
	' Medicaid Total scripts
	DisplayMedicaidTotalScripts()			

	' 3rd Party Total scripts
	DisplayThirdPartyTotalScripts()
	
	' Cash Total scripts
	DisplayCashTotalScripts()

	Response.Write("</TABLE>")
%>
<P>&nbsp;</P>
</BODY>
</HTML>
