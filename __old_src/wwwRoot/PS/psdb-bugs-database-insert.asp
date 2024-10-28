<%@ Language=VBScript %>
<% Response.Buffer=true %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR><br><br>
<%	' Get the employee id and password
	Dim lBugsObj 
	Dim lProjectID
	Dim lDatabaseName
	Dim lDatabaseDescription
	Dim lDatabaseAdded
		
	lDatabaseAdded = false
	lProjectID = Request.Form("hProjectID")
	lDatabaseName = Request.Form ("ebBDName")
	lDatabaseDescription = Request.Form("ebBDDesc")
	
	Set lBugsObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	lDatabaseAdded = lBugsObj.InsertBugsDatabase(eval(lProjectID), lDatabaseName, lDatabaseDescription)
	
	if lDatabaseAdded Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Bugs Database Successfully Added</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'> 
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to Bugs Database management start page.</TD>
		</TR>
		</TABLE>	
	<%	else
%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Bugs Database Addition Failed</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to try again.</TD>
		</TR>
		</TABLE>	
<% end if 
	
	Set lTSObj = Nothing
%>
</body>
</html>
