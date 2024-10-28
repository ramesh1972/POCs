<!-- Header file for health care product and plan view page sa-view.asp -->
<%
	' Declarations
	Dim db_cnn
	Dim sql_str
	Dim rs
	Dim rs_date
	Dim rs_tot_scripts
	Dim sql_str1
	
	Dim count
	
	Dim rs_prd
	Dim lrec_count
%>

<%
Sub GetDBConnection()
	Set db_cnn = Server.CreateObject("ADODB.Connection")
	db_cnn.Open ("hc")
End Sub

Sub GetQuarters()
	' since only FactsMOP table has Data_Date(not FactsPLT), get all the possible quarters from FactsMOP and Periods table
	Set rs_prd = Server.CreateObject("ADODB.RecordSet")
	sql_str = "Select Distinct(Quarters) From Periods Where Data_Date in " & _
			  " (Select Data_Date From FactsMOP Where Product_Group_Code = '" & _
			  lprod_group_code & "')"

	rs_prd.Open sql_str,db_cnn,1,1

	lrec_count = rs_prd.RecordCount
End Sub

' Function to display total scripts
Sub DisplayTotalScripts()

	Response.Write("<TR bgcolor=wheat>")
	Response.Write("<TD width=450>")
	Response.Write(lplan)
	Response.Write("</TD>")
	
	' Move to the first position of the record set
	If Not (rs_prd.EOF And rs_prd.BOF) Then
	rs_prd.MoveFirst()
	
	For count = 0 to  lrec_count - 1
		' For all the dates find the sum of total_scripts from FactsPLT table
		sql_str = "Select Sum(Total_Scripts) From FactsPLT Where " & _
				  "Data_Date in (Select Data_Date From Periods " & _
				  " Where Quarters = '" & rs_prd.Fields(0) & "')" & _
				  " And Payer_Plan_Code = '" & lpayer_plan_code & "'" & _
				  " And Product_Group_Code = '" & lprod_group_code & "'"
		Set rs_tot_scripts = Server.CreateObject("ADODB.RecordSet")
		Set rs_tot_scripts = db_cnn.Execute(sql_str)
		
		If isnull(rs_tot_scripts.Fields(0)) Then
			Response.Write("<TD>0.00</TD>")
		Else
			Response.Write("<TD>" & rs_tot_scripts.Fields(0) & "</TD>")
		End If
		
		rs_prd.MoveNext()
	Next		
	End If
	
	Response.Write("</TR>")	
End Sub

' Function to display Medicaid total scripts
Sub DisplayMedicaidTotalScripts()

	Response.Write("<TR bgcolor=wheat>")
	Response.Write("<TD width=450>")
	Response.Write("State (Medicaid)")
	Response.Write("</TD>")
	
	' Move to the first position of the record set
	If Not (rs_prd.EOF And rs_prd.BOF) Then
	rs_prd.MoveFirst()

	For count = 0 to  lrec_count - 1
		' For all the dates find the sum of total_scripts from FactsMOP table
		sql_str = "Select Sum(Medicaid_Total_Scripts) From FactsMOP Where " & _
				  "Data_Date in (Select Data_Date From Periods " & _
				  " Where Quarters = '" & rs_prd.Fields(0) & "')" & _
				  " And Product_Group_Code = '" & lprod_group_code & "'"
		Set rs_tot_scripts = Server.CreateObject("ADODB.RecordSet")
		Set rs_tot_scripts = db_cnn.Execute(sql_str)
		
		If isnull(rs_tot_scripts.Fields(0)) Then
			Response.Write("<TD>0.00</TD>")
		Else
			Response.Write("<TD>" & rs_tot_scripts.Fields(0) & "</TD>")
		End If
		
		rs_prd.MoveNext()		
	Next		
	End If
	
	Response.Write("</TR>")	
End Sub

' Function to display 3rd Party total scripts
Sub DisplayThirdPartyTotalScripts()

	Response.Write("<TR bgcolor=wheat>")
	Response.Write("<TD width=450>")
	Response.Write("State (3rd Party)")
	Response.Write("</TD>")
	
	' Move to the first position of the record set
	If Not (rs_prd.EOF And rs_prd.BOF) Then
	rs_prd.MoveFirst()
	
	For count = 0 to  lrec_count - 1
		' For all the dates find the sum of total_scripts from FactsPLT table
		sql_str = "Select Sum(Thd_Pty_Total_Scripts) From FactsMOP Where " & _
				  "Data_Date in (Select Data_Date From Periods " & _
				  " Where Quarters = '" & rs_prd.Fields(0) & "')" & _
				  " And Product_Group_Code = '" & lprod_group_code & "'"
		Set rs_tot_scripts = Server.CreateObject("ADODB.RecordSet")
		Set rs_tot_scripts = db_cnn.Execute(sql_str)
		
		If isnull(rs_tot_scripts.Fields(0)) Then
			Response.Write("<TD>0.00</TD>")
		Else
			Response.Write("<TD>" & rs_tot_scripts.Fields(0) & "</TD>")
		End If
		
		rs_prd.MoveNext()
	Next		
	End If
		
	Response.Write("</TR>")	
End Sub

' Function to display Cash total scripts
Sub DisplayCashTotalScripts()

	Response.Write("<TR bgcolor=wheat>")
	Response.Write("<TD width=450>")
	Response.Write("State (Cash)")
	Response.Write("</TD>")
	
	
	' Move to the first position of the record set
	If Not (rs_prd.EOF And rs_prd.BOF) Then
	rs_prd.MoveFirst()
	
	For count = 0 to  lrec_count - 1
		' For all the dates find the sum of total_scripts from FactsPLT table
		sql_str = "Select Sum(Cash_Total_Scripts) From FactsMOP Where " & _
				  "Data_Date in (Select Data_Date From Periods " & _
				  " Where Quarters = '" & rs_prd.Fields(0) & "')" & _
				  " And Product_Group_Code = '" & lprod_group_code & "'"
		Set rs_tot_scripts = Server.CreateObject("ADODB.RecordSet")
		Set rs_tot_scripts = db_cnn.Execute(sql_str)
		
		If isnull(rs_tot_scripts.Fields(0)) Then
			Response.Write("<TD>0.00</TD>")
		Else
			Response.Write("<TD>" & rs_tot_scripts.Fields(0) & "</TD>")
		End If
		
		rs_prd.MoveNext()
	Next		
	End If
		
	Response.Write("</TR>")
End Sub
%>

