<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title></title>
<LINK REL=StyleSheet HREF="theme.css">
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR><br><br>
<%	' Get the employee id and password
	Dim lTSObj 
	Dim lGroupID
	Dim lGroupUsersList
	Dim lGroupUsersRemoved
		
	lGroupUsersRemoved = false
	lGroupUsersList = Request.Form ("hRemovedUsers")
	lGroupID = Request.Form ("hGroupID")
	
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lGroupUsersRemoved = lTSObj.DeleteGroupUsers (eval(lGroupID), lGroupUsersList)
	
	if lGroupUsersRemoved Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Users Successfully Removed From Group</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to Group management start page.</TD>
		</TR>
		</TABLE>	
	<%	else%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Deletion Of Users From Group Failed</font></TD>
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
</body>
</html>
