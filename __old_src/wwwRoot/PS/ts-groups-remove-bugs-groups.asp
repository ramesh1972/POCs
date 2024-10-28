<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title></title>
<LINK REL=StyleSheet HREF="theme.css">
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivGroups.style.background = "lightblue";
</script>
<BR>
<%	' Get the employee id and password
	Dim lTSObj 
	Dim lBugsGroupsList
	Dim lBugsGroupsRemoved
		
	lBugsGroupsRemoved = false
	lBugsGroupsList = Request.Form ("hRemovedGroups")
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lBugsGroupsRemoved = lTSObj.DeleteBugsGroups  (lBugsGroupsList)
	
	if lBugsGroupsRemoved Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Groups Successfully Removed From Software Bugs Domain</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-groups-start.asp">Click here</A> to go to Group management start page.</TD>
		</TR>
		</TABLE>	
	<%	else%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Deletion Of Groups From Software BugsDomain Failed</font></TD>
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
</body>
</html>
