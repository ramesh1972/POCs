<%@ Language=VBScript %>
<% Response.Buffer=true %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title></title>
<LINK rel="stylesheet" href="theme.css">
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<%
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies ("BugsGroupID")
%>
<%	' Get the employee id and password
	Dim lSBObj 
	Dim lProjectID
	Dim lModule
	Dim lModuleDesc
	Dim lModuleAdded
			
	lModuleAdded = false
	lProjectID = Request.Form("sGroups")
	lModule = Request.Form ("ebModule")
	lModuleDesc = Request.Form ("ebModuleDesc")
	
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	lModuleAdded = lSBObj.InsertModule(eval(lProjectID), lModule, lModuleDesc)
	
	if lModuleAdded Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Module Successfully Added</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'> 
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to Project management start page.</TD>
		</TR>
		</TABLE>	
	<%	else
%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Priority Addition Failed</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to try again</TD>
		</TR>
		</TABLE>	
<% end if 
	
	Set lTSObj = Nothing
%>
</bo dy>
</html>
