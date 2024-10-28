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
	Dim lTSObj 
	Dim lGroupName
	Dim lGroupDescription
	Dim lGroupLeader
	Dim lGroupAdded
		
	lGroupAdded = false
	lGroupName = Request.Form ("ebGroupName")
	lGroupDescription = Request.Form("ebGroupDesc")
	lGroupLeader = Request.Form ("sUsers")      
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lGroupAdded = lTSObj.InsertGroup (lGroupName, lGroupDescription, eval(lGroupLeader))
	
	if lGroupAdded Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Project Successfully Added</font></TD>
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
			<TD><font class="whiteboldtext">Project Addition Failed</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to try again</TD>
		</TR>
		</TABLE>	
<% end if 
	
	Set lTSObj = Nothing
%>
</bo dy>
</html>
