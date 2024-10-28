<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-problem-query.asp								  *
	'* Purpose		:	Query page for problems								  *
	'* Prepared by	:	Ramesh Viswanathan								      *	
	'* Date			:	20.10.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	   	  *
	'*	1		   20.10.2001		Ramesh Viswanathan    First Baseline	  *
	'*																		  *
	'**************************************************************************
%>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies ("BugsGroupID")
	if lBugsGroupID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<% ' QueryString
	Dim lChartType
	
	lChartType = ""
	lChartType = Request.Form("rChartType")
	if lChartType = "" Then 
		lChartType = "Pie"
	end if 
%>
<% ' Create the colors array
	Dim lColors(23)
	
	lColors(0) = "red"
	lColors(1) = "green"
	lColors(2) = "blue"
	lColors(3) = "yellow"
	lColors(4) = "purple"
	lColors(5) = "cyan"
	lColors(6) = "gray"
	lColors(7) = "black"
	lColors(8) = "lightred"
	lColors(9) = "lightgreen"
	lColors(10) = "lightblue"
	lColors(11) = "lightyellow"
	lColors(12) = "lightpurple"
	lColors(13) = "lightcyan"
	lColors(14) = "lightgray"
	lColors(15) = "lightblack"
	lColors(16) = "darkred"
	lColors(17) = "darkgreen"
	lColors(18) = "darkblue"
	lColors(19) = "darkyellow"
	lColors(20) = "darkpurple"
	lColors(21) = "darkcyan"
	lColors(22) = "darkwhite"
	lColors(23) = "darkgray"
%>
<% 
	Dim lSBObj
	Dim lTSObj 
	Dim lRs
	Dim lCategory
	
	lCategory = Request.Form("hCategory")
%>

<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../timesheet/theme.css">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivChartSel.style.background = "lightblue";
</script>
<%
	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lRs = Server.CreateObject("ADODB.Recordset")
%>
<BR><BR>
<FORM ACTION = "psdb-bugs-chart-view.asp" method="post" name="frmChartQuery">
<TABLE width=50% align="center" STYLE="BORDER-COLLAPSE: collapse">
<TR>
<%
	If lCategory = "ReportedBy" Then
%>
		<TD align="Center"><B>Reported By<B></TD>
<%
	elseIf lCategory = "Responsibility" Then
%>
		<TD align="Center"><B>Responsibility<B></TD>
<%
	elseIf lCategory = "FixedBy" Then
%>
		<TD align="Center"><B>Fixed By<B></TD>
<%
	elseIf lCategory = "VerifiedBy" Then
%>
		<TD align="Center"><B>Verified By<B></TD>
<%
	elseIf lCategory = "Module" Then
%>
		<TD align="Center"><B>Modules<B></TD>
<%
	elseIf lCategory = "Status" Then
%>
		<TD align="Center"><B>Status<B></TD>
<%
	elseIf lCategory = "Priority" Then
%>
		<TD align="Center"><B>Priority<B></TD>
<%
	elseIf lCategory = "Severity" Then
%>
		<TD align="Center"><B>Severity<B></TD>
<%
	end if		
%>
</TR>
</TABLE>

