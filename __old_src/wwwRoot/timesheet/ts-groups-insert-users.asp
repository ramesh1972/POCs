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
	Dim lGroupID
	Dim lGroupUsersList
	Dim lGroupUsersAdded
		
	lGroupUsersAdded = false
	lGroupUsersList = Request.Form ("hAddedUsers")
	lGroupID = Request.Form ("hGroupID")
		
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	lGroupUsersAdded = lTSObj.InsertGroupUsers (eval(lGroupID), lGroupUsersList)
	
	if lGroupUsersAdded Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Users Successfully Added to Group</font></TD>
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
			<TD><font class="whiteboldtext">Addition Of Users to Group Failed</font></TD>
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
