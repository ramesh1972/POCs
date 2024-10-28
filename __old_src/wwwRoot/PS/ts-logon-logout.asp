<%@ Language=VBScript %>
<% Response.Buffer=true %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>Logout</title>
<LINK REL=StyleSheet HREF="theme.css" >
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<%	' unset the cookies
	Response.Cookies("EmployeeID") = ""
	Response.Cookies("BugsProjectID") = ""	
	Response.Cookies("BugsDatabaseID") = ""	
%>
<!-- #include file="psdb-header.asp" -->
<BR><br><br><br>
<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Your are logged out now</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD align="center"><A href="ts-logon-start.asp">Click here</A> to go to Login again.</TD>
</TR>
</TABLE>	
</body>
</html>
