<%@ Language=VBScript %>
<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-edit-problem.asp								  *
	'* Purpose		:	On this form you can edit a bug						  *
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
<% 
	Dim rst
	Dim lRs
	
	Dim id
	Dim rec
	
	Dim lSBObj
	Dim lTSObj
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../timesheet/theme.css">
<TITLE></TITLE>
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivUpdateSel.style.background = "lightblue";
</script>
<BR>
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
	Set lSBObj = Server.CreateObject("Bugs.clsSoftwareBugs")
	Set lTSObj = Server.CreateObject("TimeSheet.clsTimeSheet")	
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	Set rec = Server.CreateObject("ADODB.Recordset") 
	
	id = Request("Identifier")
	Set rst = lTSObj.GetUserDetails("") 
 	Set rec = lSBObj.ViewProblem (eval(id))
%>
<FORM ACTION = "psdb-bugs-update-edit.asp" method="post">
<TABLE border=1 width=80% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="10%" align="left"><B>Step</B> 4</TD>
	<TD width="90%" align="left"><font class="whiteboldtext">Edit Bug Details</font></TD>
</TR>
</TABLE>
<TABLE align="center" border=1 width=80% class="tdbglight" STYLE="BORDER-COLLAPSE: collapse">
  <TR>
    <TD align="right"><B>Identifier</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=id%></TD>
  </TR>

  <TR>
<%
	Dim lSelectStr
	
	lSelectStr = "<SELECT name='sModules'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetProjectModules ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("M_ModuleID")) = trim(rec("M_ModuleID")) Then
				lSelectStr = lSelectStr & "<Option Value='" & lRs("M_ModuleID") & "' selected>" & lRs("M_ModuleName") & "</Option>"		
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("M_ModuleID") & "'>" & lRs("M_ModuleName") & "</Option>"
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Module</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
    <TD align="right"><B>Bug Title</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><INPUT READONLY=true name="ebTitle" value=<% Response.Write(trim(rec("BR_ShortDescription")))%>></TD>
  </TR>
  <TR>
    <TD align="right" valign="top"><B>Problem Description</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50% align=left><TEXTAREA cols=40 rows=8 name="taDescription"><%Response.Write(trim(rec("BR_LongDescription")))%> </TEXTAREA></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsStatus'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetAllBugsStatus ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("S_StatusID")) = trim(rec("S_StatusID")) Then
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_StatusID") & "' selected>" & lRs("S_Status") & "</Option>"
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_StatusID") & "'>" & lRs("S_Status") & "</Option>"
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Status</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsPriority'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetAllBugsPriority  ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("P_PriorityID")) = trim(rec("P_PriorityID")) Then		
				lSelectStr = lSelectStr & "<Option Value='" & lRs("P_PriorityID") & "' selected>" & lRs("P_Priority") & "</Option>"
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("P_PriorityID") & "'>" & lRs("P_Priority") & "</Option>"				
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Priority</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>
  </TR>

  <TR>
<%
	lSelectStr = "<SELECT name='sBugsSeverity'><Option Value='0'>None</Option>"
	Set lRs = lSBObj.GetAllBugsSeverity   ()
	If lRs.RecordCount > 0 Then
		lRs.MoveFirst 
		While not lRs.EOF
			if trim(lRs("S_SeverityID")) = trim(rec("S_SeverityID")) Then				
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_SeverityID") & "' selected>" & lRs("S_Severity") & "</Option>"
			else
				lSelectStr = lSelectStr & "<Option Value='" & lRs("S_SeverityID") & "'>" & lRs("S_Severity") & "</Option>"			
			end if
			lRs.MoveNext 
		wend
	end if
	lSelectStr = lSelectStr & "</Select>"
%>
    <TD align="right"><B>Severity</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>

  <TR>
    <% 
		lSelectStr = "<SELECT name='sReportedBy'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_ReportedBy")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
  
    <TD align="right"><B>Reported By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  
  <TR>
    <TD align="right"><B>Reported Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% =rec("BR_ReportedDate")%></TD>
  </TR>

  <TR>
    <% 
		lSelectStr = "<SELECT name='sResponsibility'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_Responsibility")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
  
    <TD align="right"><B>Responsibility</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  <TR>
    <% 
		lSelectStr = "<SELECT name='sFixedBy'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_FixedBy")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
    <TD align="right"><B>Fixed By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  
  <TR>
    <TD align="right"><B>Fixed Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% =rec("BR_FixedDate")%></TD>
  </TR>

  <TR>
    <% 
		lSelectStr = "<SELECT name='sVerifiedBy'><Option Value='0'>None</Option>"			
		if rst.RecordCount > 0 Then
			rst.MoveFirst
			While Not rst.EOF 
				if trim(rec("BR_VerifiedBy")) = trim(rst("U_Employee_ID")) Then
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & " selected>" & rst("U_Name") & "</OPTION>"
				Else
					lSelectStr = lSelectStr & "<OPTION Value = " & rst("U_Employee_ID") & ">" & rst("U_Name") & "</OPTION>"
				End If
				rst.MoveNext
			Wend
		end if
		lSelectStr = lSelectStr & "</SELECT>"
    %>
    <TD align="right"><B>Verified By</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><%=lSelectStr%></TD>  
  </TR>
  <TR>
    <TD align="right"><B>Verified Date</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD width=50%><% =rec("BR_VerifiedDate")%></TD>
  </TR>

  <INPUT type="hidden" name="hIdentifier" value = <%=id%>>
  </TABLE>
<BR>
	<TABLE width=80% align="center" STYLE="BORDER-COLLAPSE: collapse">
	<TR>
		<TD align="center"><INPUT type="submit" Value="Update Bug" style='BACKGROUND-COLOR: aqua'>
		<INPUT type="submit" Value="View Bugs" style='BACKGROUND-COLOR: aqua' onclick="history.back();"></TD>		
	</TR>
	</TABLE>
</FORM>
<BR>
</BODY>
</HTML>
