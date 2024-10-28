<%@ Language=VBScript %>
<% Option Explicit
	Dim first_name 
	Dim last_name
	Dim dob
	Dim address1
	Dim address2
	Dim address3
	Dim telephone
	Dim fax
	
	Dim server_obj
	Dim sql_str
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<% first_name = Request.Form("ebFirstName") 
   last_name = Request.Form("ebLastName") 	
   dob = Request.Form("dtpDOB")
   address1 = Request.Form("ebAddress1")
   address2 = Request.Form("ebAddress2")   
   address3 = Request.Form("ebAddress3")
   telephone = Request.Form("ebTelephone")
   fax = Request.Form("ebFAX")
	
	Set server_obj = Server.CreateObject("ADODB.Connection")
	server_obj.Open "COYDB", "sa"
	
	
	sql_str = "Insert into Employee (Emp_First_Name, Emp_Last_Name, Emp_Date_Of_Birth, Emp_Address1, Emp_Address2, Emp_Address3, Emp_Telephone, Emp_FaxNo) VALUES ( '" & _
				first_name & "'" _
				& ",'" & last_name & "'" _
				& ",'" & dob & "'" _				
				& ",'" & address1 & "'" _
				& ",'" & address2 & "'" _
				& ",'" & address3 & "'" _
				& ",'" & telephone & "'" _
				& ",'" & fax & "'" & ")"					
				
	server_obj.Execute sql_str
	
%>

The data has been successfully inserted into the database. <BR> Click <A href = "employee-create-form.asp">here </A> <BR>
to go to the employee creation page.<BR>Click <A href = "employee-view.asp">here </A> <BR>
to view employee info.<BR>  

</BODY>
</HTML>
