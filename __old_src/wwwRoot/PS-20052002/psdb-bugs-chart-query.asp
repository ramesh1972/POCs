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
<% 
	Dim lSBObj
	Dim lTSObj 
	Dim lRs
	Dim lCheckStr	
	Dim lCategory
	
	lCategory = Request.Form("rCategory")
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
<input type="hidden" name="hCategory" value="<%=lCategory%>">
<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="15%" align="left"><B>Step</B> 2</TD>
	<TD width="85%" align="left"><font class="whiteboldtext">Select the Type of Chart</font></TD>
</TR>
</TABLE>
<TABLE align="center" border=1 width=50% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD><INPUT type='radio' name='rChartType' value="Bar" checked>Bar</TD>
	<TD><INPUT type='radio' name='rChartType' value="Pie">Pie</TD>
</TR>
</TABLE>
<BR>
<TABLE border=1 width=50% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="15%" align="left"><B>Step</B> 3</TD>
	<TD width="85%" align="left"><font class="whiteboldtext">Select the <%=lCategory%> values to appear in the Chart</font></TD>
</TR>
</TABLE>

<TABLE align="center" border=1 width=50% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
<%
	If lCategory = "ReportedBy" Then
		Set lRs = lTSObj.GetGroupUsers   (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbReportedBy" & lRs("U_Employee_ID") & "' checked>" & lRs("U_Name") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>
<%
	If lCategory = "Responsibility" Then
		Set lRs = lTSObj.GetGroupUsers   (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbResponsibility" & lRs("U_Employee_ID") & "' checked>" & lRs("U_Name") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>
<%
	If lCategory = "Module" Then
		Set lRs = lSBObj.GetProjectModules ()
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbModules" & lRs("M_ModuleID") & "' checked>" & lRs("M_ModuleName") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>
<%
	If lCategory = "Status" Then
		Set lRs = lSBObj.GetAllBugsStatus ()
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbStatus" & lRs("S_StatusID") & "' checked>" & lRs("S_Status") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>
<%
	If lCategory = "Priority" Then
		Set lRs = lSBObj.GetAllBugsPriority ()
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbPriority" & lRs("P_PriorityID") & "' checked>" & lRs("P_Priority") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>
<%
	If lCategory = "Severity" Then
		Set lRs = lSBObj.GetAllBugsSeverity()
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbSeverity" & lRs("S_SeverityID") & "' checked>" & lRs("S_Severity") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>
<%
	If lCategory = "FixedBy" Then
		Set lRs = lTSObj.GetGroupUsers   (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbFixedBy" & lRs("U_Employee_ID") & "' checked>" & lRs("U_Name") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>
<%
	If lCategory = "VerifiedBy" Then
		Set lRs = lTSObj.GetGroupUsers   (eval(lBugsGroupID)) 
		If lRs.RecordCount > 0 Then
			lRs.MoveFirst 
			While not lRs.EOF
				lCheckStr = "<INPUT type='checkbox' name='cbVerifiedBy" & lRs("U_Employee_ID") & "' checked>" & lRs("U_Name") 
				%>
				  <TR>
				    <TD align=left><%=lCheckStr%></TD>
				  </TR>
				<%
				lRs.MoveNext 
			wend
		end if
	end if
%>

</TABLE>
<BR>
<TABLE width=10% align="center" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD align="center"><INPUT type="button" Value="<< Back" style='BACKGROUND-COLOR: aqua' onclick="history.back();" id=button1 name=button1></TD>
	<TD align="center"><INPUT type="submit" Value="View Chart" style='BACKGROUND-COLOR: aqua'></TD>
</TR>
</TABLE>

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
