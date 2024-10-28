<%@ Language=VBScript %>
<% Response.Buffer=true %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>Login</title>
<LINK REL=StyleSheet HREF="theme.css" >
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivProjects.style.background = "lightblue";
</script>
<BR>
<%	' Get the employee id and password
	Dim lTSObj 
	Dim lProjectName
	Dim lProjectDesc
	Dim lAdded
		
	lAdded = false
	lProjectName = Request.Form ("ebProjectName")
	lProjectDesc = Request.Form("taProjectDescription")
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lAdded = lTSObj.InsertProject (lProjectName, lProjectDesc)
	
	if lAdded Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Project Successfully Added</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-projects-start.asp">Click here</A> to go to Projects start page.</TD>
		</TR>
		</TABLE>	
	<%else%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Addition of Project Failed</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-projects-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
	<% end if
	
		Set lTSObj = Nothing
	 %>
</body>
</html>
