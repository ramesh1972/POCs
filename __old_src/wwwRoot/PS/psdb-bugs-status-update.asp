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
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<BR>
<%	' Get the employee id and password
	Dim lSBObj 
	Dim lStatusID
	Dim lStatus
	Dim lStatusUpdated
			
	lStatusUpdated = false
	lStatusID = Request.Form ("hStatusID")
	lStatus = Request.Form ("ebStatus")
	
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	lStatusUpdated = lSBObj.UpdateStatus  (eval(lStatusID), lStatus)
	
	if lStatusUpdated Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Status Successfully Updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'> 
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to Categories management start page.</TD>
		</TR>
		</TABLE>	
	<%	else
%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Status was not Updated</font></TD>
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