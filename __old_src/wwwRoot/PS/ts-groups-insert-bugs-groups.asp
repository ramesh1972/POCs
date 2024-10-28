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
document.all.oDivGroups.style.background = "lightblue";
</script>
<BR>
<%	' Get the employee id and password
	Dim lTSObj 
	Dim lBugsGroupsList
	Dim lBugsGroupsAdded
		
	lBugsGroupsAdded = false
	lBugsGroupsList = Request.Form ("hAddedGroups")
		
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lBugsGroupsAdded = lTSObj.InsertBugsGroups(lBugsGroupsList)
	
	if lBugsGroupsAdded Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Groups Successfully Added to Software Bugs Domain</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-groups-start.asp">Click here</A> to go to Group management start page.</TD>
		</TR>
		</TABLE>	
	<%	else
%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Addition Of Groups to Software Bugs Failed</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-groups-start.asp">Click here</A> to go to try again</TD>
		</TR>
		</TABLE>	
<% end if 

Set lTSObj = Nothing
%>
</bo dy>
</html>
