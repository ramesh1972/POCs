<%@ Language=VBScript %>
<% Option Explicit
	Dim db_conn
	Dim rst
	
	Dim sql_str
%>
	
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%
	Set db_conn = Server.CreateObject("ADODB.Connection")
	db_conn.Open "COYDB", "sa"
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	
	If Request("order_by") = "FirstName" Then
		sql_str = "Select * from Employee order by Emp_First_Name"
	Else
		sql_str = "Select * from Employee"
	End If
	
	Set rst = db_conn.Execute (sql_str)
	
	If Not (rst.EOF And rst.BOF) Then
		Response.Write("<TABLE align=center border=1 bgcolor = green>")
		Response.Write("<TR>")
		Response.Write("<TD align = center><A href = employee-view.asp?order_by=FirstName>First Name</A></TD>")
		Response.Write("<TD align = center>Last Name</TD>")
		Response.Write("<TD align = center>Date Of Birth</TD>")				
		Response.Write("<TD align = center>Address1</TD>")
		Response.Write("<TD align = center>Address2</TD>")		
		Response.Write("<TD align = center>Address3</TD>")								
		Response.Write("<TD align = center>Telephone</TD>")				
		Response.Write("<TD align = center>Fax Number</TD>")				
		Response.Write("</TR>")		
		
		While Not rst.EOF
			Response.Write("<TR bgcolor = wheat> ")
			Response.Write("<TD >")
			If rst("Emp_First_Name") <> "" Then
				Response.Write(rst("Emp_First_Name"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("Emp_Last_Name") <> "" Then
				Response.Write(rst("Emp_Last_Name"))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("Emp_Date_Of_Birth") <> "" Then
				Response.Write(rst("Emp_Date_Of_Birth"))
			Else
				Response.Write("&nbsp")
			End if
			Response.Write("</T>")
			
			Response.Write("<TD>")
			If rst("Emp_Address1") <> "" Then
				Response.Write(rst("Emp_Address1"))
			Else
				Response.Write("&nbsp")
			End if
			Response.Write("</TD>")

			Response.Write("<TD>")
			If rst("Emp_Address2") <> "" Then
				Response.Write(rst("Emp_Address2"))
			Else
				Response.Write("&nbsp")
			End if
			Response.Write("</TD>")

			Response.Write("<TD >")
			If rst("Emp_Address3") <> "" Then
				Response.Write(rst("Emp_Address3"))
			Else
				Response.Write("&nbsp")
			End if
			Response.Write("</TD>")
			
			Response.Write("<TD >")
			If rst("Emp_Telephone") <> "" Then
				Response.Write(rst("Emp_Telephone"))
			Else
				Response.Write("&nbsp")
			End if
			Response.Write("</TD>")
			
			Response.Write("<TD>")
			If rst("Emp_FaxNo") <> "" Then
				Response.Write(rst("Emp_FaxNo"))
			Else
				Response.Write("&nbsp")
			End if
			Response.Write("</TD>")
			
			Response.Write("</TR>")
			rst.MoveNext
		Wend
		Response.Write("</TABLE>")
	Else
		Response.Write("No data in the database")
	End If
%>

</BODY>
</HTML>