<%
	Dim lIdx
	Dim lSelRepBy
	Dim lRepBy
	Dim lRepByCount
	Dim lSql
	Dim lCountRs
	Dim lTempRs
	Dim lTempName
	Dim lCount
	Dim lXAxis
	Dim lYAxis
	Dim lTableWidth
	Dim lTableHeight		
	Dim lTableTRStr
	Dim lMaxCount
	Dim lMinCount
	Dim lStep
	
	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	Set lTempRs = Server.CreateObject ("ADODB.RecordSet")	
	lIdx = 0	
	lRepByCount = 0
	lTableTRStr = ""
	
	If lCategory = "ReportedBy" Then
		Set lRs = lTSObj.GetGroupUsers (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lRepBy = Request.Form("cbReportedBy" & trim(lRs("U_Employee_ID")))
				if lRepBy = "on" Then
					lRepByCount = lRepByCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelRepBy(lRepByCount)

			lTableTRStr = ""			
			lRs.MoveFirst 
			While not lRs.EOF
				lRepBy = Request.Form("cbReportedBy" & trim(lRs("U_Employee_ID")))
				if lRepBy = "on" Then
					lSelRepBy(lIdx) = eval(lRs("U_Employee_ID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("U_Employee_ID")) & "</TD><TD>" & trim(lRs("U_Name")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if

		' Loop through selected checkboxes
		lXAxis = ""
		lYAxis = ""
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		for lIdx = 0 to lRepByCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where BR_ReportedBy = " & lSelRepBy(lIdx)
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				Set lTempRs = lTSObj.GetUserProfile(eval(lSelRepBy(lIdx)))
				if lTempRs.RecordCount > 0 Then lTempName = Trim(lTempRs("U_Name"))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelRepBy(lIdx) & ","
			end if
			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","
			
			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next

		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lRepByCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1
%>

<% 
		if lChartType = "Bar" Then
%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Employee ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD>
				<TABLE border=1 width=100% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=100% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=35%><B>Employee ID</B></TD><TD width=65%><B>Employee Name</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then 
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();"></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if

	Dim lSelResp
	Dim lResp
	Dim lRespCount

	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	lIdx = 0	
	lRespCount = 0

	If lCategory = "Responsibility" Then
		Set lRs = lTSObj.GetGroupUsers (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lResp = Request.Form("cbResponsibility" & trim(lRs("U_Employee_ID")))
				if lResp = "on" Then
					lRespCount = lRespCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelResp(lRespCount)

			lTableTRStr = ""
			lRs.MoveFirst 
			While not lRs.EOF
				lResp = Request.Form("cbResponsibility" & trim(lRs("U_Employee_ID")))
				if lResp = "on" Then
					lSelResp(lIdx) = eval(lRs("U_Employee_ID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("U_Employee_ID")) & "</TD><TD>" & trim(lRs("U_Name")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if
		
		' Loop through selected checkboxes
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		lXAxis = ""
		lYAxis = ""
		for lIdx = 0 to lRespCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where BR_Responsibility = " & lSelResp(lIdx)
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				Set lTempRs = lTSObj.GetUserProfile(eval(lSelResp(lIdx)))
				if lTempRs.RecordCount > 0 Then lTempName = Trim(lTempRs("U_Name"))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelResp(lIdx) & ","
			end if

			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","

			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next


		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lRespCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1
%>

	<% 
		if lChartType = "Bar" Then
	%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable2">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Employee ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD>
				<TABLE border=1 width=100% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=100% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=35%><B>Employee ID</B></TD><TD width=65%><B>Employee Name</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button2 name=button2></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if
	
	' Fixed By
	Dim lSelFixBy
	Dim lFixBy
	Dim lFixByCount

	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	lIdx = 0	
	lFixByCount = 0

	If lCategory = "FixedBy" Then
		Set lRs = lTSObj.GetGroupUsers (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lFixBy = Request.Form("cbFixedBy" & trim(lRs("U_Employee_ID")))
				if lFixBy = "on" Then
					lFixByCount = lFixByCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelFixBy(lFixByCount)

			lTableTRStr = ""
			lRs.MoveFirst 
			While not lRs.EOF
				lFixBy = Request.Form("cbFixedBy" & trim(lRs("U_Employee_ID")))
				if lFixBy = "on" Then
					lSelFixBy(lIdx) = eval(lRs("U_Employee_ID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("U_Employee_ID")) & "</TD><TD>" & trim(lRs("U_Name")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if
		
		' Loop through selected checkboxes
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		lXAxis = ""
		lYAxis = ""
		for lIdx = 0 to lFixByCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where BR_FixedBy = " & lSelFixBy(lIdx)
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				Set lTempRs = lTSObj.GetUserProfile(eval(lSelFixBy(lIdx)))
				if lTempRs.RecordCount > 0 Then lTempName = Trim(lTempRs("U_Name"))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelFixBy(lIdx) & ","
			end if

			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","

			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next

		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lFixByCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1
%>

	<% 
		if lChartType = "Bar" Then
	%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Employee ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>					
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD>
				<TABLE border=1 width=100% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=100% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=35%><B>Employee ID</B></TD><TD width=65%><B>Employee Name</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button3 name=button3></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if

	' Verified By
	Dim lSelVerBy
	Dim lVerBy
	Dim lVerByCount

	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	lIdx = 0	
	lVerByCount = 0

	If lCategory = "VerifiedBy" Then
		Set lRs = lTSObj.GetGroupUsers (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lVerBy = Request.Form("cbVerifiedBy" & trim(lRs("U_Employee_ID")))
				if lVerBy = "on" Then
					lVerByCount = lVerByCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelVerBy(lVerByCount)

			lTableTRStr = ""
			lRs.MoveFirst 
			While not lRs.EOF
				lVerBy = Request.Form("cbVerifiedBy" & trim(lRs("U_Employee_ID")))
				if lVerBy = "on" Then
					lSelVerBy(lIdx) = eval(lRs("U_Employee_ID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("U_Employee_ID")) & "</TD><TD>" & trim(lRs("U_Name")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if
		
		' Loop through selected checkboxes
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		lXAxis = ""
		lYAxis = ""
		for lIdx = 0 to lVerByCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where BR_VerifiedBy = " & lSelVerBy(lIdx)
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				Set lTempRs = lTSObj.GetUserProfile(eval(lSelVerBy(lIdx)))
				if lTempRs.RecordCount > 0 Then lTempName = Trim(lTempRs("U_Name"))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelVerBy(lIdx) & ","
			end if

			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","

			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next

		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lVerByCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1
%>

	<% 
		if lChartType = "Bar" Then
	%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Employee ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD>
				<TABLE border=1 width=100% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=100% align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=35%><B>Employee ID</B></TD><TD width=65%><B>Employee Name</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button3 name=button3></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if

	' create the userid string
	Dim lUsersRs
	Dim lUserIDString
		
	lUserIDString = ""
		
	Set lUsersRs = Server.CreateObject("ADODB.RecordSet")
	Set lUsersRs = lTSObj.GetGroupUsers(eval(lBugsGroupID))

	If lUsersRs.RecordCount > 0 Then
	    While Not lUsersRs.EOF
	        lUserIDString = lUserIDString & lUsersRs("U_Employee_ID") & ","
	        lUsersRs.MoveNext
	    Wend
		    
	    lUserIDString = Left(lUserIDString, Len(lUserIDString) - 1)
	End If
		 
	' Module
	Dim lSelModule
	Dim lModule
	Dim lModuleCount

	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	lIdx = 0	
	lModuleCount = 0

	If lCategory = "Module" Then
		Set lRs = lSBObj.GetProjectModules() 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lModule = Request.Form("cbModules" & trim(lRs("M_ModuleID")))
				if lModule = "on" Then
					lModuleCount = lModuleCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelModule(lModuleCount)

			lTableTRStr = ""
			lRs.MoveFirst 
			While not lRs.EOF
				lModule = Request.Form("cbModules" & trim(lRs("M_ModuleID")))
				if lModule = "on" Then
					lSelModule(lIdx) = eval(lRs("M_ModuleID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("M_ModuleID")) & "</TD><TD>" & trim(lRs("M_ModuleName")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if
		
		' Loop through selected checkboxes
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		lXAxis = ""
		lYAxis = ""
		for lIdx = 0 to lModuleCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where M_ModuleID = " & lSelModule(lIdx) & _
				   " And BR_ReportedBy In (" & lUserIDString & ")"
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				lTempName = lSBObj.GetModuleName (eval(lSelModule(lIdx)))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelModule(lIdx) & ","
			end if

			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","

			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next

		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lModuleCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1
%>

	<% 
		if lChartType = "Bar" Then
	%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Module ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD width=50%>
				<TABLE border=1 width=200 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=200 align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=40%><B>Module ID</B></TD><TD width=60%><B>Module Name</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button3 name=button3></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if

	' Status
	Dim lSelStatus
	Dim lStatus
	Dim lStatusCount

	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	lIdx = 0	
	lStatusCount = 0

	If lCategory = "Status" Then
		Set lRs = lSBObj.GetAllBugsStatus () 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lStatus = Request.Form("cbStatus" & trim(lRs("S_StatusID")))
				if lStatus = "on" Then
					lStatusCount = lStatusCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelStatus(lStatusCount)

			lTableTRStr = ""
			lRs.MoveFirst 
			While not lRs.EOF
				lStatus = Request.Form("cbStatus" & trim(lRs("S_StatusID")))
				if lStatus = "on" Then
					lSelStatus(lIdx) = eval(lRs("S_StatusID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("S_StatusID")) & "</TD><TD>" & trim(lRs("S_Status")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if
		
		' Loop through selected checkboxes
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		lXAxis = ""
		lYAxis = ""
		for lIdx = 0 to lStatusCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where S_StatusID = " & lSelStatus(lIdx) & _
				   " And BR_ReportedBy In (" & lUserIDString & ")"
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				lTempName = lSBObj.GetStatusName(eval(lSelStatus(lIdx)))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelStatus(lIdx) & ","
			end if

			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","

			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next

		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lStatusCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1		
%>
	<% 
		if lChartType = "Bar" Then
	%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Status ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD width=50%>
				<TABLE border=1 width=200 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=200 align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=40%><B>Status ID</B></TD><TD width=60%><B>Status</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button3 name=button3></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if

	' Priority
	Dim lSelPriority
	Dim lPriority
	Dim lPriorityCount

	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	lIdx = 0	
	lPriorityCount = 0

	If lCategory = "Priority" Then
		Set lRs = lSBObj.GetAllBugsPriority () 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lPriority = Request.Form("cbPriority" & trim(lRs("P_PriorityID")))
				if lPriority = "on" Then
					lPriorityCount = lPriorityCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelPriority(lPriorityCount)

			lTableTRStr = ""
			lRs.MoveFirst 
			While not lRs.EOF
				lPriority = Request.Form("cbPriority" & trim(lRs("P_PriorityID")))
				if lPriority = "on" Then
					lSelPriority(lIdx) = eval(lRs("P_PriorityID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("P_PriorityID")) & "</TD><TD>" & trim(lRs("P_Priority")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if
		
		' Loop through selected checkboxes
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		lXAxis = ""
		lYAxis = ""
		for lIdx = 0 to lPriorityCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where P_PriorityID = " & lSelPriority(lIdx) & _
				   " And BR_ReportedBy In (" & lUserIDString & ")"
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				lTempName = lSBObj.GetPriority (eval(lSelPriority(lIdx)))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelPriority(lIdx) & ","
			end if

			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","

			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next

		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lPriorityCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1		
%>

	<% 
		if lChartType = "Bar" Then
	%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Priority ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD width=50%>
				<TABLE border=1 width=250 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=250 align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=35%><B>Priority ID</B></TD><TD width=65%><B>Priority</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then  
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button3 name=button3></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if

	' Severity
	Dim lSelSeverity
	Dim lSeverity
	Dim lSeverityCount

	Set lCountRs = Server.CreateObject ("ADODB.RecordSet")
	lIdx = 0	
	lSeverityCount = 0

	If lCategory = "Severity" Then
		Set lRs = lSBObj.GetAllBugsSeverity () 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lSeverity = Request.Form("cbSeverity" & trim(lRs("S_SeverityID")))
				if lSeverity = "on" Then
					lSeverityCount = lSeverityCount + 1
				end if	
				lRs.MoveNext 
			wend

			ReDim lSelSeverity(lSeverityCount)

			lTableTRStr = ""
			lRs.MoveFirst 
			While not lRs.EOF
				lSeverity = Request.Form("cbSeverity" & trim(lRs("S_SeverityID")))
				if lSeverity = "on" Then
					lSelSeverity(lIdx) = eval(lRs("S_SeverityID"))
					lTableTRStr = lTableTRStr & "<TR><TD>" & trim(lRs("S_SeverityID")) & "</TD><TD>" & trim(lRs("S_Severity")) & "</TD></TR>"					
					lIdx = lIdx + 1					
				end if	
				lRs.MoveNext 
			wend
		end if
		
		' Loop through selected checkboxes
		lMaxCount = 0
		lMinCount = 0
		lStep = 0
		lXAxis = ""
		lYAxis = ""
		for lIdx = 0 to lSeverityCount - 1
			' create the sql string for getting the count and execute
			lSql = "Select count(*) From PS_Reports Where S_SeverityID = " & lSelSeverity(lIdx) & _
				   " And BR_ReportedBy In (" & lUserIDString & ")"
			Set lCountRs = lSBObj.ExecSQLRetRs (lSql)
			if (lCountRs.RecordCount > 0) Then
				lCount = eval(lCountRs(0))
			else 
				lCount = 0
			end if
			
			if lChartType = "Pie" Then
				lTempName = "Unknown"
				lTempName = lSBObj.GetSeverity (eval(lSelSeverity(lIdx)))
				lXAxis = lXAxis & lTempName & " (" & lCount & "),"
			else
				lXAxis = lXAxis & lSelSeverity(lIdx) & ","
			end if

			lColorStr = lColorStr & lColors(lIdx Mod 23) & ","

			' create the y-axis string based on the counts
			lYAxis = lYAxis & lCount & ","

			' max and min counts
			if lCount > lMaxCount Then
				lMaxCount = lCount
			end if
			
			if lCount < lMinCount Then
				lMinCount = lCount
			end if
		next

		lXAxis = Left(lXAxis, Len(lXAxis)-1)
		lColorStr = Left(lColorStr, Len(lColorStr)-1)
		lYAxis = Left(lYAxis, Len(lYAxis)-1)
	
		lTableWidth = lSeverityCount * 15 + 300
		lStep = Round((lMaxCount-lMinCount)/10, 0) + 1		
%>

	<% 
		if lChartType = "Bar" Then
	%>
			<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD align="right" valign="top" width=20%><font class='tablefooter'>Number Of Bugs</font></TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD valign="top" align="left">
					<TABLE align="center" width=<%=lTableWidth%> STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=<%=lTableWidth%> height=200 VIEWASTEXT id=Applet1>
					<param name=plot value="bar">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					</TD></TR>
					<TR>
					<TD align="center"><font class='tablefooter'>Severity ID</font></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
					</TR>
					</TABLE>
				</TD>
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>				
				<TD width=50%>
				<TABLE border=1 width=200 align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD align="center"><font class="whiteboldtext">Legend</font></TD>
					</TR>
				</TABLE>
				<TABLE border=1 width=200 align="center" class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
					<TR>
						<TD width=40%><B>Severity ID</B></TD><TD width=60%><B>Severity</B></TD>
					</TR>
					<%=lTableTRStr%>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%
		elseif lChartType="Pie" Then
	%>
			<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse">
			<TR>
				<TD valign="top" align="center">
					<TABLE align="center" width=400 STYLE="BORDER-COLLAPSE: collapse" id="oTable1">
					<TR><TD>
					<applet code="Plod.class" width=500 height=400 VIEWASTEXT id=Applet1>
					<param name=plot value="pie">
					<param name=bgcolor value="white">
					<param name=label  value="<%=lXAxis%>">
					<param name=y      value="<%=lYAxis%>">
					<param name=yscale value="min, max, <%=lStep%>">
					<param name=color   value="<%=lColorStr%>">
					</applet>
					
					<TR>
						<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button3 name=button3></TD>
					</TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
	<%	
		end if
	end if
	%>
</FORM>
<BR>
</BODY>
<%
	Set lSBObj = Nothing
	Set lTSObj = Nothing
	Set rst = Nothing
	Set lRs = Nothing
%>
</HTML>
